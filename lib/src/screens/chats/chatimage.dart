// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'package:cryptography/cryptography.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../../../database/hive_handler.dart';
// import '../../../database/models.dart';
// import '../../../utility/gbp/internalProto.pb.dart';
// import '../../../utility/ws/wsutils.dart';

// class ChatImage extends StatefulWidget {
//   final bool initial;
//   final Chat chat;
//   final HiveH hiveHandler;
//   // final Connection myData;
//   // final StreamController<RecentGossips> rGossipController;
//   final SendPort wsSendPort;
//   const ChatImage({
//     Key? key, 
//     required this.initial,
//     required this.chat, 
//     required this.hiveHandler, 
//     // required this.myData, 
//     // required this.rGossipController, 
//     required this.wsSendPort
//   }) : super(key: key);

//   @override
//   State<ChatImage> createState() => _ChatImageState();
// }

// class _ChatImageState extends State<ChatImage> {

//   bool showLocalImage = false;
//   String networkImageUrl = "";
//   String localImageUrl = "";
//   String address = "";

//   static String filePath = "";

//   @override
//   void initState() {
//     super.initState();
//     address = widget.hiveHandler.get("temp","ipaddress")!;
//     if (widget.initial && widget.chat.tp == 21) {
//       makeRequest(widget.chat.msg);
//     }
//     else if (!widget.initial && widget.chat.tp == 22) {
//       print("23 and not initial");
//       downloadImage(widget.chat.msg, false);
//     }
//      else {
//       print("trying to show local images");
//       Uint8List encoded = base64.decode(widget.chat.msg);
//       Map<String, dynamic> jsonData = json.decode(String.fromCharCodes(encoded));
//       if (jsonData["localpath"] != null) {
//         localImageUrl = jsonData["localpath"];
//         showLocalImage = true;
//       }else {
//         print("Nothing here to show");
//       }
//     }
    
//   }

//   Future<void> makeRequest(String filePath) async {
//     print("Uploading");
//     File file = File(filePath);
//     Uint8List imageData = await file.readAsBytes();
//     String bimage = base64.encode(imageData);
//     Map<String, String> allData = {
//       "image": bimage,
//       "ext": filePath.split(".")[filePath.split(".").length-1]
//     };
    
//     String body = json.encode(allData);
//     Future<http.Response> res = http.post(
//       Uri.parse("http://$address:8080/api/v3/upload/chat/image"),
//       body: body
//     );
//     res.then((value) async {
//       if (value.statusCode == 200) {
//         String res = String.fromCharCodes(value.bodyBytes);
//         Map<String, dynamic> response = json.decode(res);
//         Map<String, dynamic> data = json.decode(response["data"]);
//         setState(() {
//           networkImageUrl = data["secureUrl"];
//         });

//         Future<Uint8List> cipherText = aesEncrypt(
//           base64.encode(data["secureUrl"].codeUnits).codeUnits,
//           SecretKey(base64.decode(widget.myData.key))
//         );

//         cipherText.then((valCipherText) {
//           widget.wsSendPort.send(
//             SendPayload(
//               widget.myData.mid,
//               String.fromCharCodes(valCipherText),
//               21
//             )
//           );
//         });
//         downloadImage(data["secureUrl"], true);
//       }
//     });
//   }

//   Future<void> downloadImage(String link, bool updateRecentGossips) async {
//     String? basePath = widget.hiveHandler.get("temp","basepath");
//     if (basePath != null) {
//       String extension = widget.chat.msg.split(".")[widget.chat.msg.split(".").length-1];
//       String fileStarting = widget.chat.self ? "GPIC_S" : "GPIC_R_";
//       filePath = basePath + "/Gossip_Images/$fileStarting${DateTime.now().millisecondsSinceEpoch.toString()}.$extension";
//       File file = File(filePath);
      
//       Dio dio = Dio();
//       try {
//         await dio.download(
//           getProperSizeUrl(link), 
//           file.path,
//           onReceiveProgress: (received, total) {
//             dioDownloader(received, total, updateRecentGossips);
//           }
//         );
//       } catch (e) {
//         print("Dio Downloading Error: $e");
//       }
      
//     }
//   }

//   Future<void> dioDownloader(int received, int total, bool isUpdateRG) async {
//     print((received / total * 100).toStringAsFixed(0) + "%");
//     if (total/received == 1) {
//       Map<String, String> jsonData = {
//         "localpath": filePath,
//         "networkpath": networkImageUrl
//       };

//       String jEncoded = json.encode(jsonData);
//       String b64Encoded = base64.encode(jEncoded.codeUnits);

//       Chat chat = Chat(
//         sMID: widget.myData.mid,
//         self: true,
//         datetime: DateTime.now().toString(),
//         msg: b64Encoded,
//         mloc: "",
//         tp: 23
//       );

//       String? strGossip = widget.hiveHandler.get("gossips",widget.myData.mid);
//       Gossips gossips = Gossips();
//       String strChat = chat.toString();

//       if (strGossip == null) {
//           gossips.chats = [];
//           gossips.chats!.add(strChat);
//       } else {
//         gossips.toObject(strGossip);
//         gossips.chats!.add(strChat);
//       }

//       String strGossips = gossips.toString();
//       widget.hiveHandler.set("gossips",widget.myData.mid, strGossips);

//       if (isUpdateRG) {
//         updateRecentGossip();
//       }
      
//       setState(() {
//         localImageUrl = filePath;
//         showLocalImage = true;
//       });
//     }
//   }

//   String getProperSizeUrl(String url) {
//     List<String> lUrl = url.split("upload");
//     try {
//       String newURL = lUrl[0] + "upload" + "/c_scale,w_0.50" + lUrl[1];
//       return newURL;
//     } catch (e) {
//       return "";
//     }
//   }

//   Future<void> updateRecentGossip() async {
//     String? strGossips = widget.hiveHandler.get("recentGossip",widget.myData.mid);
//     // RecentGossips cDB;

//     // if (strGossips == null) {
//     //   cDB = RecentGossips(
//     //     name: widget.myData.name,
//     //     lastMsg: "You: Image",
//     //     senderMID: widget.myData.mid,
//     //     dateTime: DateTime.now().toIso8601String(),
//     //     unSeenMsgCount: 0,
//     //     profilePic: widget.myData.profilepic
//     //   );
//     //   widget.hiveHandler.recentGossipsBox.put(
//     //     widget.myData.mid,
//     //     String.fromCharCodes(
//     //       cDB.writeToBuffer()
//     //     )
//     //   );
//     // } else {
//     //   cDB = RecentGossips.fromBuffer(
//     //     strGossips.codeUnits
//     //   );
//     //   cDB.lastMsg = "You: Image";
//     //   cDB.dateTime = DateTime.now().toIso8601String();
//     //   cDB.unSeenMsgCount = 0;
//     //   widget.hiveHandler.recentGossipsBox.put(
//     //     widget.myData.mid,
//     //     String.fromCharCodes(
//     //       cDB.writeToBuffer()
//     //     )
//     //   );
//     // }
//     // widget.rGossipController.sink.add(cDB);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: widget.chat.self ? Alignment.centerRight : Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 3.0),
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 7 / 10,
//               minHeight: 100,
//               maxHeight: 250,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: !widget.chat.self
//                     ? const Radius.circular(0.0)
//                     : const Radius.circular(10.0),
//                 bottomRight: widget.chat.self
//                     ? const Radius.circular(0.0)
//                     : const Radius.circular(10.0),
//                 topLeft: const Radius.circular(10.0),
//                 topRight: const Radius.circular(10.0),
//               ),
//               color: widget.chat.self
//                 ? const Color.fromARGB(255, 135, 212, 182)
//                 : const Color.fromARGB(255, 114, 153, 242),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: showLocalImage ? Image.file(
//                       File(localImageUrl),
//                       fit: BoxFit.cover,
//                       ) : Container(
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: Colors.grey
//                       ),
//                       child: const CircularProgressIndicator(
//                         color: Colors.white
//                       )
//                     ),
//                   ),
//                   const Positioned(
//                     bottom: 5,
//                     right: 5,
//                     child: Text("09:23 AM", style: TextStyle(color: Colors.black, fontSize: 12))
//                   )
//                 ],
//               )
//             )
//           ),
//         ),
//       ),
//     );
//   }
// }

// // code for getting image metadata;
// // final fileBytes = File(filePath).readAsBytesSync();
// // final data = await readExifFromBytes(fileBytes);
