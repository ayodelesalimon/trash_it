import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Auth/Register.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Models/LoginModel.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Screens/Tabs/Tab.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:trash_it/Widgets/Inputs.dart';
import 'package:http/http.dart' as http;

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  TextEditingController emailController = TextEditingController();
  // SharedPreferences prefs = SharedPreferences.getInstance();
  TextEditingController passwordController = TextEditingController();
  bool showObscureText = true;
  Future setToLocalStorage({String? name, dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, data);
  }

// getFromLocalStorage() method will get data from the local storage
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(name);
    return data;
  }

//   Future setToLocalStorage({required String name, dynamic data}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(name, data);
// }
  //TextEditingController descriptionController = TextEditingController();
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  verifyFormAndSubmit() {
    String _email = emailController.text.trim();
    String _password = passwordController.text;

    if (_email == "" || _password == "") {
      Alerts.show(context, "Error", "You need to fill all the fields");
    } else if (EmailValidator.validate(_email) == false) {
      Alerts.show(context, "Error", 'You need to enter a valid email address');
    } else {
      loginUser(_email, _password);
    }
  }

  Future<void> loginUser(String email, String password) async {
    Alerts.showProgressDialog(context, "Processing, Please wait..");
    try {
      final response = await http.post(Uri.parse(ApiUrl.LOGIN),
          body: {"email": email, "password": password});
      print(response.body);
      //  setToLocalStorage(name: 'email', data: email);
      Map<String, dynamic> res = json.decode(response.body);
      LoginModel loginResponse = LoginModel.fromJson(res);
      if (loginResponse.statusCode == 200) {
        print(loginResponse.message!);
        Alerts.show(context, "Success", loginResponse.message!.message);
        String? token = loginResponse.message!.accessToken;
        await setToLocalStorage(name: 'token', data: token);
        await setToLocalStorage(name: 'email', data: email);
        await setToLocalStorage(name: 'password', data: password);
        await FlutterSession().set("token", token);
        //   await setToLocalStorage(name: 'token', data: token);

        print(token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (loginResponse.status == "failed") {
        Navigator.of(context).pop();
        Alerts.show(context, "Error", loginResponse.message!.message);
        print(loginResponse.message!.message);
      } else {
        print(loginResponse.message!.message);
      }
    } catch (exception) {
      Navigator.of(context).pop();
      Alerts.show(context, "Error", exception.toString());
      // Navigator.pop(context);
      // I get no exception here
      print(exception);
    }
  }

  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      child: Container(
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/trashbg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.only(top: 30, right: 50, left: 10)),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30.0, 0, 0),
                    child: Text(
                      R.strings.welcomeText,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15.0, 50, 0),
                    child: Text(
                      R.strings.welcomDescription,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(
                      //   height: 80,
                      // ),
                      Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Email", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Input(
                                      controller: emailController,
                                      obscureText: false,
                                      hintText: 'Enter Email',
                                      //  hintText: StringUtils.phoneHint,
                                      ////  inputIcon: "phone.svg",
                                      keyboard: TextInputType.emailAddress,
                                      onTap: () {},
                                      onChanged: () {},
                                      onSaved: () {},
                                      validator: () {},
                                      toggleEye: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Password", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      keyboardType: TextInputType.text,
                                      obscureText: !this._showPassword,
                                      decoration: InputDecoration(
                                        hintText: "Enter Password",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: R.colors
                                                .splashScreenViewPagerSelectedIndicatorColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: this._showPassword
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() => this._showPassword =
                                                !this._showPassword);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  //                            Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => HomePage()),
                                  // );
                                  verifyFormAndSubmit();
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: R.colors
                                                .splashScreenViewPagerSelectedIndicatorColor),
                                        color: R.colors
                                            .splashScreenViewPagerSelectedIndicatorColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Log In",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: R.colors.whiteMainColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      R.strings.stillNoAccount,
                                      style: TextStyle(
                                          color: R.colors.textBackgroundColor,
                                          fontFamily: R.strings.fontName,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RegisterScreenPage()));
                                      },
                                      child: Text(
                                        R.strings.register,
                                        style: TextStyle(
                                            color: R.colors
                                                .splashScreenViewPagerSelectedIndicatorColor,
                                            fontFamily: R.strings.fontName,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ])
                    ],
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
