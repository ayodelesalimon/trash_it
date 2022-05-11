import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trash_it/Resources/Colors.dart';
import 'package:trash_it/Resources/Resources.dart';
import 'package:trash_it/Utils/Alerts.dart';
import 'package:http/http.dart' as http;
import 'package:trash_it/Utils/ApiUrl.dart';

import 'Login.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String? email;

  PinCodeVerificationScreen(this.email);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  Duration duration = Duration();
  Timer? _timer;
  int secondsToRun = 120;
  sendOTP() {
    String? _email = widget.email;
    String? _otp = textEditingController.text;

    if (_email!.isEmpty && _otp.isEmpty) {
      Alerts.show(context, "Error", "You need to fill all the fields");
    } else {
      sendOTPSever(_email, _otp);
    }
  }

  Future<void> sendOTPSever(
    String email,
    String otp,
  ) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.VERIFY_OTP),
          body: {"email": email, "otp": otp});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print(data["message"]);
        if (data['status'] == "success") {
          Alerts.continueReg(context, "Success", "Success", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
          });
        } else if (data['status'] == "error") {
          Alerts.show(context, "Error", data['message']);
        } else {
          Alerts.show(context, "Error", data['message']);
        }
      }
    } catch (e) {}
  }

  Future<void> resendOTPSever(
    String email,
  ) async {
    try {
      final response =
          await http.post(Uri.parse(ApiUrl.SEND_OTP), body: {"email": email});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print(data["message"]);
        if (data['status'] == "success") {
          Alerts.show(context, "Success", "Success");
        } else if (data['status'] == "error") {
          Alerts.show(context, "Error", data['message']);
        } else {
          Alerts.show(context, "Error", data['message']);
        }
      }
    } catch (e) {}
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (secondsToRun == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            duration = Duration(seconds: secondsToRun--);
          });
        }
      },
    );
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer!.cancel();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String timerText =
        '${duration.inMinutes.remainder(60).toString()}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(height: 0),
              // Container(
              //   height: MediaQuery.of(context).size.height / 3,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(30),
              //     child: Image.asset("assets/images/fold_down_icon.png"),
              //   ),
              // ),
              SizedBox(height: 38),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Account Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: "${widget.email}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: R.colors.splashScreenViewPagerSelectedIndicatorColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        // if (v!.length < 3) {
                        //   return "I'm from validator";
                        // } else {
                        //   return null;
                        // }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.white,
                        activeColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
              //   child: Text(
              //     hasError ? "*Please fill up all the cells properly" : "",
              //     style: TextStyle(
              //         color: Colors.red,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
              SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (secondsToRun == 0) {
                        setState(() {
                          resendOTPSever(widget.email!);
                        });
                        // try {
                        //   await Auth.requestOTP(requestOTPModel);
                        //   setState(() {
                        //     _isLoading = false;
                        //     secondsToRun = 120;
                        //   });
                        //   startTimer();
                        // } catch (e) {
                        //   setState(() {
                        //     errMsg = '$e';
                        //     _isLoading = false;
                        //   });
                        // }
                      }
                    },
                    child: Text(
                      'Resend Code ${secondsToRun > 0 ? 'in' : ''} ${secondsToRun > 0 ? timerText : ''}',
                      style: TextStyle(
                          color: secondsToRun == 0 ? Colors.green : lightGrey),
                    ),
                  ),
                  // TextButton(
                  //     onPressed: () => snackBar("OTP resend!!"),
                  //     child: Text(
                  //       "RESEND",
                  //       style: TextStyle(
                  //           color: Color(0xFF91D3B3),
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      // conditions for validating
                      if (currentText.isEmpty) {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                        sendOTP();
                      } else {
                        setState(
                          () {
                            hasError = false;
                            sendOTP();
                            // snackBar("OTP Verified!!");
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: R.colors.splashScreenViewPagerSelectedIndicatorColor,
                    borderRadius: BorderRadius.circular(5),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.green.shade200,
                    //       offset: Offset(1, -2),
                    //       blurRadius: 5),
                    //   BoxShadow(
                    //       color: Colors.green.shade200,
                    //       offset: Offset(-1, 2),
                    //       blurRadius: 5)
                    // ]
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
