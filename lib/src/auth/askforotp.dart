// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import '../../database/hive_handler.dart';
// import '../../utility/widget/button.dart';
// import 'signup.dart';

// // String address = "192.168.43.58";  // 192.168.43.58

// class AskOTP extends StatefulWidget {
//   final Stream<int> internetStatus;
//   final String path;
//   final HiveH hiveHandler;
//   const AskOTP(
//       {Key? key,
//       required this.internetStatus,
//       required this.hiveHandler,
//       required this.path})
//       : super(key: key);

//   @override
//   State<AskOTP> createState() => _AskOTPState();
// }

// class _AskOTPState extends State<AskOTP> {
//   bool isOtpSent = false;

//   bool inNumberProcess = false;
//   var authIdController = TextEditingController();
//   String numberErrorText = "";
//   bool numberFieldError = false;

//   bool inOtpProcess = false;
//   var otpController = TextEditingController();
//   String otpErrorText = "";
//   bool otpFieldError = false;

//   String? address = "127.0.0.1";

//   String methodMessage = "";
//   String buttonName = "";
//   String resendButtonName = "30";
//   bool enableResendButton = false;

//   @override
//   void initState() {
//     super.initState();
//     address = widget.hiveHandler.get("temp","ipaddress");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: const Color.fromARGB(255, 28, 29, 77),
//         child: Padding(
//             padding: const EdgeInsets.only(top: 100, bottom: 40, right: 20, left: 20),
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text("Authentication",
//                       style: TextStyle(
//                         color: Color.fromRGBO(135, 212, 182, 1),
//                         fontSize: 40,
//                         letterSpacing: 0,
//                         fontWeight: FontWeight.w900,
//                       )
//                     ),
//                 ),
//                 const Text("Validate yourself using",
//                     style:
//                         TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
//                 const Text("OTP method.",
//                     style:
//                         TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 135, 212, 182),
//                       borderRadius: BorderRadius.all(Radius.circular(50.0))
//                     ),
//                     height: 3,
//                   ),
//                 ),
//                 isOtpSent ? secondStep() : firstStep()
//               ],
//             )));
//   }

//   Widget firstStep() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//           child: TextFormField(
//             cursorColor: Colors.black,
//             style: const TextStyle(color: Colors.black),
//             controller: authIdController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: const Color.fromARGB(255, 135, 212, 182),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(50)),
//               hintText: "Phone or Email",
//               errorText: numberFieldError
//                   ? "Please Provide correct Phone or Email"
//                   : null,
//               errorStyle: const TextStyle(color: Colors.red),
//               hintStyle: const TextStyle(
//                   color: Color.fromARGB(255, 57, 61, 124)),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: defaultButton(
//             label: "Get OTP",
//             context: context,
//             progressBar: inNumberProcess,
//             validator: (context) async {
//               RegExp _numeric = RegExp(r'^-?[0-9]+$');
//               if (authIdController.text.isEmpty) {
//                 setState(() {
//                   numberFieldError = true;
//                 });
//               } else {
//                 if (authIdController.text.contains("@") && authIdController.text.contains(".")) {
//                   setState(() {
//                     buttonName = "Email";
//                     methodMessage = "We have send a OTP to your Email address: ${authIdController.text}";
//                   });
//                   sendGetOtpRequest(authIdController.text, false);
//                 } else if (authIdController.text.length == 10 && _numeric.hasMatch(authIdController.text)) {
//                   setState(() {
//                     buttonName = "Phone";
//                     methodMessage = "We have send a OTP to your Phone Number: ${authIdController.text}";
//                   });
//                   sendGetOtpRequest(authIdController.text, true);
//                 } else {
//                   setState(() {
//                     numberFieldError = true;
//                   });
//                 } 
//               }
//             }
//           ),
//         )
//       ],
//     );
//   }

//   Widget secondStep() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(methodMessage),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//           child: TextFormField(
//             cursorColor: Colors.black,
//             style: const TextStyle(color: Colors.black),
//             controller: otpController,
//             keyboardType: TextInputType.number,
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.digitsOnly
//             ],
//             decoration: InputDecoration(
//               errorText: otpErrorText,
//               filled: true,
//               fillColor: const Color.fromARGB(255, 135, 212, 182),
//               border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(50)),
//               hintText: "OTP",
//               hintStyle:
//                   const TextStyle(color: Color.fromARGB(255, 161, 164, 206)),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 0.0),
//           child: defaultButton(
//               label: "Varify",
//               context: context,
//               progressBar: inOtpProcess,
//               validator: (context) {
//                 if (otpController.text.isEmpty) {
//                   otpErrorText = "Please Enter OTP first!";
//                   otpFieldError = true;
//                   setState(() {});
//                 } else if (otpController.text.length != 6) {
//                   otpErrorText = "Number should be 10 character long";
//                   otpFieldError = true;
//                   setState(() {});
//                 } else {
//                   otpFieldError = false;
//                   setState(() {
//                     inOtpProcess = true;
//                   });

//                   Map payload = {
//                     'otp': otpController.text,
//                     'id': widget.hiveHandler.get("temp","id"),
//                   };
//                   var body = json.encode(payload);

//                   var response = http.post(
//                       Uri.parse("http://$address:8080/api/v1/verifyotp"),
//                       body: body);
//                   response.then((value) {
//                     if (value.statusCode == 200) {
//                       String res = String.fromCharCodes(value.bodyBytes);
//                       print(json.decode(res));
//                       if (json.decode(res)['status'] == "successful") {
//                         setState(() {
//                           inOtpProcess = false;
//                           inNumberProcess = false;
//                           isOtpSent = false;
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) => SignUp(
//                                       internetStatus: widget.internetStatus,
//                                       hiveHandler: widget.hiveHandler,
//                                       path: widget.path)));
//                         });
//                       }
//                     }
//                   });
//                 }
//               }),
//         ),
//         Padding(
//           padding:const EdgeInsets.only(top: 10, left: 40, right: 40),
//           child: Row(
//             children: [
//               Expanded(child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: InkWell(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(40, 160, 237, 243),
//                       borderRadius: BorderRadius.all(Radius.circular(50.0))
//                     ),
//                     height: 30,
//                     alignment: Alignment.center,
//                     child: Text("Edit $buttonName")
//                   ),
//                   onTap: () {
//                     setState(() {
//                       isOtpSent = false;
//                     });
//                   },
//                 ),
//               )),
//               Expanded(child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: InkWell(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: enableResendButton ? const Color.fromARGB(40, 160, 237, 243) : const Color.fromARGB(40, 103, 110, 110),
//                       borderRadius: const BorderRadius.all(Radius.circular(50.0))
//                     ),
//                     height: 30,
//                     alignment: Alignment.center,
//                     child: Text(resendButtonName)
//                   ),
//                   onTap: () {
//                     if (enableResendButton) {
//                       timers();
//                       setState(() {
//                         enableResendButton = false;
//                       });  
//                     } else {
//                       setState(() {
//                         enableResendButton = true;
//                       });
//                     }
//                   }
//                 ),
//               )),
//             ]
//           ),
//         )
//       ],
//     );
//   }

//   void timers() {
//     int count = 30;

//     Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       count = count - 1;
//       setState(() {
//         if (count == 0) {
//           resendButtonName = "Re-send";
//         } else {
//           resendButtonName = "$count";
//         }
//       });
//     });

//     Timer timer = Timer(Duration(seconds: 31), () {
//       setState(() {
//         enableResendButton = true;
//       });
//       _timer.cancel();
//     });
//   }

//   void sendGetOtpRequest(String authId, bool isPhone) {
//     numberFieldError = false;
//     setState(() {
//       inNumberProcess = true;
//     });
//     widget.hiveHandler.set("temp","authId", authId);
//     String authIdType = isPhone ? "phone" : "email";
//     widget.hiveHandler.set("temp","authIdType", authIdType);
//     setState(() {
//       inNumberProcess = false;
//       isOtpSent = true;
//       timers();
//     });

//     // hiveHandler.set("tempData", "number",
//     //     numberController.text);
//     // Map payload = {'number': numberController.text};
//     // var body = json.encode(payload);
//     // var response = http.post(
//     //     Uri.parse(
//     //         "http://$address:8080/api/v1/sendotp"),
//     //     body: body);
//     // response.then((value) {
//     //   if (value.statusCode == 200) {
//     //     String res =
//     //         String.fromCharCodes(value.bodyBytes);
//     //     widget.hiveHandler.tempBox
//     //         .put("id", json.decode(res)['id']);
//     //     setState(() {
//     //       sentOTP = true;
//     //     });
//     //   }
//     // });
//   }
// }
