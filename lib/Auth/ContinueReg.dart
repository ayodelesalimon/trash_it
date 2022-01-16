import 'package:flutter/material.dart';

class ContinueReg extends StatefulWidget {
  const ContinueReg({ Key? key }) : super(key: key);

  @override
  _ContinueRegState createState() => _ContinueRegState();
}

class _ContinueRegState extends State<ContinueReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continue Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Continue Registration'),
          ],
        ),
      ),
    
      
    );
  }
}