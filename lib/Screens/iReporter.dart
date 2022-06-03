import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:http/http.dart' as http;
import 'package:trash_it/Utils/ApiUrl.dart';

class IReporterScreen extends StatefulWidget {
  const IReporterScreen({Key? key}) : super(key: key);

  @override
  State<IReporterScreen> createState() => _IReporterScreenState();
}

class _IReporterScreenState extends State<IReporterScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController contentController = TextEditingController();
  String? _dropDownValue;
  String? drop;
  final TextEditingController typeController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController mesaageController = new TextEditingController();
  List feedBackList = ["complaint", "feedback", "message"];
  void getDropDownItem() {
    setState(() {
      typeController.text = _dropDownValue!;
    });
  }

  Future getFromLocalStorage({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(name!);
    print(data);
    return data;
  }

  validateandsubmit() async {
    String _message = mesaageController.text;
    String _type = typeController.text;
    String _title = titleController.text;

    if (_message == "" || _type == "" || _title == "") {
      Alerts.show(context, "", "Please fill all the fields before you submit.");
      //  print(contentController.text+emailController.text+titleController.text+titleController.text);
    } else if (_title.length < 5) {
      Alerts.show(context, "", "The title must be at least 5 characters.");
    }

    submitPosttoServer(_message, _type, _title);
  }

  submitPosttoServer(String message, String type, String title) async {
    // Alerts.showProgressDialog(context, t.processingpleasewait);
    try {
      final response = await http.post(Uri.parse(ApiUrl.FEEDBACK), headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getFromLocalStorage(name: 'token')} ',
      }, body: {
        "type": type,
        "title": title,
        "message": message,
      });

      print(response.body);
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        // If the server did return a 200 OK response,
        // then parse the JSON.

        //   Navigator.of(context).pop();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => FeedBackScreen()),
        // );
        print(response.body);
        Map<String, dynamic> res = json.decode(response.body);
        if (res["status"] == "error") {
          Alerts.show(context, "Error", res["message"]);
          Navigator.of(context).pop();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => FeedBackScreen()),
          // );
        } else {
          Alerts.show(context, "Success", res["message"]);
          titleController.text = "";
          mesaageController.text = "";

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => IReporterScreen()),
          // );
        }
        print(res);
      }
    } catch (exception) {
      // Navigator.pop(context);
      // I get no exception here
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('i-Reporter'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: Text(
                      "We would Love to hear from you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(15, 5, 0, 20),
                //     child: Text(
                //       "Share with us reports of the goodness of God in your life.",
                //       style: TextStyles.headline(context).copyWith(
                //         //fontWeight: FontWeight.bold,
                //         fontSize: 14,
                //       ),
                //     ),
                //   ),
                // ),
                Container(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FeedBack Type",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      //   padding: EdgeInsets.only(left: 12, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Select a FeedBack'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _dropDownValue!,
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          items: feedBackList.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val.toString();
                                // _dropDownValue = titleController.value.text;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      "Title",
                    ),
                  ],
                ),
                Container(height: 5),
                Container(
                  //margin: EdgeInsets.all(12),
                  height: 50,
                  child: TextField(
                    controller: titleController,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      // fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Message",
                    ),
                  ],
                ),
                Container(height: 5),
                Container(
                  //margin: EdgeInsets.all(12),
                  height: 5 * 24.0,
                  child: TextField(
                    controller: mesaageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      // fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Row(
                //   children: [
                //     Text("Message",
                //          ),
                //   ],
                // ),
                //   Container(height: 5),
                //   Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(3),
                //     ),
                //     clipBehavior: Clip.antiAliasWithSaveLayer,
                //     margin: EdgeInsets.all(0),
                //     elevation: 0,
                //     child: Container(
                //       height: 150,
                //       decoration: BoxDecoration(
                //         color: Colors.grey[100],
                //         borderRadius: BorderRadius.circular(5),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black45,
                //             blurRadius: 0,
                //           )
                //         ],
                //       ),
                //       alignment: Alignment.centerLeft,
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       child:  TextFormField(

                //       ///maxLines: 1,
                //         keyboardType: TextInputType.text,
                //        controller: contentController,
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.all(2),
                //           border: InputBorder.none,
                //         ),
                //       ),
                //     ),
                //   ),

                SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  onTap: () {
                    getDropDownItem();
                    validateandsubmit();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Container(
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
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: R.colors.whiteMainColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
