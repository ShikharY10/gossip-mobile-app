// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_file_dialog/flutter_file_dialog.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:gossip_frontend/main.dart';
// import 'package:gossip_frontend/utility/widget/alerbox.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_cropper/image_cropper.dart';
// import '../../../database/hive_handler.dart';
// import '../../../utility/gbp/gbProto.pb.dart' as gbp;
// import 'imagepreview.dart';
// import 'updateNumber.dart';

// class MyProfile extends StatefulWidget {
//   final HiveH hiveHandler;
//   const MyProfile({Key? key, required this.hiveHandler}) : super(key: key);

//   @override
//   State<MyProfile> createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   // HiveH hiveHandler = HiveH();

//   late User myData;
//   String? address = "10.0.2.2";

//   bool inEmailChange = false;
//   bool inProfileChange = false;

//   @override
//   initState() {
//     super.initState();
//     address = widget.hiveHandler._tempBox.get("ipaddress");
//     User userData = User();
//     userData.toObject(widget.hiveHandler._userAndFriendBox.get("userData")!);
//     myData = userData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: const Color.fromARGB(255, 135, 212, 182),
//         child: Column(
//           children: [
//             Expanded(
//                 flex: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 30.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.arrow_circle_left,
//                                   color: Color.fromARGB(255, 28, 29, 77)),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       Center(
//                         child: Stack(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 // print("Image Preview");
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (BuildContext context) => ImagePreview(imageData: base64.decode(myData.profilePic), name: myData.name)
//                                   )
//                                 );
//                               },
//                               child: CircleAvatar(
//                                 child: inProfileChange ? Container(
//                                   // width: 40,
//                                   // height: 40,
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                                     color: Color.fromARGB(178, 38, 38, 46),
//                                   ),
//                                   child: const Center(
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 4,
//                                       color: Color.fromARGB(255, 135, 212, 182)
//                                     ),
//                                   )
//                                 ) : null,
//                                 backgroundImage: MemoryImage(base64.decode(myData.profilePic)), //AssetImage("assets/images/white.jpeg"), /
//                                 radius: 50,
//                               ),
//                             ),
//                             Positioned(
//                               top: 60,
//                               left: 60,
//                               child: CircleAvatar(
//                                 backgroundColor:
//                                     const Color.fromARGB(164, 143, 156, 199),
//                                 child: IconButton(
//                                     icon: const Icon(Icons.edit, color: Color.fromARGB(255, 28, 29, 77)),
//                                     onPressed: () async {
//                                       String idata = await changeImage();
//                                       if (idata.isNotEmpty) {
//                                         setState(() {
//                                           inProfileChange = true;
//                                         });
//                                         Map payload = {
//                                           'picdata': idata,
//                                           'sendermid': myData.mid
//                                         };
//                                         var body = json.encode(payload);
//                                         var response = http.post(
//                                           Uri.parse("http://$address:8080/uprofile"),
//                                           body: body
//                                         );
//                                         response.then((value) {
//                                           print("profile pic update response comes");
//                                           if (value.statusCode == 200) {
//                                             String res = String.fromCharCodes(value.bodyBytes);
//                                             print("res: ${json.decode(res)}");
//                                             if (json.decode(res)['status'] == "successful") {
//                                               myData.profilePic = idata;
//                                               widget.hiveHandler._userAndFriendBox.put("userData", myData.toJson());
//                                               setState(() {
//                                                 inProfileChange = false;
//                                               });
//                                             }
//                                             else {
//                                               setState(() {
//                                                 inProfileChange = false;
//                                               });
//                                             }
//                                           }
//                                         });
//                                       }
//                                     }),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Center(
//                           child: Text(myData.name,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 28, 29, 77),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16)),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 print("admin panel clicked");
//                                 showDialog(
//                                   context: context, 
//                                   builder: (context) => Material(
//                                     color: Colors.transparent,
//                                     child: Center(
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width/(1.2),
//                                         color: Colors.cyan,
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Container(width: 20, height: 10, color: Colors.amber),
//                                                   Container(width: 20, height: 10, color: Colors.amber)
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ));
//                               },
//                               icon: const Icon(Icons.admin_panel_settings_outlined,
//                                   color: Color.fromARGB(255, 28, 29, 77))),
//                           IconButton(
//                               onPressed: () {
//                                 print("Goinng Invisible");
//                                 print(widget.hiveHandler.connectionsBox.values.toList());
//                               },
//                               icon: const Icon(Icons.settings, color: Color.fromARGB(255, 28, 29, 77))),
//                           IconButton(
//                               onPressed: () {
//                                 print("Goinng Invisible");
//                               },
//                               icon: const Icon(Icons.video_call, color: Color.fromARGB(255, 28, 29, 77)))
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//             Expanded(
//               flex: 6,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 28, 29, 77),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0),
//                   ),
//                 ),
//                 width: double.infinity,
//                 child: Center(
//                   child: Scrollbar(
//                     child: ListView(
//                       children: [
//                         // Number
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width/2.7,
//                                   height: 3,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(Radius.circular(50.0))
//                                   )
//                                 ),
//                               ),
//                               const Text("Info",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width/2.7,
//                                   height: 3,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(Radius.circular(50.0))
//                                   )
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(54, 135, 212, 182),
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                             ),
//                             child: ListTile(
//                               leading: const Icon(
//                                 Icons.phone_iphone_outlined,
//                                 color: Color.fromARGB(255, 135, 212, 182)
//                               ),
//                               title: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: Text(myData.mnum,
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 255, 255, 255),
//                                         fontWeight: FontWeight.bold
//                                       )
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               trailing: Material(
//                                 type: MaterialType.transparency,
//                                 child: IconButton(
//                                   splashRadius: 20,
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Color.fromARGB(255, 255, 255, 255),
//                                   ),
//                                   onPressed: () {
//                                     print("Edit clicked");
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (BuildContext context) => UpdateNumber(hiveHandler: widget.hiveHandler, myData: myData)
//                                       )
//                                     );
//                                   }
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Name
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(54, 135, 212, 182),
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                             ),
//                             child: ListTile(
//                               leading: const Icon(
//                                 Icons.contact_page_rounded,
//                                 color: Color.fromARGB(255, 135, 212, 182)
//                               ),
//                               title: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: Text(myData.name,
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 255, 255, 255),
//                                         fontWeight: FontWeight.bold
//                                       )
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // trailing: Material(
//                               //   type: MaterialType.transparency,
//                               //   child: IconButton(
//                               //     splashRadius: 20,
//                               //     icon: const Icon(
//                               //       Icons.edit,
//                               //       color: Color.fromARGB(255, 255, 255, 255),
//                               //     ),
//                               //     onPressed: () {
//                               //       print("Edit clicked");
//                               //       showDialog(
//                               //         context: context, 
//                               //         builder: (context) => popUpInputBox(
//                               //           title: "Update Name!",
//                               //           mainBtnName: "Update", 
//                               //           hintText: "New Name", 
//                               //           onTap: (value) {
                                          
//                               //           }
//                               //         )
//                               //       );
//                               //     }
//                               //   ),
//                               // ),
//                             ),
//                           ),
//                         ),
//                         // Email
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(54, 135, 212, 182),
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                             ),
//                             child: ListTile(
//                               leading: const Icon(
//                                 Icons.email_rounded,
//                                 color: Color.fromARGB(255, 135, 212, 182)
//                               ),
//                               title: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: Text(myData.email,
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 255, 255, 255),
//                                         fontWeight: FontWeight.bold
//                                       )
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               trailing: Material(
//                                 type: MaterialType.transparency,
//                                 child: inEmailChange ? const SizedBox(
//                                   width: 15,
//                                   height: 15,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Color.fromARGB(255, 135, 212, 182)
//                                   )
//                                 ) : IconButton(
//                                   splashRadius: 20,
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Color.fromARGB(255, 255, 255, 255),
//                                   ),
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context, 
//                                       builder: (context) => popUpInputBox(
//                                         title: "Update Email!",
//                                         mainBtnName: "Update", 
//                                         hintText: "New Email", 
//                                         onTap: (newEmail) {
//                                           setState(() {
//                                             inEmailChange = true;
//                                           });
//                                           Navigator.pop(context);
//                                           print("Edit clicked");
//                                           Map payload = {
//                                             'email': newEmail,
//                                             'mid': myData.mid
//                                           };
//                                           var body = json.encode(payload);
//                                           var response = http.post(
//                                             Uri.parse("http://$address:8080/uemail"),
//                                             body: body
//                                           );
//                                           response.then((value) {
//                                             if (value.statusCode == 200) {
//                                               String res = String.fromCharCodes(value.bodyBytes);
//                                               if (json.decode(res)['status'] == "successful") {
//                                                 myData.email = newEmail;
//                                                 widget.hiveHandler._userAndFriendBox.put("userData", myData.toJson());
//                                                 setState(() {
//                                                   inEmailChange = false;
//                                                 });

//                                               }
//                                             }
//                                           });
//                                         }
//                                       )
//                                     );                      
//                                   }
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8, bottom: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width/2.7,
//                                   height: 3,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(Radius.circular(50.0))
//                                   )
//                                 ),
//                               ),
//                               const Text("Action",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width/2.7,
//                                   height: 3,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(Radius.circular(50.0))
//                                   )
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 136, 54, 54),
//                               borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Log Out"),
//                                 IconButton(
//                                   icon: const Icon(Icons.logout_rounded),
//                                   onPressed: () {
//                                     print("logout clicked");
//                                     Map<String, String> allData = {
//                                      "mid": myData.mid
//                                     };
                          
//                                     String body = json.encode(allData);
                          
//                                     Future<http.Response> fresponse = http.post(
//                                       Uri.parse("http://$address:8080/logout"),
//                                       body: body
//                                     );
//                                     fresponse.then((value) {
//                                       if (value.statusCode == 200) {
//                                         gbp.Response response = gbp.Response.fromBuffer(value.bodyBytes);
//                                         if (response.status) {
//                                           widget.hiveHandler.connectionsBox.clear();
//                                           widget.hiveHandler.encryptedTempBox.clear();
//                                           widget.hiveHandler._gossipsBox.clear();
//                                           widget.hiveHandler.recentGossipsBox.clear();
//                                           widget.hiveHandler._tempBox.clear();
//                                           widget.hiveHandler._userAndFriendBox.clear();
//                                           setState(() {});
//                                           Phoenix.rebirth(context);
//                                         }
//                                       }
//                                     });
//                                   }
//                                 )
//                               ],
//                             )
//                           )
//                         )
//                       ],
//                     ),
//                   )
//                 ),
//               ),
//             )
//           ],
//         ));
//   }

//   Widget popUpInputBox({required String title, required String mainBtnName, required String hintText, required Function(String) onTap}) {
//     var textController = TextEditingController();
//     return AlertDialog(
//       backgroundColor: const Color.fromARGB(255, 28, 29, 77),
//       elevation: 4.0,
//       title: Text(title),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//             child: TextFormField(
//               style: const TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
//               controller: textController,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: const Color.fromARGB(255, 135, 212, 182),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(50)),
//                 hintText: hintText,
//                 hintStyle:
//                     const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, right: 10,),
//                 child: InkWell(
//                   borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                   splashColor: const Color.fromARGB(255, 28, 29, 77),
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width/4,
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 135, 212, 182),
//                       borderRadius: BorderRadius.all(Radius.circular(50.0))
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 28, 29, 77),
//                           fontWeight: FontWeight.bold,
//                         )
//                       )
//                     )
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   }
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, left: 10,),
//                 child: InkWell(
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width/4,
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 135, 212, 182),
//                       borderRadius: BorderRadius.all(Radius.circular(50.0))
//                     ),
//                     child: Center(
//                       child: Text(
//                         mainBtnName,
//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 28, 29, 77),
//                           fontWeight: FontWeight.bold,
//                         )
//                       )
//                     )
//                   ),
//                   onTap: () {
//                     onTap(textController.text);
//                   },
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// Future<String> changeImage() async {
//   const params = OpenFileDialogParams(
//     dialogType: OpenFileDialogType.image,
//     sourceType: SourceType.photoLibrary,
//   );
//   final filePath = await FlutterFileDialog.pickFile(params: params);
//   if (filePath == null) {
//     return "";
//   } else {
//     print("File : $filePath");
//     CroppedFile? cropped = await ImageCropper().cropImage(
//       sourcePath: filePath,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       aspectRatioPresets: [CropAspectRatioPreset.square],
//       compressQuality: 70,
//       compressFormat: ImageCompressFormat.jpg,
//       uiSettings: [uISettingsLocked()],
//     );
//     print("cropping done");
//     if (cropped != null) {
//       Uint8List idata = await cropped.readAsBytes();
//       return base64.encode(idata.toList());
//     }
//     return "";
//   }
// }

// AndroidUiSettings uISettingsLocked() => AndroidUiSettings(
//   toolbarTitle: "Edit Image",
//   toolbarColor: const Color.fromARGB(255, 135, 212, 182),
//   toolbarWidgetColor: const Color.fromARGB(255, 28, 29, 77)


// );

// // Padding(
// //   padding: const EdgeInsets.all(8.0),
// //   child: InkWell(
// //     onTap: () {
// //       hiveHandler.connectionsBox.clear();
// //       print("All connections have been removed.");
// //     },
// //     child: Container(
// //       width: 200,
// //       height: 40,
// //       decoration: const BoxDecoration(
// //         color: Color.fromARGB(255, 43, 60, 135),
// //       ),
// //       child: const Center(
// //         child: Text("Erase Connections", style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white
// //         )),
// //       )
  
// //     )
// //   ),
// // ),
// // Padding(
// //   padding: const EdgeInsets.all(8.0),
// //   child: InkWell(
// //     onTap: () {
// //       hiveHandler.gossipsBox.clear();
// //       print("All gossips have been removed.");
// //     },
// //     child: Container(
// //       width: 200,
// //       height: 40,
// //       decoration: const BoxDecoration(
// //         color: Color.fromARGB(255, 43, 60, 135),
// //       ),
// //       child: const Center(
// //         child: Text("Erase Gossips", style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white
// //         )),
// //       )
  
// //     )
// //   ),
// // ),
// // Padding(
// //   padding: const EdgeInsets.all(8.0),
// //   child: InkWell(
// //     onTap: () {
// //       hiveHandler.recentGossipsBox.clear();
// //       print("All recent gossips have been removed.");
// //     },
// //     child: Container(
// //       width: 200,
// //       height: 40,
// //       decoration: const BoxDecoration(
// //         color: Color.fromARGB(255, 43, 60, 135),
// //       ),
// //       child: const Center(
// //         child: Text("Erase R-Gossips", style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white
// //         )),
// //       )
  
// //     )
// //   ),
// // ),
// // Padding(
// //   padding: const EdgeInsets.all(8.0),
// //   child: InkWell(
// //     onTap: () {
// //       print("All Connection: ${widget.hiveHandler.connectionsBox.toMap().keys.toList()}");
// //     },
// //     child: Container(
// //       width: 200,
// //       height: 40,
// //       decoration: const BoxDecoration(
// //         color: Color.fromARGB(255, 43, 60, 135),
// //       ),
// //       child: const Center(
// //         child: Text("Show Connections", style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white
// //         )),
// //       )
  
// //     )
// //   ),
// // ),
