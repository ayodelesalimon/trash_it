import 'package:flutter/material.dart';
import 'package:trash_it/Resources/Resources.dart';

import 'Login.dart';
import 'Register.dart';
import 'WithoutCustomerID.dart';

class GetStared extends StatefulWidget {
  const GetStared({ Key? key }) : super(key: key);

  @override
  _GetStaredState createState() => _GetStaredState();
}

class _GetStaredState extends State<GetStared> {
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
                          image: AssetImage('assets/images/new_logo.png'),
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
                     SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    
                                    RegisterScreenPage()
                                    
                                    ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 25,left: 25,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: R.colors
                                      .splashScreenViewPagerSelectedIndicatorColor,
                                  borderRadius: BorderRadius.circular(8)),
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Register With Customer ID',
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterWithCustomerScreenPage()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10, left: 25, right: 25,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: R.colors.splashScreenViewPagerSelectedIndicatorColor),
                                  color: R.colors
                                      .whiteMainColor,
                                  borderRadius: BorderRadius.circular(8)),
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Register Without Customer ID',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: R.colors.splashScreenViewPagerSelectedIndicatorColor),
                                ),
                              ),
                            ),
                          ),
                           SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        R.strings.alreadyHaveAnAccount,
                                        style: TextStyle(
                                            color: R.colors.textBackgroundColor,
                                            fontFamily: R.strings.fontName,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LoginScreenPage()));
                                        },
                                        child: Text(
                                          R.strings.logIn,
                                          style: TextStyle(
                                              color:
                                                  R.colors.splashScreenViewPagerSelectedIndicatorColor,
                                              fontFamily: R.strings.fontName,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                 ]),
          ],
        ),
      ),
    );
  }
}