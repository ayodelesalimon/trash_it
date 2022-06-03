import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;

import 'PaymentHistoryDetails.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  bool isLoading = false;
  bool isError = false;
  String? noBills;
  List? message;

  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(name!);
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
            ApiUrl.GET_PAYMENTS,
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
          message = resData['message'];
          noBills = resData['payment_message'];
          print(resData);
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
    getPayment().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading 
      ? Center(
                child: CupertinoActivityIndicator(
                radius: 20,
              ))
            : message!.isEmpty
                ? Center(child: Text(noBills!))
                : ListView.builder(
                    itemCount: message!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentHistoryDetails(message: message![index],)));
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(message![index]['payment_id'].toString(),   style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Text(message![index]['payment_date']),
                            trailing: Text(message![index]['currency']+message![index]['amount'].toString(),   style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),

                          ),
                        ),
                      );
                    },
                  ),
    );
  }
}
