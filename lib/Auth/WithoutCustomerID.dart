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

import 'OTPScreen.dart';

class RegisterWithCustomerScreenPage extends StatefulWidget {
  const RegisterWithCustomerScreenPage({Key? key}) : super(key: key);

  @override
  _RegisterWithCustomerScreenPageState createState() =>
      _RegisterWithCustomerScreenPageState();
}

class _RegisterWithCustomerScreenPageState
    extends State<RegisterWithCustomerScreenPage> {
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
      // final dio = Dio();
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
      print(response.reasonPhrase);
      print(response);
      print(response.body);
      print(response.statusCode);

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
        Alerts.show(context, "Error", registerResponse.message!.customerId![0]);
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
    getOperatorList();
    getLgaList();
    getWardList();
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
                  SingleChildScrollView(
                    child: Container(
                      // height: MediaQuery.of(context).size.height ,
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      decoration: BoxDecoration(
                          color: R.colors
                              .splashScreenViewPagerSelectedIndicatorColor,
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
                                      Text("Customer ID", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("First Name ", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Last Name ", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Email", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Mobile Number",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
                                        controller: phoneController,
                                        obscureText: false,
                                        hintText: 'Enter Mobile Number',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Service Provider",
                                        style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: operator == null
                                              ? Text('Select Service Provider')
                                              : Text(
                                                  operator!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: propertyList!.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val["company_name"],
                                                child:
                                                    Text(val["company_name"]),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                operator = val.toString();
                                                companyId = propertyList![
                                                    propertyList!.indexWhere(
                                                        (element) =>
                                                            element[
                                                                "company_name"] ==
                                                            operator)]["company_id"];
                                                int a = int.parse(
                                                    companyId.toString());
                                                print(a);
                                                // companyId = val["company_id"];
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ward", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: ward == null
                                              ? Text('Select Ward')
                                              : Text(
                                                  ward!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: wardList!.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val["ward_name"],
                                                child: Text(val["ward_name"]),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                ward = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Local Govt", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: lga == null
                                              ? Text('Select Local Govt')
                                              : Text(
                                                  lga!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: lgaList!.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                value: val["lga_name"],
                                                child: Text(val["lga_name"]),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                lga = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Property Type", style: textStyleBold),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: R.colors.whiteMainColor)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: propertyType == null
                                              ? Text('Select Property Type')
                                              : Text(
                                                  propertyType!,
                                                  style: TextStyle(
                                                      color: R.colors
                                                          .loginButtonColor),
                                                ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(
                                              color: R.colors.loginButtonColor),
                                          items: proType.map(
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
                                                propertyType = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Password", style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
                                        controller: passwordController,
                                        obscureText: showObscureText,
                                        hintText: 'Enter Password',
                                        keyboard: TextInputType.text,
                                        onTap: () {},
                                        onChanged: () {},
                                        onSaved: (String value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          } else if (value.length < 8) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          } else if (value.length < 8) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },

                                        toggleEye: () {},
                                        // ob
                                        suffix: GestureDetector(
                                          onTap: () => setState(() {
                                            showObscureText = !showObscureText;
                                          }),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: showObscureText
                                                  ? Icon(
                                                      Icons.remove_red_eye,
                                                      color: R.colors
                                                          .splashScreenViewPagerSelectedIndicatorColor,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      color: Colors.grey,
                                                    )),
                                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Confirm Password",
                                          style: textStyleBold),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Input(
                                        obscureText: showObscureText1,
                                        hintText: 'Confirm Password',
                                        keyboard: TextInputType.emailAddress,
                                        onTap: () {},
                                        onChanged: () {},
                                        onSaved: () {},
                                        validator: () {},
                                        toggleEye: () {},
                                        suffix: GestureDetector(
                                          onTap: () => setState(() {
                                            showObscureText1 =
                                                !showObscureText1;
                                          }),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: showObscureText1
                                                  ? Icon(
                                                      Icons.remove_red_eye,
                                                      color: R.colors
                                                          .splashScreenViewPagerSelectedIndicatorColor,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      color: Colors.grey,
                                                    )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      //  showCupertinoModalBottomSheet
                                      registerUser();
                                      // sendOTP();
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
                                              color: R.colors.loginButtonColor),
                                          color: R.colors.loginButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                            color: R.colors.whiteMainColor,
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
                                              color:
                                                  R.colors.textBackgroundColor,
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
                      ),
                    ),
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
        fisrtNameController.text = decoded.message!.firstName!;
        lastNameController.text = decoded.message!.lastName!;
        emailController.text = decoded.message!.email!;
        phoneController.text = decoded.message!.phone!;
        operator = decoded.message!.company!.companyName!;
        companyId = int.parse(decoded.message!.company!.companyId!);
        propertyType = decoded.message!.propertyType!;
        ward = decoded.message!.ward!.wardName!;
        lga = decoded.message!.localGovt!.lgName!;
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
