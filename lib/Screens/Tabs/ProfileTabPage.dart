import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Auth/Login.dart';
import 'package:trash_it/Constants/LayoutController.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Models/UserProfileModel.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:trash_it/Widgets/CustomRaisedButton.dart';
import 'package:http/http.dart' as http;
import 'package:trash_it/Widgets/Inputs.dart';

class ProfileTabPage extends StatefulWidget {
  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController fisrtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController localGovtController = TextEditingController();
  bool isLoading = true;
  bool isError = false;
  String? token;
  UserProfileModel userProfileModel = UserProfileModel();
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(name!);
    print(data);
    return data;
  }

  Future setToLocalStorage({String? name, dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name!, data);
  }

  Future logOut() async {
    try {
      final response = await http.get(
          Uri.parse(
            ApiUrl.SIGN_OUT,
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await getFromLocalStorage(name: 'token')} ',
          });

      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => LoginScreenPage(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => LoginScreenPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      // print(e);

    }
  }

  Future getUserProfile() async {
    setState(() {
      isLoading = true;
    });
    print(await getFromLocalStorage(name: 'email'));
    try {
      final response = await http.get(
          Uri.parse(
            ApiUrl.PROFILE + '${await getFromLocalStorage(name: 'email')} ',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await getFromLocalStorage(name: 'token')} ',
          });
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        if (resData == null) {
          print("object is null${resData}");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => LoginScreenPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          setState(() {
            setToLocalStorage(
                name: 'firstName', data: resData["message"]["first_name"]);
            isLoading = false;
            customerIdController.text = resData["message"]["customer_id"];
            fisrtNameController.text = resData["message"]["first_name"];
            lastNameController.text = resData["message"]["last_name"];
            emailController.text = resData["message"]["email"];
            phoneController.text = resData["message"]["phone"];
          });
          print(resData);
        }
        // ignore: unnecessary_null_comparison
      }
      setState(() {
        isLoading = false;
        isError = true;
      });
    } catch (e) {
      // print(e);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getToken();

    getUserProfile().whenComplete(() => null);
    // logOut().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 20,
              ))
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      //  Text("hhhhh"),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("Customer ID", style: textStyleBold),
                            SizedBox(
                              height: 10,
                            ),
                            Input(
                              enable: false,
                              controller: customerIdController,
                              obscureText: false,
                              hintText:
                                  'Enter Customer Id (As it appears on the bill)',
                              keyboard: TextInputType.emailAddress,
                              onTap: () {},
                              onChanged: () {},
                              onSaved: (val) {
                                //customerId = val;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Customer Id is required';
                                }
                                return null;
                              },
                              toggleEye: () {},
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      //   ],
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("First Name ", style: textStyleBold),
                            SizedBox(
                              height: 10,
                            ),
                            Input(
                              enable: false,
                              controller: fisrtNameController,
                              obscureText: false,
                              hintText:
                                  'Enter First Name (As it appears on the bill)',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Last Name ", style: textStyleBold),
                            SizedBox(
                              height: 10,
                            ),
                            Input(
                              enable: false,
                              controller: lastNameController,
                              obscureText: false,
                              hintText:
                                  'Enter Last Name (As it appears on the bill)',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: textStyleBold),
                            SizedBox(
                              height: 10,
                            ),
                            Input(
                              enable: false,
                              controller: emailController,
                              obscureText: false,
                              hintText: 'Enter Email',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mobile Number", style: textStyleBold),
                            SizedBox(
                              height: 10,
                            ),
                            Input(
                              enable: false,
                              controller: phoneController,
                              obscureText: false,
                              hintText: 'Enter Mobile Number',
                              keyboard: TextInputType.emailAddress,
                              onTap: () {},
                              onChanged: () {},
                              onSaved: () {},
                              validator: () {},
                              toggleEye: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Alerts.signOut(context, "Logout",
                                      "Do you want to Logout of the App",
                                      () async {
                                    await logOut();
                                  });
                                  // showCupertinoDialog(context: context, bu())
                                  //  await logOut();
                                },
                                child: Center(
                                    child: Text(
                                  "Log out",
                                  style: TextStyle(color: Colors.red),
                                )),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ));
  }
}
