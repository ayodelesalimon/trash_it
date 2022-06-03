import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:trash_it/Auth/Login.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Models/OperatorModel.dart';
import 'package:trash_it/Models/RegisterModel.dart';
import 'package:trash_it/Models/ValidateCustomerModel.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Screens/MainHomeTabPage.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:trash_it/Utils/ApiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:trash_it/Widgets/DropDown.dart';
import 'package:trash_it/Widgets/Inputs.dart';

import 'ContinueReg.dart';
import 'OTPScreen.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({Key? key}) : super(key: key);

  @override
  _RegisterScreenPageState createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final formKey = new GlobalKey<FormState>();
  String? operator;
  String? propertyType;
  int? companyId;
  String? ward;
  String? lga;
  String? propertyDescription;
  bool isLoading = false;
  bool isError = false;
  late OperatorModel operatorList;
  List proType = ['Residential', 'Industrial'];
  List? propertyList = [];
  List? wardList = [];
  List? lgaList = [];
  String phone = '';
  bool showObscureText = true;
  bool showObscureText1 = true;
  TextEditingController fisrtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController localGovtController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getOperatorList() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(ApiUrl.OPERATORS_LIST));
      if (response.statusCode == 200) {
        dynamic res = jsonDecode(response.body);
        print(res);
        setState(() {
          propertyList = res;
          print(propertyList);
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future getWardList() async {
    setState(() {
      isLoading = true;
    });
    try {
      // final dio = Dio();
      final response = await http.get(Uri.parse(ApiUrl.WARDS));
      if (response.statusCode == 200) {
        dynamic res = jsonDecode(response.body);
        print(res);
        setState(() {
          wardList = res;
          print(wardList);
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future getLgaList() async {
    setState(() {
      isLoading = true;
    });
    try {
      // final dio = Dio();
      final response = await http.get(Uri.parse(ApiUrl.LGA));
      if (response.statusCode == 200) {
        dynamic res = jsonDecode(response.body);
        print(res);
        setState(() {
          lgaList = res;
          print(lgaList);
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future getInfo() async {
    try {
      final response = await http.get(
        Uri.parse(
          ApiUrl.GET_INFO,
        ),
      );
      // UserProfileModel profileModel = UserProfileModel.fromJson(response);
      print(response.body);
      if (response.statusCode == 200) {
        dynamic resData = jsonDecode(response.body);
        setState(() {
          phone = resData["message"]["official_phone"];
          // email = resData["message"]["official_email"];
          // fb = resData["message"]["facebook"];
          // insta = resData["message"]["instagram"];
        });
      } else {}
    } catch (e) {
      // print(e);

    }
  }

  registerUser() {
    String _customerId = customerIdController.text.trim();
    String _lastName = lastNameController.text.trim();
    String _firstName = fisrtNameController.text.trim();
    String _companyId = companyId!.toString();
    String _email = emailController.text.trim();
    String _phone = phoneController.text.trim();
    String _password = passwordController.text.trim();

    if (_customerId == "" ||
        _lastName == "" ||
        _firstName == "" ||
        _companyId == "" ||
        _email == "" ||
        _phone == "" ||
        _password == "") {
      Alerts.show(context, "Error", "Please fill all the fields");
    } else {
      registerUserId(_customerId, _lastName, _firstName, _companyId, _email,
          _phone, _password);
    }
  }

  Future<void> registerUserId(
    String customerId,
    String lastName,
    String firstName,
    String companyId,
    String email,
    String phone,
    String password,
  ) async {
    //  Alerts.showProgressDialog(context, "Processing, Please wait..");
    try {
      final response = await http.post(Uri.parse(ApiUrl.REGISTER), body: {
        "customer_id": customerId,
        "first_name": firstName,
        "last_name": lastName,
        "company_id": companyId,
        "email": email,
        "password": password,
        "phone": phone
      });
      // print(response.reasonPhrase);
      // print(response);
      // print(response.body);
      // print(response.statusCode);

      // Navigator.of(context).pop();
      print(response.body);
      Map<String, dynamic> res = json.decode(response.body);
      RegisterModel registerResponse = RegisterModel.fromJson(res);

      if (registerResponse.statusCode == 200 ||
          registerResponse.status == "success") {
        showModalBottomSheet(
            enableDrag: true,
            backgroundColor: Colors.transparent,
            context: context,
            //  expand: false,
            isDismissible: true,
            //  topRadius: Radius.circular(30),
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: MediaQuery.of(context).viewInsets,
                  child: PinCodeVerificationScreen(emailController.text));
            });
      } else if (registerResponse.status == "failed") {
        //    Alerts.show(context, "Error", registerResponse.message!.customerId![0]);
      } else if (registerResponse.status == "success") {
        ///Navigator.of(context).pop();
        // Alerts.show(context, "Error", res["message"]);
      } else {}
      print(res);
    } catch (exception) {
      //  Navigator.of(context).pop();
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    // getOperatorList();
    // getLgaList();
    // getWardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                  child: Center(
                    child: Container(
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/images/trashbg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, left: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30.0, 0, 0),
                    child: Text(
                      R.strings.welcomeText,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15.0, 20, 0),
                    child: Text(
                      R.strings.welcomDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        //  height: MediaQuery.of(context).size.height ,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text("Customer ID",
                                            style: textStyleBold),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Input(
                                                controller:
                                                    customerIdController,
                                                obscureText: false,
                                                hintText:
                                                    'Enter Customer Id (As it appears on the bill)',
                                                keyboard:
                                                    TextInputType.emailAddress,
                                                onTap: () {},
                                                onChanged: () {},
                                                onSaved: (val) {
                                                  //customerId = val;
                                                },
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Customer Id is required';
                                                  }
                                                  return null;
                                                },
                                                toggleEye: () {},
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                validateWithId();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    color: R.colors
                                                        .splashScreenViewPagerSelectedIndicatorColor),
                                                child: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                                height: 58,
                                                width: 55,
                                                // color: Colors.green,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          R.strings.alreadyHaveAnAccount,
                                          style: TextStyle(
                                              color:
                                                  R.colors.textBackgroundColor,
                                              fontFamily: R.strings.fontName,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LoginScreenPage()));
                                          },
                                          child: Text(
                                            R.strings.logIn,
                                            style: TextStyle(
                                                color: R.colors
                                                    .splashScreenViewPagerSelectedIndicatorColor,
                                                fontFamily: R.strings.fontName,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "If you don't have a Customer ID",
                                          style: TextStyle(
                                              color:
                                                  R.colors.textBackgroundColor,
                                              fontFamily: R.strings.fontName,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // showModalBottomSheet(
                                            //   context: context,
                                            //   builder: (context) {
                                            //     return Container(
                                            //       height: 200,
                                            //       child: Wrap(
                                            //         children: [
                                            //           ListTile(
                                            //             leading:
                                            //                 Icon(Icons.phone),
                                            //             title: Text(phone),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     );
                                            //   },
                                            // );
                                            Alerts.show(
                                                context, "Contact Us", phone);
                                          },
                                          child: Text(
                                            " Click Here",
                                            style: TextStyle(
                                                color: R.colors
                                                    .splashScreenViewPagerSelectedIndicatorColor,
                                                fontFamily: R.strings.fontName,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  validateWithId() {
    String _customerId = customerIdController.text.trim();

    if (_customerId == "") {
      Alerts.show(context, "Error", "Customer Id is required");
    } else if (_customerId.length < 6) {
      Alerts.show(context, "Error", "Customer Id must be 6 digits");
    } else {
      validateUser(
        _customerId,
      );
    }
  }

  Future<void> validateUser(
    String customerId,
  ) async {
    Alerts.showProgressDialog(context, "Processing, Please wait..");
    try {
      final response = await http.post(Uri.parse(ApiUrl.VALIDATE_CUSTOMER),
          body: {"customer_id": customerId});
      print(response.body);
      Map<String, dynamic> res = json.decode(response.body);
      ValidateCustomerModel decoded = ValidateCustomerModel.fromJson(res);
      if (decoded.statusCode == 200) {
        print(decoded.status);
        Navigator.of(context).pop();
        Alerts.continueReg(context, "Success", decoded.responseType, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ContinueRegistrationScreen(
                        customerIdController.text.trim(),
                        decoded.message!.email!,
                        decoded.message!.firstName!,
                        decoded.message!.lastName!,
                        // decoded.message!.phone!.toString(),
                        decoded.message!.ward!.wardName!,
                        decoded.message!.localGovt!.lgName!,
                        decoded.message!.company!.companyName!,
                        decoded.message!.company!.companyId!,
                        decoded.message!.propertyType!,
                      )));
        });
        // Navigator.of(context).pop();

        // fisrtNameController.text = decoded.message!.firstName!;
        // lastNameController.text = decoded.message!.lastName!;
        // emailController.text = decoded.message!.email!;

        // operator = decoded.message!.company!.companyName!;
        // companyId = int.parse(decoded.message!.company!.companyId!);
        // propertyType = decoded.message!.propertyType!;
        // ward = decoded.message!.ward!.wardName!;
        // lga = decoded.message!.localGovt!.lgName!;
        //  phoneController.text = "07606060".toString();
      } else if (decoded.status == "failed") {
        Navigator.of(context).pop();
        Alerts.show(context, "Error", decoded.responseType);
      } else {
        Alerts.show(context, "Error", "Something went wrong");
      }
    } catch (exception) {
      Navigator.of(context).pop();
      print(exception);
    }
  }
}
