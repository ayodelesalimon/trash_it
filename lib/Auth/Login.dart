import 'package:flutter/material.dart';
import 'package:trash_it/Auth/Register.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Screens/MainHomeTabPage.dart';
import 'package:trash_it/Widgets/Inputs.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                    child: Container(
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/images/new_logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 30, right: 50, left: 10)),
                SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    SizedBox(
                      height: 80,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        // height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        decoration: BoxDecoration(
                            color: R.colors
                                .splashScreenViewPagerSelectedIndicatorColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Customer Id Number",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                        obscureText: false,
                                        hintText: 'Enter Customer Id Number',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Password", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                        obscureText: true,
                                        hintText: 'Enter Password',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainHomeTabPage()),
                                    );
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
                                              color: R.colors.loginButtonColor),
                                          color: R.colors.loginButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                            color: R.colors.whiteMainColor,
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
                                              color:
                                                  R.colors.textBackgroundColor,
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
                        ]),
                      ),
                    )
                  ],
                ),
              ]),
        ],
      ),
    );
  }
}
