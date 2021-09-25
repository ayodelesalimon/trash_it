import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trash_it/Resources/Colors.dart';
import 'package:trash_it/Auth/Login.dart';
import 'Auth/Register.dart';
import 'Resources/Resources.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final controller = PageController(viewportFraction: 1.0);
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: new AlertDialog(
              title: new Text(
                'Exit App',
                style: TextStyle(color: Color(0xFFFF9E00)),
              ),
              content: new Text(
                'Do you want to exit the App?',
                style: TextStyle(color: Color(0xFF2788E9)),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: new Text(
                    'Yes',
                    style: TextStyle(color: Color(0xFF2788E9)),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: new Text(
                    'No',
                    style: TextStyle(color: Color(0xFFFF9E00)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: R.colors.whiteMainColor,
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(right: 30, left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: PageView(
                              controller: controller,
                              children: [
                                swipeable(
                                    image: 'logo.png',
                                    title: 'Keep Your Trash Ready',
                                    sub:
                                        'Keeping Your surrounding clean will Keep you Health Clean'),
                                swipeable(
                                    image: 'logo.png',
                                    title: 'Keep Your Ready Trash',
                                    sub:
                                        "Clean Keeping surrounding clean will Keep you Health Clean"),
                                swipeable(
                                    image: 'logo.png',
                                    title: 'Ready Trash Keep',
                                    sub:
                                        "Keeping Your surrounding clean will Keep you Health Clean"),
                              ],
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            effect: SlideEffect(
                                spacing: 8.0,
                                radius: 4.0,
                                dotWidth: 20.0,
                                dotHeight: 5.0,
                                strokeWidth: 1.5,
                                dotColor: Color(0xFFE6ECF0),
                                activeDotColor: R.colors
                                    .splashScreenViewPagerSelectedIndicatorColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreenPage()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
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
                                  'Get Started',
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
                                    builder: (context) => LoginScreenPage()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
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
                                  'Log in',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: R.colors.splashScreenViewPagerSelectedIndicatorColor),
                                ),
                              ),
                            ),
                          ),
                          // button(
                          //     bgColor: Colors.white,
                          //     borderColor: R.colors
                          //         .splashScreenViewPagerSelectedIndicatorColor,
                          //     text: 'Login',
                          //     //route: 'login',
                          //     context: context),
                        ]),
                  ),
                ),
              ],
            ),
          )
          //   },
          // ),
          ),
    );
  }

  button({
    text,
    route,
    context,
    required Color borderColor,
    required Color bgColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: bgColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: borderColor),
          ),
        ),
      ),
    );
  }

  swipeable({image, title, sub}) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    return _mediaQueryData.size.height <= 599
        ? Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                //  onTap: () => _launchSignUp(),
                child: Image.asset(
                  'assets/images/$image',
                  width: 130,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    color: R.colors.splashScreenViewPagerSelectedIndicatorColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                sub,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    color: lightGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ]),
          )
        : (_mediaQueryData.size.height <= 700)
            ? Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        //  onTap: () => _launchSignUp(),
                        child: Image.asset(
                          'assets/images/$image',
                          width: 170,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: R.colors
                                .splashScreenViewPagerSelectedIndicatorColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sub,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5,
                            color: lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              )
            : Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        //  onTap: () => _launchSignUp(),
                        child: Image.asset(
                          'assets/images/$image',
                          width: 230,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: R.colors
                                .splashScreenViewPagerSelectedIndicatorColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sub,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5,
                            color: lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              );
  }
}
