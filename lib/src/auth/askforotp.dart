import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../database/hive_handler.dart';
import '../../utility/widget/button.dart';
import 'signup.dart';

// String address = "192.168.43.58";  // 192.168.43.58

class AskOTP extends StatefulWidget {
  final Stream<int> internetStatus;
  final String path;
  final HiveH hiveHandler;
  const AskOTP(
      {Key? key,
      required this.internetStatus,
      required this.hiveHandler,
      required this.path})
      : super(key: key);

  @override
  State<AskOTP> createState() => _AskOTPState();
}

class _AskOTPState extends State<AskOTP> {
  bool sentOTP = false;

  bool inNumberProcess = false;
  var numberController = TextEditingController();
  String numberErrorText = "";
  bool numberFieldError = false;

  bool inOtpProcess = false;
  var otpController = TextEditingController();
  String otpErrorText = "";
  bool otpFieldError = false;

  String? address = "127.0.0.1";

  @override
  void initState() {
    super.initState();
    address = widget.hiveHandler.tempBox.get("ipaddress");
  }

  Widget secondStep() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            controller: otpController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              errorText: otpErrorText,
              filled: true,
              fillColor: Color.fromARGB(255, 135, 212, 182),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50)),
              hintText: "OTP",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 161, 164, 206)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: defaultButton(
              label: "Varify",
              context: context,
              progressBar: inOtpProcess,
              validator: (context) {
                if (otpController.text.isEmpty) {
                  otpErrorText = "Please Enter OTP first!";
                  otpFieldError = true;
                  setState(() {});
                } else if (otpController.text.length != 6) {
                  otpErrorText = "Number should be 10 character long";
                  otpFieldError = true;
                  setState(() {});
                } else {
                  otpFieldError = false;
                  setState(() {
                    inOtpProcess = true;
                  });

                  Map payload = {
                    'otp': otpController.text,
                    'id': widget.hiveHandler.tempBox.get("id"),
                  };
                  var body = json.encode(payload);

                  var response = http.post(
                      Uri.parse("http://$address:8080/api/v1/verifyotp"),
                      body: body);
                  response.then((value) {
                    if (value.statusCode == 200) {
                      String res = String.fromCharCodes(value.bodyBytes);
                      print(json.decode(res));
                      if (json.decode(res)['status'] == "successful") {
                        setState(() {
                          inOtpProcess = false;
                          inNumberProcess = false;
                          sentOTP = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignUp(
                                      internetStatus: widget.internetStatus,
                                      hiveHandler: widget.hiveHandler,
                                      path: widget.path)));
                        });
                      }
                    }
                  });
                }
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromARGB(255, 28, 29, 77),
        child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 40, right: 20, left: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text("Authentication",
                      style: TextStyle(
                        color: Color.fromARGB(255, 135, 212, 182),
                        fontSize: 40,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                      )
                    ),
                ),
                const Text("Validate your mobile number",
                    style:
                        TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
                const Text("using OTP method.",
                    style:
                        TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 135, 212, 182),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                      hintText: "Mobile Number",
                      errorText: numberFieldError
                          ? "Please Provide Mobile Number"
                          : null,
                      errorStyle: const TextStyle(color: Colors.red),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 161, 164, 206)),
                    ),
                  ),
                ),
                sentOTP
                    ? secondStep()
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: defaultButton(
                            label: "OTP",
                            context: context,
                            progressBar: inNumberProcess,
                            validator: (context) async {
                              if (numberController.text.isEmpty) {
                                numberFieldError = true;
                                setState(() {});
                              } else {
                                numberFieldError = false;
                                setState(() {
                                  inNumberProcess = true;
                                });
                                widget.hiveHandler.tempBox
                                    .put("number", numberController.text);
                                // hiveHandler.set("tempData", "number",
                                //     numberController.text);
                                Map payload = {'number': numberController.text};
                                var body = json.encode(payload);
                                var response = http.post(
                                    Uri.parse(
                                        "http://$address:8080/api/v1/sendotp"),
                                    body: body);
                                response.then((value) {
                                  if (value.statusCode == 200) {
                                    String res =
                                        String.fromCharCodes(value.bodyBytes);
                                    widget.hiveHandler.tempBox
                                        .put("id", json.decode(res)['id']);
                                    setState(() {
                                      sentOTP = true;
                                    });
                                  }
                                });
                              }
                            }),
                      )
              ],
            )));
  }
}
