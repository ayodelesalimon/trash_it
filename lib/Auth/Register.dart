import 'package:flutter/material.dart';
import 'package:trash_it/Auth/Login.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Widgets/Inputs.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({Key? key}) : super(key: key);

  @override
  _RegisterScreenPageState createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final formKey = new GlobalKey<FormState>();
  String? _dropDownValue;
  String? propertyType;
  String? propertyDescription;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                  child: Container(
                    height: 150,
                    child: Image(
                      image: AssetImage('assets/images/new_logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, left: 10)),
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
                  SingleChildScrollView(
                    child: Container(
                      // height: MediaQuery.of(context).size.height ,
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      decoration: BoxDecoration(
                          color: R.colors
                              .splashScreenViewPagerSelectedIndicatorColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        key: formKey,
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
                                      Text("First Name", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                         obscureText: false,
                                        hintText:
                                            'Enter First Name (As it appears on the bill)',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Last Name ", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                         obscureText: false,
                                        hintText:
                                            'Enter Last Name (As it appears on the bill)',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Customer Id Number",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                         obscureText: false,
                                        hintText:
                                            'Enter Customer Id Number (As it appears on the bill)',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Email", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                        obscureText: false,
                                        hintText: 'Enter Email',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Mobile Number",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                        obscureText: false,
                                        hintText: 'Enter Mobile Number',
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Service Provider",
                                        style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: _dropDownValue == null
                                              ? Text('Select Service Provider')
                                              : Text(
                                                  _dropDownValue!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: [
                                            'Lawma1',
                                            'Lawma2',
                                            'Lawma3',
                                            'Lawma4',
                                            'Lawma5',
                                            'Lawma6'
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                _dropDownValue = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Property Type", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: propertyType == null
                                              ? Text('Select Property Type')
                                              : Text(
                                                  propertyType!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items:
                                              ['Residential', 'Industrial'].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                propertyType = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Property Description",
                                        style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: propertyDescription == null
                                              ? Text(
                                                  'Select Property Description')
                                              : Text(
                                                  propertyType!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: [
                                            'Three bedroom',
                                            'Two bedroom',
                                            'Duplex bedroom',
                                            'Two bedroom'
                                          ].map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                propertyDescription = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      Text("Password",
                                          style: textStyleBold),
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
                                SizedBox(
                                        height: 5,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Confirm Password",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InputWidget(
                                        obscureText: true,
                                        hintText: 'Confirm Password',
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
                                              LoginScreenPage()),
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
                                          "Sign Up",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              color: R.colors.whiteMainColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(R.strings.alreadyHaveAnAccount, style: TextStyle(
                                      color: R.colors.whiteMainColor,
                                      fontFamily: R.strings.fontName,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400
                                  ),)
                                  , GestureDetector(
                                    onTap: () {
                   Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
                },
                                    child: Text(R.strings.logIn, style: TextStyle(
                                        color: R.colors.textBackgroundColor,
                                        fontFamily: R.strings.fontName,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400
                                        ),),
                                  )
                                ],
                              ),
                            )
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
