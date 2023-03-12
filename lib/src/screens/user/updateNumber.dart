// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../database/hive_handler.dart';
// import 'myProfile.dart';

// class UpdateNumber extends StatefulWidget {
//   final HiveH hiveHandler;
//   final User myData;
//   const UpdateNumber({ Key? key, required this.hiveHandler, required this.myData}) : super(key: key);

//   @override
//   State<UpdateNumber> createState() => _UpdateNumberState();
// }

// class _UpdateNumberState extends State<UpdateNumber> {

  
//   TextEditingController firstOtpController = TextEditingController();
//   TextEditingController newNumberController = TextEditingController();
//   TextEditingController secondOtpController = TextEditingController();

//   bool _checkbox = false;
//   bool firstOtpSend = true;
//   bool inFirstProcess = false;
//   bool secondStep = false;
//   bool inSecondProcess = false;
//   bool thirdStep = false;
//   bool inThirdProcess = false;
//   bool fourthStep = false;
//   bool inFourthProcess = false;

//   String? address = "127.0.0.1";

//   @override
//   void initState() {
//     super.initState();
//     address = widget.hiveHandler._tempBox.get("ipaddress");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: Material(
//           type: MaterialType.transparency,
//           child: IconButton(
//             icon: const Icon(
//               Icons.arrow_circle_left,
//               color: Color.fromARGB(255, 28, 29, 77),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )
//         ),
//         backgroundColor: const Color.fromARGB(255, 135, 212, 182),
//         title: const Text("Update Number", style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),),
//       ),
//       // color: const Color.fromARGB(255, 135, 212, 182),
//       body: Container(
//         color: const Color.fromARGB(255, 135, 212, 182),
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 28, 29, 77),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0),
//                   ),
//                 ),
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     // notice
//                     SizedBox(
//                       child: firstOtpSend ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: Text(
//                           "Sending Otp to xxxxxxxx${widget.myData.mnum.substring(8,10)}!",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.yellow,
//                             fontWeight: FontWeight.bold
//                           )
//                         ),
//                       ) : null,
//                     ),
//                     // send otp to old number
//                     SizedBox(
//                       child: firstOtpSend ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: InkWell(
//                           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () async {

//                             setState(() {
//                               inFirstProcess = true;
//                             });

//                             widget.hiveHandler._tempBox.put("oldnumber", widget.myData.mnum);
//                             Map payload = {'number': widget.myData.mnum};
//                             var body = json.encode(payload);
//                             var response = http.post(
//                               Uri.parse("http://$address:8080/sendotp"),
//                               body: body
//                             );
//                             response.then((value) {
//                               if (value.statusCode == 200) {
//                                 String res = String.fromCharCodes(value.bodyBytes);
//                                 widget.hiveHandler._tempBox.put("oldnumid", json.decode(res)['id']);
//                                 setState(() {
//                                   firstOtpSend = false;
//                                   secondStep = true;
//                                   inFirstProcess = false;
//                                 });
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                               color: Color.fromARGB(45, 234, 141, 253)
//                             ),
//                             child: Center(
//                               child: inFirstProcess ? const CircularProgressIndicator(strokeWidth: 3,)  : const Text(
//                                 "Send",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               ),
//                             )
//                           )
//                         ),
//                       ) : null,
//                     ),
//                     // enter the old number otp
//                     SizedBox(
//                       child: secondStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: TextFormField(
//                           style: const TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
//                           controller: firstOtpController,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.security_outlined),
//                             constraints: BoxConstraints.tightFor(height: 40),
//                             contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 135, 212, 182),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(50)),
//                             hintText: "Enter Old Number OTP",
//                             hintStyle:
//                                 const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
//                           ),
//                         ),
//                       ) : null,
//                     ),
//                     // varify the old number otp
//                     SizedBox(
//                       child: secondStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: InkWell(
//                           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () {
//                             setState(() {
//                               inSecondProcess = true;
//                             });

//                             Map payload = {
//                               'otp': firstOtpController.text,
//                               'id': widget.hiveHandler._tempBox.get("oldnumid"),
//                             };
//                             var body = json.encode(payload);

//                             var response = http.post(
//                               Uri.parse("http://$address:8080/verifyotp"),
//                               body: body
//                             );
//                             response.then((value) {
//                               if (value.statusCode == 200) {
//                                 String res = String.fromCharCodes(value.bodyBytes);
//                                 if (json.decode(res)['status'] == "successful") {
//                                   setState(() {
//                                     secondStep = false;
//                                     thirdStep = true;
//                                     inSecondProcess = false;
//                                   });
//                                 }
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                               color: Color.fromARGB(45, 234, 141, 253)
//                             ),
//                             child: Center(
//                               child: inSecondProcess ? const CircularProgressIndicator(strokeWidth: 3,)  : const Text(
//                                 "Varify",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               ),
//                             )
//                           )
//                         ),
//                       ) : null,
//                     ),
//                     // enter the new number
//                     SizedBox(
//                       child: thirdStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: TextFormField(
//                           style: const TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
//                           controller: newNumberController,
//                           decoration: InputDecoration(

//                             prefixIcon: Icon(Icons.contact_phone_outlined),
//                             constraints: BoxConstraints.tightFor(height: 40),
//                             contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 135, 212, 182),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(50)),
//                             hintText: "Enter New Number",
//                             hintStyle:
//                                 const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
//                           ),
//                         ),
//                       ) : null,
//                     ),
//                     // send otp to new number
//                     SizedBox(
//                       child: thirdStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: InkWell(
//                           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () {
//                             setState(() {
//                               inThirdProcess = true;
//                             });
//                             widget.hiveHandler._tempBox.put("newnumber", newNumberController.text);
//                             Map payload = {'number': newNumberController.text};
//                             var body = json.encode(payload);
//                             var response = http.post(
//                               Uri.parse("http://$address:8080/sendotp"),
//                               body: body
//                             );
//                             response.then((value) {
//                               print("response reached");
//                               if (value.statusCode == 200) {
//                                 String res = String.fromCharCodes(value.bodyBytes);
//                                 var resObj = json.decode(res);
//                                 print("resObj: $resObj");
//                                 widget.hiveHandler._tempBox.put("newnumid", resObj['id']);
//                                   setState(() {
//                                   thirdStep = false;
//                                   fourthStep = true;
//                                   inThirdProcess = false;
//                                 });
//                                 // if (resObj["status"] == "successful") {
                                  
//                                 // }
                                
//                               }
//                             });
//                           },
//                           child: Container(
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                               color: Color.fromARGB(45, 234, 141, 253)
//                             ),
//                             child: Center(
//                               child: inThirdProcess ? const CircularProgressIndicator(strokeWidth: 3,)  : const Text(
//                                 "Send",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               ),
//                             )
//                           )
//                         ),
//                       ) : null,
//                     ),
//                     // enter the new number otp
//                     SizedBox(
//                       child: fourthStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: TextFormField(
//                           style: const TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
//                           controller: secondOtpController,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.security_outlined),
//                             constraints: BoxConstraints.tightFor(height: 40),
//                             contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 135, 212, 182),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(50)),
//                             hintText: "Enter New Number OTP",
//                             hintStyle:
//                                 const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
//                           ),
//                         ),
//                       ) : null,
//                     ),
//                     // checkbox for notify other about number updation
//                     SizedBox(
//                       child: fourthStep ? Padding(
//                         padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                         child: Row(
//                           children: [
//                             Theme(
//                               data: ThemeData(
//                                 // primarySwatch: Colors.blue,
//                                 unselectedWidgetColor: Colors.yellow, // Your color
//                               ),
//                               child: Checkbox(
                                
//                                 value: _checkbox,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     if (_checkbox == false) {
//                                       _checkbox = true;
//                                     } else {
//                                       _checkbox = false;
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.only(left: 5.0),
//                               child: Text(
//                                 "Notify about number change?",
//                                 style: TextStyle(
//                                   color: Colors.yellow
//                                 )
//                               ),
//                             )
//                           ],
//                         ),
//                       ) : null,
//                     ),
//                     // varify the new number otp
//                     SizedBox(
//                       child: fourthStep ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                         child: InkWell(
//                           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                           onTap: () {
//                             setState(() {
//                               inFourthProcess = true;
//                             });

//                             Map payload = {
//                               "otp": secondOtpController.text,
//                               "number": widget.hiveHandler._tempBox.get("newnumber"),
//                               "mid": widget.myData.mid,
//                               "otpid": widget.hiveHandler._tempBox.get("newnumid"),
//                               "notify": _checkbox ? 1 : 0,
//                             };

//                             var body = json.encode(payload);

//                             var response = http.post(
//                               Uri.parse("http://$address:8080/unumber"),
//                               body: body
//                             );

//                             response.then((value) {
//                               if (value.statusCode == 200) {
//                                 String res = String.fromCharCodes(value.bodyBytes);
//                                 Map resObj = json.decode(res);
//                                 if (resObj["status"] == "successful") {
//                                   widget.myData.mnum = widget.hiveHandler._tempBox.get("newnumber")!;
//                                   widget.hiveHandler._userAndFriendBox.put("userData",widget.myData.toJson());
//                                   setState(() {
//                                     inFourthProcess = false;
//                                   });
//                                   Navigator.of(context).pop(true);
//                                   // Navigator.pushReplacement(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //       builder: (BuildContext context) => MyProfile(hiveHandler: widget.hiveHandler)
//                                   //     )
//                                   // );
//                                 }
//                               }
//                             });

//                           },
//                           child: Container(
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                               color: Color.fromARGB(45, 234, 141, 253)
//                             ),
//                             child: Center(
//                               child: inFourthProcess ? const CircularProgressIndicator(strokeWidth: 3,)  : const Text(
//                                 "Update",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               ),
//                             )
//                           )
//                         ),
//                       ) : null,
//                     ),
                    
//                   ],
//                 )
//               ),
//             )
//           ]
//         ),
//       )
//     );
//   }
// }