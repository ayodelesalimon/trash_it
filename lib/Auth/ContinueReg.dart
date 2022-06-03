import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:trash_it/Auth/Login.dart';
import 'package:trash_it/Constants/TextStyle.dart';
import 'package:trash_it/Models/ErrorModel.dart';
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

import 'OTPScreen.dart';

// ignore: must_be_immutable
class ContinueRegistrationScreen extends StatefulWidget {
  ContinueRegistrationScreen(
    this.customerid,
    this.email,
    this.firstName,
    this.lastName,
    // this.phoneNumber,
    this.ward,
    this.lga,
    this.serviceProvider,
    this.operatorId,
    this.propertyType,
  );
  String customerid;
  String firstName;
  String lastName;
  String email;
  // String? phoneNumber;
  String serviceProvider;
  String ward;
  String lga;
  String operatorId;
  String propertyType;

  @override
  _ContinueRegistrationScreenState createState() =>
      _ContinueRegistrationScreenState();
}

class _ContinueRegistrationScreenState
    extends State<ContinueRegistrationScreen> {
  final formKey = new GlobalKey<FormState>();
  String? operator;
  String? propertyType;
  String? companyId;
  String? ward;
  String? lga;
  String? propertyDescription;
  bool isLoading = false;
  bool isError = false;
  late OperatorModel operatorList;
  ErrorModel? errorModel;
  List proType = ['Residential', 'Industrial'];
  List? propertyList = [];
  List? wardList = [];
  List? lgaList = [];
  bool _showPassword = false;
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

  
  registerUser() {
    String _customerId = customerIdController.text.trim();
    String _lastName = lastNameController.text.trim();
    String _firstName = fisrtNameController.text.trim();
    String _companyId = companyId.toString();
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
      } else if (registerResponse.statusCode == 403) {
        print(response.body);
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
        // Alerts.show(context, "Error", errorModel!.status);
      } else if (registerResponse.status == "success") {
       
      } else {}
      print(res);
    } catch (exception) {
      //  Navigator.of(context).pop();
      print(exception);
    }
  }

  @override
  void initState() {
    //  print(widget.phoneNumber);
    customerIdController.text = widget.customerid;
    fisrtNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    emailController.text = widget.email;
    companyId = widget.operatorId;
    operator = widget.serviceProvider;

    //  companyId = int.parse(widget.company!.companyId!);
    propertyType = widget.propertyType;
    ward = widget.ward;
    lga = widget.lga;
   
    super.initState();

 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                  child: Container(
                    height: 150,
                    child: Image(
                      image: AssetImage('assets/images/trashbg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, left: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: EdgeInsets.fromLTRB(20, 15.0, 50, 0),
                    child: Text(
                      R.strings.welcomDescription,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Customer ID", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Input(
                                    enable: false,
                                    controller: customerIdController,
                                    obscureText: false,
                                    hintText:
                                        'Enter Customer Id (As it appears on the bill)',
                                    keyboard: TextInputType.emailAddress,
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("First Name ", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Input(
                                    enable: false,
                                    controller: fisrtNameController,
                                    obscureText: false,
                                    hintText:
                                        'Enter First Name (As it appears on the bill)',
                                    keyboard: TextInputType.emailAddress,
                                    onTap: () {},
                                    onChanged: () {},
                                    onSaved: () {},
                                    validator: () {},
                                    toggleEye: () {},
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Last Name ", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Input(
                                    enable: false,
                                    controller: lastNameController,
                                    obscureText: false,
                                    hintText:
                                        'Enter Last Name (As it appears on the bill)',
                                    keyboard: TextInputType.emailAddress,
                                    onTap: () {},
                                    onChanged: () {},
                                    onSaved: () {},
                                    validator: () {},
                                    toggleEye: () {},
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Input(
                                    enable: true,
                                    controller: emailController,
                                    obscureText: false,
                                    hintText: 'Enter Email',
                                    keyboard: TextInputType.emailAddress,
                                    onTap: () {},
                                    onChanged: () {},
                                    onSaved: () {},
                                    validator: () {},
                                    toggleEye: () {},
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mobile Number", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Input(
                                    //  enable: false,
                                    controller: phoneController,
                                    obscureText: false,
                                    hintText: 'Enter Mobile Number',
                                    keyboard: TextInputType.phone,
                                    onTap: () {},
                                    onChanged: () {},
                                    onSaved: (String? value) {
                                      if (value!.isEmpty) {
                                        // ignore: unnecessary_statements
                                        'Phone is required';
                                      } else if (value.length < 11) {
                                        'Phone must be at least 11 characters'
                                            .toString();
                                      }
                                      return null;
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Phone is required';
                                      } else if (value.length < 11) {
                                        return 'Phone must be at least 11 characters'
                                            .toString();
                                      }
                                      return null;
                                    },
                                    toggleEye: () {},
                                  ),
                                ],
                              ),
                            ),
                           
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Password", style: textStyleBold),
                                  SizedBox(
                                    height: 5,
                                  ),
                                 

                                  TextFormField(
                                    onSaved: (String? value) {
                                      if (value!.isEmpty) {
                                        // ignore: unnecessary_statements
                                        'Password is required';
                                      } else if (value.length < 8) {
                                        'Password must be at least 6 characters'
                                            .toString();
                                      }
                                      return null;
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Password is required';
                                      } else if (value.length < 8) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: !this._showPassword,
                                    decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: R.colors
                                              .splashScreenViewPagerSelectedIndicatorColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: this._showPassword
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() => this._showPassword =
                                              !this._showPassword);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                           
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                 
                                  registerUser();
                                 
                                }
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
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: R.colors.whiteMainColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    R.strings.alreadyHaveAnAccount,
                                    style: TextStyle(
                                        color: R.colors.textBackgroundColor,
                                        fontFamily: R.strings.fontName,
                                        fontSize: 17,
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
                                          fontSize: 17,
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
        Alerts.show(context, "Success", decoded.responseType);
        // fisrtNameController.text = decoded.message!.firstName!;
        // lastNameController.text = decoded.message!.lastName!;
        // emailController.text = decoded.message!.email!;
        // phoneController.text = decoded.message!.phone!;
        // operator = decoded.message!.company!.companyName!;
        // companyId = int.parse(decoded.message!.company!.companyId!);
        // propertyType = decoded.message!.propertyType!;
        // ward = decoded.message!.ward!.wardName!;
        // lga = decoded.message!.localGovt!.lgName!;
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
