import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Models/FaqModel.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;

class GetFaqScreen extends StatefulWidget {
  const GetFaqScreen({Key? key}) : super(key: key);

  @override
  State<GetFaqScreen> createState() => _GetFaqScreenState();
}

class _GetFaqScreenState extends State<GetFaqScreen> {
  bool isLoading = false;
  bool isError = false;
  List? message = [];
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(name);
   // print(data);
    return data;
  }

  Future getFaq() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
          Uri.parse(
            ApiUrl.FAQ,
          ),
        );
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic  resData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          message = resData["message"];
          
        });
      
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      // print(e);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }
  
 @override
  void initState() {
    super.initState();
    //  getToken();
    getFaq().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faq"),
        //automaticallyImplyLeading: false,
      ),
      body: 
       isLoading
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 20,
              )) :
      Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
       //   physics: BouncingScrollPhysics(),
        itemCount: message!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFaqCard(message![index]);
          
          //Text(message![index]["title"]!, style: TextStyle(fontSize: 20),);
        },
      ),
        
      ),
    );
  }
  Widget _buildFaqCard( Map<String, dynamic> message) {
    return Card(
      child: ExpansionTile(
        title: Text(
          message["title"],
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        children: <Widget>[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message["body"],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

}
