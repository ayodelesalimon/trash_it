import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/AppInfo/GetFaq.dart';
import 'package:trash_it/Auth/Login.dart';
import 'package:trash_it/Screens/iReporter.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NaviationDrawer extends StatefulWidget {
  const NaviationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _NaviationDrawerState createState() => _NaviationDrawerState();
}

class _NaviationDrawerState extends State<NaviationDrawer> {
  String? phone = "";
  String? message =
      "Hello, I am using TrashIt app. Please help me to clean my trash.";
  String? email = "";

  String? fb = "";
  String insta = "";
  String twitter = "";
  String tollFree = "";
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(name);
    print(data);
    return data;
  }

  _launchURL(String? url) async {
    //const url = 'https://flutterdevs.com/';
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail() async {
    launch("mailto:${email}?subject=Subject&body=Hello TrashIT");
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
        // dynamic resData = jsonDecode(response.body);
        // setState(() {
        //   fb = resData["message"]["facebook"];
        //   insta = resData["message"]["instagram"];
        // });
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

  launchWhatsapp() {
    if (Platform.isAndroid) {
      // add the [https]

      return "https://wa.me/$phone/?text=${Uri.parse(message!)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message!)}"; // new line
    }
  }

  Future getMedia() async {
    try {
      final response = await http.get(
        Uri.parse(
          ApiUrl.GET_SOCIAL_MEDIA_LINKS,
        ),
      );
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          fb = resData["message"]["facebook"];
          insta = resData["message"]["instagram"];
          twitter = resData["message"]["twitter"];
        });
      } else {}
    } catch (e) {
      // print(e);

    }
  }

  Future getToll() async {
    try {
      final response = await http.get(
        Uri.parse(
          ApiUrl.GET_TOLL_LINE,
        ),
      );
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          tollFree = resData["message"];
          print(tollFree);
          // fb = resData["message"]["facebook"];
          // insta = resData["message"]["instagram"];
        });
      } else {}
    } catch (e) {
      // print(e);

    }
  }

  Future getInfo() async {
    try {
      final response = await http.get(
        Uri.parse(
          ApiUrl.GET_INFO,
        ),
      );
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          phone = resData["message"]["official_phone"];
          email = resData["message"]["official_email"];
          // fb = resData["message"]["facebook"];
          // insta = resData["message"]["instagram"];
        });
      } else {}
    } catch (e) {
      // print(e);

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedia();
    getInfo();
    getToll();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/drawer_logo.png",
                      ),
                      fit: BoxFit.cover),
                ),
                accountEmail: null,
                accountName: null,
              ),
            ),

            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Image.asset(
                "assets/icons/home.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   leading: Image.asset(
            //     "assets/icons/notification.png",
            //     height: 20,
            //     width: 20,
            //   ),
            //   title: Text(
            //     'Notifications',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            ListTile(
              onTap: () async {
                //   Navigator.pop(context);

                String telephoneNumber = phone!;
                String telephoneUrl = "tel:$telephoneNumber";
                if (await canLaunch(telephoneUrl)) {
                  await launch(telephoneUrl);
                } else {
                  throw "Error occured trying to call that number.";
                }
              },
              leading: Image.asset(
                "assets/icons/dial.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Dial for Complaints',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IReporterScreen();
                }));
              },
              leading: Image.asset(
                "assets/icons/ireporter.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'I-Reporter',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Alerts.show(context, "", "COMING SOON");
              },
              leading: Image.asset(
                "assets/icons/loyality_coin.PNG",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Loyality Coin',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Alerts.show(context, "", "COMING SOON");
              },
              leading: Image.asset(
                "assets/icons/wallet.PNG",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Trash Wallet',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Image.asset(
                "assets/icons/share.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Share this App',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
             ListTile(
              onTap: () async {
                   Navigator.pop(context);
                Alerts.show(context, "", tollFree);
              },
              leading: Image.asset(
                "assets/icons/dial.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Toll Free Number',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GetFaqScreen();
                }));
              },
              leading: Image.asset(
                "assets/icons/faq.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'FAQ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _launchEmail();
              },
              leading: Image.asset(
                "assets/icons/email.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                'Email Us',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Center(
              child: ListTile(
                onTap: () async {
                  await logOut();
                },
                leading: Image.asset(
                  "assets/icons/logout.png",
                  height: 20,
                  width: 20,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _launchURL(fb);
                    },
                    child: Image.asset(
                      "assets/icons/fb.png",
                      height: 30,
                      width: 30,
                    )),
                GestureDetector(
                    child: Image.asset(
                  "assets/icons/tw.png",
                  height: 30,
                  width: 30,
                )),
                GestureDetector(
                    onTap: () {
                      _launchURL(insta);
                    },
                    child: Image.asset(
                      "assets/icons/insta.png",
                      height: 30,
                      width: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchWhatsapp();
                    },
                    child: Image.asset(
                      "assets/icons/wa.png",
                      height: 30,
                      width: 30,
                    )),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            Divider(height: 2, color: Colors.black),
            // SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
