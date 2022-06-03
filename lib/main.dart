import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/landing_page.dart';

import 'Auth/AutoLogin.dart';
import 'Auth/Login.dart';
import 'Screens/Tabs/Tab.dart';

int? isviewed;
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash It',
      theme: ThemeData(
      fontFamily: "Lato",
        primarySwatch: Colors.teal,
      ),
       home: isviewed != 0 ? LandingPageScreen() : AutoLoginScreen(),
    );
  }
}

