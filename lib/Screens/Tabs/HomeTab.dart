import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_updater/native_updater.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Resources/Resources.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:trash_it/Widgets/Drawer.dart';

import '../../Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String lastName = "";
  String email = "";
  final List carouselimages = [
    "assets/images/1.jpeg",
    "assets/images/2.jpeg",
    "assets/images/3.jpeg",
    "assets/images/screen.png"
  ];
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();
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
                style: TextStyle(color: Color(0xFF008080)),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: new Text(
                    'Yes',
                    style: TextStyle(color: Color(0xFF008080)),
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

  Future getUserProfile() async {
    setState(() {});
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

        setState(() {
          setToLocalStorage(
              name: 'firstName', data: resData["message"]["first_name"]);
          setToLocalStorage(name: 'email', data: resData["message"]["email"]);
        });
        print(resData);
      }
      // ignore: unnecessary_null_comparison

    } catch (e) {
      // print(e);
      setState(() {});
    }
  }
//  Future<void> checkVersion() async {
//     /// For example: You got status code of 412 from the
//     /// response of HTTP request.
//     /// Let's say the statusCode 412 requires you to force update
//     int statusCode = 412;

//     /// This could be kept in our local
//     int localVersion = 9;

//     /// This could get from the API
//     int serverLatestVersion = 10;

//     Future.delayed(Duration.zero, () {
//       if (statusCode == 412) {
//         NativeUpdater.displayUpdateAlert(
//           context,
//           forceUpdate: true,
//           appStoreUrl: '<Your App Store URL>',
//           playStoreUrl: '<Your Play Store URL>',
//           iOSDescription: '<Your iOS description>',
//           iOSUpdateButtonLabel: 'Upgrade',
//           iOSCloseButtonLabel: 'Exit',
//         );
//       } else if (serverLatestVersion > localVersion) {
//         NativeUpdater.displayUpdateAlert(
//           context,
//           forceUpdate: false,
//           appStoreUrl: '<Your App Store URL>',
//           playStoreUrl: '<Your Play Store URL>',
//           iOSDescription: '<Your description>',
//           iOSUpdateButtonLabel: 'Upgrade',
//           iOSIgnoreButtonLabel: 'Next Time',
//         );
//       }
//     });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
    NativeUpdater.displayUpdateAlert(
      context,
      forceUpdate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
            endDrawerEnableOpenDragGesture: false,
            key: _scaffoldKey,
            drawer: NaviationDrawer(),
            body:

                //  Stack(
                //   children: [
                Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/homebg.PNG"),
                fit: BoxFit.cover,
              )),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 20),
                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )),
      ),
    );
  }
}
