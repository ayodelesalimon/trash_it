import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trash_it/Resources/Resources.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:trash_it/Widgets/Drawer.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
            endDrawerEnableOpenDragGesture: false,
            key: _scaffoldKey,
            //appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {
            //     _scaffoldKey.currentState!.openDrawer();
            //   },
            //   // alignment: Alignment.topCenter,
            //   icon: Icon(Icons.menu),
            // ),
            // backgroundColor: R.colors.splashScreenViewPagerSelectedIndicatorColor,
            // title: Text("HOME"),
            // automaticallyImplyLeading: false,
            //  ),
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
              //   child: Image.asset("assets/images/trash.jpg", fit: BoxFit.cover,)

              // CarouselSlider.builder(
              //   key: _sliderKey,
              //   itemCount: carouselimages.length,
              //   options: CarouselOptions(
              //     height: MediaQuery.of(context).size.height,
              //     autoPlay: true,
              //     enlargeCenterPage: true,
              //     viewportFraction: 0.9,
              //     aspectRatio: 1.0,
              //     initialPage: 0,
              //   ),
              //   itemBuilder: (BuildContext context, int index, int realIndex) {
              //     return Container(
              //       height: MediaQuery.of(context).size.height,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(

              //           image: AssetImage(carouselimages[index]),
              //           fit: BoxFit.fitWidth,
              //         ),
              //       ),
              //       //color: colors[index],
              //       // child: Image.asset(
              //       //   carouselimages[index], fit: BoxFit.contain,
              //       //),
              //     );
              //   },
              // ),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset("assets/images/trashbg.png", width: 300, height: 250,),
              //   ],
              // )
              //   ],
              // ),
            )),
      ),
    );
  }
}
