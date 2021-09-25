import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_it/Constants/LayoutController.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Widgets/CustomRaisedButton.dart';

class ProfileTabPage extends StatefulWidget {
  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                image: AssetImage('assets/images/mask_profile.png'),
                fit: BoxFit.cover,
              )),
        ),
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: LayoutController.getHeight(
                (MediaQuery.of(context).size.height - 60),
                minHeight: 740),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(
                      color: R.colors.whiteMainColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              R.strings.personalInformation,
                              style: TextStyle(
                                  color: R.colors.homeTextColor,
                                  fontFamily: R.strings.fontName,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Text("Test User"),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Text("user@gmail.com"),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Text("09040439234"),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 30),
                          child: ButtonTheme(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width - 40,
                            child: CustomRaisedButton(
                              text: R.strings.logOut,
                              color: R.colors
                                  .splashScreenViewPagerSelectedIndicatorColor,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
