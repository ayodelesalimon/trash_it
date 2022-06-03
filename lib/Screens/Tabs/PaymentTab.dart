import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Models/BillsInfoModel.dart';
import 'package:trash_it/Models/UserProfileModel.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;

import 'PaymentDetailsScreen.dart';

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
  String? paid_status;
  String? invoice_date;
  String? invoice_number;
  String? due_date;
  String? noBiils;
  int? amount;
  String? currency;
  UserProfileModel userProfileModel = UserProfileModel();
  BillsModel? billsInfoModel = BillsModel();
  List? message;
  formatDate({String? date}) {
    final dateData = date != null && date.isNotEmpty
        ? DateFormat.yMMMMd('en_US').format(DateTime.parse(date.split('T')[0]))
        : '';
    return dateData;
  }

  formatShortDate({String? date}) {
    final dateData = date != null && date.isNotEmpty
        ? DateFormat.yMMMd('en_US').format(DateTime.parse(date.split('T')[0]))
        : '';
    return dateData;
  }

  DateTime _parseDateStr(String inputString) {
    DateFormat format = DateFormat.yMMMMd();
    return format.parse(inputString);
  }

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
            ApiUrl.BILLS + '${await getFromLocalStorage(name: 'email')} ',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${await getFromLocalStorage(name: 'token')} ',
          });
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
       //   paid_status = resData["message"]["paid_status"];
          message = resData["message"];
          noBiils = resData["bill_message"];

          // billsInfoModel = resData!;
          //  bills = resData["message"]["1"]["note"];
          //   paid_status = resData["message"]["1"]["paid_status"];
          //   invoice_date = resData["message"]["1"]["invoice_date"];
          //   invoice_number = resData["message"]["1"]["invoice_number"];
          //   due_date = resData["message"]["1"]["due_date"];
          //   amount = resData["message"]["1"]["total"];
          //   currency = resData["message"]["1"]["currency"];
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
          title: Text("Payment"),
          automaticallyImplyLeading: false,
        ),
        body: isLoading 
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 20,
              ))
            : message!.isEmpty
                ? Center(child: Text(noBiils!))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        // scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        //   physics: BouncingScrollPhysics(),
                        itemCount: message!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentDetailScreen(
                                            billsInfoModel: message![index]
                                                ["bill_id"],
                                          )));
                            },
                            child: Container(
                              height: 110,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color(0xFF14459d).withOpacity(0.10),
                                      spreadRadius: 0.5,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(message![index]["invoice_number"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Text(message![index]["currency"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                          Text(
                                              message![index]["total"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    color: paid_status == "Unpaid"
                                        ? Colors.red
                                        : Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                          message![index]["paid_status"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.84)),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text('Amount',
                                        //         style: TextStyle(
                                        //           fontSize: 17,
                                        //           color: Colors.grey,
                                        //         )),
                                        //          Row(
                                        //            children: [
                                        //               Text(currency!,
                                        //                   style: TextStyle(
                                        //                     fontWeight: FontWeight.bold,
                                        //                     fontSize: 20,
                                        //                     color: Colors.grey,
                                        //                   )),
                                        //              Text(amount.toString(),
                                        //     style: TextStyle(
                                        //       fontSize: 20,
                                        //       fontWeight: FontWeight.bold,
                                        //       color: Colors.grey,
                                        //     )),
                                        //            ],
                                        //          ),
                                        //   ],
                                        // ),
                                        SizedBox(height: 1),

                                        Text(

                                            //_parseDateStr(due_date!).toString(),

                                            'Due Date: ${message![index]["due_date"]}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ));
  }
//   taxListTransaction({TaxLiabilityTransactionModelData data, context}) {
//   return
// }
}
