import 'package:flutter/material.dart';
import 'package:trash_it/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash It',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: LandingPageScreen(),
    );
  }
}

