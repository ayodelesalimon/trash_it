import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Models/BillsInfoModel.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:http/http.dart' as http;
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailScreen extends StatefulWidget {
  PaymentDetailScreen({Key? key, this.billsInfoModel}) : super(key: key);
  int? billsInfoModel;

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  bool isLoading = false;
  bool isError = false;
  String? message;
  int? amount;
  int? serviceCharge;
  String? property;
  int? price;
  int? month;
  int? total;
  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(name!);
    print(data);
    return data;
  }

  _launchURL(String? url) async {
    //const url = 'https://flutterdevs.com/';
    // if (await canLaunch(url!)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
     if (!await launch(
      url!,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  Future getPaymentBreakDown() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse(
            ApiUrl.BILL_DETAILS + '${widget.billsInfoModel}',
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
          message = resData["message"]["payment_link"];
          amount = resData["message"]["bill_amount"];
          serviceCharge = resData["message"]["service_charge"];
          property = resData["message"]["bill_breakdown"][0]["property_name"];
          price = resData["message"]["bill_breakdown"][0]["property_price"];
          month = resData["message"]["bill_breakdown"][0]["no_of_months"];

          total = amount! + serviceCharge!;
        });
        // print(billsInfoModel!.status!);
        //   print(resData);
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
    getPaymentBreakDown().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(
              radius: 20,
            ))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Property Type",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(property!),
                          ]),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "No of Month",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(month!.toString()),
                          ]),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Property Price",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(price!.toString()),
                          ]),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service Charge",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(serviceCharge!.toString()),
                          ]),
                          SizedBox(height: 8),
                      Divider(
                        height: 1,
                        thickness: 2,
                      ),
                      SizedBox(height: 12),
                      
                      
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text("NGN ${total!.toString()}",  style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),),
                          ]),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL(message!);
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: R.colors
                                  .splashScreenViewPagerSelectedIndicatorColor),
                          color: R.colors
                              .splashScreenViewPagerSelectedIndicatorColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Pay Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
