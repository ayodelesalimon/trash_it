import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Models/UserProfileModel.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  bool isError = false;
  String? token;
  String? bills;
  UserProfileModel userProfileModel = UserProfileModel();
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(name);
    print(data);
    return data;
  }

  Future getPayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse(
            ApiUrl.BILLS + '${await getFromLocalStorage(name: 'email')} ',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await getFromLocalStorage(name: 'token')} ',
          });
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          bills = resData["message"][0];
        });

        print(resData);
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
    // TODO: implement initState
    super.initState();
    //  getToken();
    getPayment().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading ?  Center(
          child: CupertinoActivityIndicator(
        radius: 20,
      )) : Center(
        child: Text(bills!),
      ),
    );
  }
}
