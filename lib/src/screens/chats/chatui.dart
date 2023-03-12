// // ignore_for_file: avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

// import 'dart:async';
// import 'dart:convert';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'package:cryptography/cryptography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_file_dialog/flutter_file_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
// import '../../../database/hive_handler.dart';
// import '../../../providers/list_provider.dart';
// import '../../../providers/models.dart';
// import '../../../utility/gbp/internalProto.pb.dart';
// import '../../../utility/ws/wsutils.dart';
// import '../../calls/video/videocall.dart';
// import '../user/userprofile.dart';
// import 'chatimage.dart';

// class ChatUI extends StatefulWidget {
//   final Connection myData;
//   final SendPort wsSendPort;
//   final HiveH hiveHandler;
//   final Stream<Chat> chatStream;
//   final StreamController<RecentGossips> rGossipController;
//   const ChatUI(
//       {Key? key,
//       required this.myData,
//       required this.wsSendPort,
//       required this.hiveHandler,
//       required this.chatStream,
//       required this.rGossipController})
//       : super(key: key);

//   @override
//   State<ChatUI> createState() => _ChatUIState();
// }

// class _ChatUIState extends State<ChatUI> {

//   final GlobalKey<FormState> _formKey = GlobalKey();

//   final Color primaryColor = Color.fromARGB(255, 28, 29, 77);
//   final Color secondaryColor =  Color.fromARGB(255, 135, 212, 182);

//   final TextEditingController _controller = TextEditingController();

//   dynamic taskItems;
//   int counter = 0;
//   late DynamicList listClass;
//   bool showAttachmentBox = false;

//   void listenForUIEvent() {
//     widget.chatStream.listen((event) {
//       print("msg received");
//       try {
//         taskItems.addItem(event);
//       } on Exception {}
//     });
//   }

//   void getAllGossips() {
//     String? strGossip = widget.hiveHandler._gossipsBox.get(widget.myData.mid);
//     if (strGossip == null) return;
//     Gossips gossips = Gossips();
//     gossips.toObject(strGossip);
//     print("all gossips: ${gossips.chats}");
//     gossips.chats!.forEach((element) {
//       Chat chat = Chat();
//       chat.toObject(element);
//       listClass.list.add(chat);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // widget.hiveHandler.gossipsBox.delete(widget.myData.mid);
//     taskItems = Provider.of<ListProvider>(context, listen: false);
//     listClass = DynamicList(taskItems.list);
//     getAllGossips();
//     listenForUIEvent();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50.0),
//         child: AppBar(
//           backgroundColor: const Color.fromARGB(255, 135, 212, 182),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_circle_left,
//               color: Color.fromARGB(255, 28, 29, 77)
//             )
//           ),
//           title: Material(
//             type: MaterialType.transparency,
//             child: InkWell(
//               splashColor: Color.fromARGB(255, 148, 148, 167),
//               radius: 40,
//               onTap: () {
//                 print("Profile Clicked");
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (BuildContext context) => UserProfile(
//                       hiveHandler: widget.hiveHandler,
//                       mid: widget.myData.mid
//                     )
//                   )
//                 );
//               },
//               child:
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center, 
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: MemoryImage(base64.decode(widget.myData.profilepic)),
//                       radius: 18,
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Text(widget.myData.name,
//                         style: const TextStyle(
//                             color: Color.fromARGB(255, 28, 29, 77))),
//                   )
//                 ]),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             VideoCallController(db: widget.hiveHandler)));
//                 },
//                 icon: const Icon(Icons.call,
//                     color: Color.fromARGB(255, 28, 29, 77)),
//               ),
//               IconButton(
//                 onPressed: () {
//                   print("Video Call Button Clicked");
//                   User userData = User();
//                   userData.toObject(widget.hiveHandler._userAndFriendBox.get("userData")!);

//                   const uuid = Uuid();
//                   String uid = uuid.v1();

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => VideoCall(
//                         type: 0,
//                         targetMid: widget.myData.mid,
//                         initiaterMid: userData.mid,
//                         pollName: uid,
//                       )
//                     )
//                   );
//                 },
//                 icon: const Icon(Icons.video_call,
//                     color: Color.fromARGB(255, 28, 29, 77)),
//               ),
//             ],
//             centerTitle: true,
//             elevation: 0.0,
//           ),
//         ),
//         body: Stack(
//           children: [
//             Container(
//               color: const Color.fromARGB(255, 135, 212, 182),
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 28, 29, 77),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Consumer<ListProvider>(
//                       builder: (contex, provider, listTile) {
//                         return Expanded(
//                             child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ListView.builder(
//                             itemCount: listClass.list.length,
//                             itemBuilder: chatDisplayer,
//                             reverse: false,
//                           ),
//                         ));
//                       },
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 40,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 40,
//                             child: IconButton(
//                                 onPressed: () {
//                                   print("Camera Clicked");
//                                 },
//                                 icon: const Icon(
//                                   Icons.camera_alt,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                 )),
//                           ),
//                           Expanded(
//                               child: Form(
//                                 key: _formKey,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(bottom: 3.0),
//                                     child: TextFormField(
//                                       cursorColor: Colors.yellow,
//                                       style: TextStyle(
//                                       color: Color.fromARGB(255, 28, 29, 77)),
//                                       maxLines: 4,
//                                       controller: _controller,
//                                       decoration: InputDecoration(
//                                         hintText: "Message",
//                                         contentPadding: const EdgeInsets.all(10.0),
//                                         filled: true,
//                                         fillColor: const Color.fromARGB(255, 135, 212, 182),
//                                         border: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.circular(50)),
//                                         prefixIcon: Padding(
//                                           padding: const EdgeInsets.only(bottom: 1.0),
//                                           child: IconButton(
//                                             color: const Color.fromARGB(255, 28, 29, 77),
//                                             icon: const Icon(Icons.emoji_emotions),
//                                             onPressed: () {
//                                               print("Emoji Clicked");
//                                             },
//                                           ),
//                                         ),
//                                         suffixIcon: IconButton(
//                                           color: const Color.fromARGB(255, 28, 29, 77),
//                                           icon: const Icon(Icons.add_to_photos_sharp),
//                                           onPressed: () {
//                                             print("Attachment Clicked");
//                                             if (showAttachmentBox) {
//                                               setState(() {
//                                                 showAttachmentBox = false;
//                                               });
//                                             } else {
//                                               setState(() {
//                                                 showAttachmentBox = true;
//                                               });
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                       onSaved: (val) async {
//                                         await messageParser(val);
//                                       },
//                               ),
//                             ),
//                           )),
//                           SizedBox(
//                             width: 50,
//                             child: Center(
//                               child: IconButton(
//                                 onPressed: () {
//                                   if (_controller.text.isNotEmpty) {
//                                     String? strBlocked = widget.hiveHandler.encryptedTempBox.get("blocked");
//                                     // print("strBLocked: $strBlocked");
//                                     _formKey.currentState!.save();
//                                     FocusScope.of(context).unfocus();
//                                     // if (strBlocked != null) {
//                                     //   internalgbp.Blocks blocks = internalgbp.Blocks.fromBuffer(
//                                     //     strBlocked.codeUnits
//                                     //   );
//                                     //   if (!blocks.all.contains("")) {
//                                     //     _formKey.currentState!.save();
//                                     //     FocusScope.of(context).unfocus();
//                                     //   }
//                                     // }
//                                   }
//                                 },
//                                 icon: const Icon(
//                                   Icons.send,
//                                   size: 30,
//                                   color: Color.fromARGB(255, 135, 212, 182),
//                                 ),
//                               ),
//                             )
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             showAttachmentBox ? Positioned(
//               bottom: 50,
//               right: 5,
//               child: Material(
//                 type: MaterialType.transparency,
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     color: Colors.white
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: IconButton(
//                           color: primaryColor,
//                           icon: Icon(Icons.image),
//                           onPressed: () {
//                             chooseImage();
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: IconButton(
//                           color: primaryColor,
//                           icon: Icon(Icons.video_camera_back_outlined),
//                           onPressed: () async {
                            
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: IconButton(
//                           color: primaryColor,
//                           icon: Icon(Icons.picture_as_pdf_outlined),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ]
//                   )
//                 ),
//               )
//             ) : SizedBox()
//           ],
//         ));
//   }

//   Future<void> chooseImage() async {
//     const OpenFileDialogParams params = OpenFileDialogParams(
//       dialogType: OpenFileDialogType.image,
//       sourceType: SourceType.photoLibrary,
//       fileExtensionsFilter: ["jpeg", "png", "jpg"]
//     );
//     final String? filePath = await FlutterFileDialog.pickFile(params: params);
//     if (filePath != null) {

//       Chat chat = Chat(
//         sMID: widget.myData.mid,
//         self: true,
//         datetime: DateTime.now().toString(),
//         msg: filePath,
//         mloc: "",
//         tp: 21
//       );

//       // show on ui
//       taskItems.addItem(chat);
//       setState(() {
//         showAttachmentBox = false;
//       });
//     }
//   }

//   Future<void> messageParser(String? val) async {
//     Future<Uint8List> cipherText = aesEncrypt(
//       val!.codeUnits,
//       SecretKey(base64.decode(widget.myData.key))
//     );
//     cipherText.then((valCipherText) {
//       widget.wsSendPort.send(
//         SendPayload(
//           widget.myData.mid,
//           String.fromCharCodes(valCipherText),
//           1
//         )
//       );

//       Chat chat = Chat(
//         sMID: widget.myData.mid,
//         self: true,
//         datetime: DateTime.now().toString(),
//         msg: val,
//         mloc: "",
//         tp: 1
//       );

//       // write to the database
//       String? strGossipData = widget.hiveHandler._gossipsBox.get(
//         widget.myData.mid
//       );
//       Gossips gossip = Gossips();
//       if (strGossipData != null) {
//         gossip.toObject(strGossipData);
//         gossip.chats!.add(chat.toString());
//       } else {
//         gossip.chats = [];
//         gossip.chats!.add(chat.toString());
//       }
//       widget.hiveHandler._gossipsBox.put(
//         widget.myData.mid, gossip.toString()
//       );

//       // show on ui
//       taskItems.addItem(chat);
//       _controller.clear();

//       String? strGossips = widget.hiveHandler.recentGossipsBox.get(
//         widget.myData.mid
//       );
//       RecentGossips cDB;

//       if (strGossips == null) {
//         cDB = RecentGossips(
//           name: widget.myData.name,
//           lastMsg: val,
//           senderMID: widget.myData.mid,
//           dateTime: DateTime.now().toIso8601String(),
//           unSeenMsgCount: 0,
//           profilePic: widget.myData.profilepic
//         );
//         widget.hiveHandler.recentGossipsBox.put(
//           widget.myData.mid,
//           String.fromCharCodes(
//             cDB.writeToBuffer()
//           )
//         );
//       } else {
//         cDB = RecentGossips.fromBuffer(
//           strGossips.codeUnits
//         );
//         cDB.lastMsg = "You: " + val;
//         cDB.dateTime = DateTime.now().toIso8601String();
//         cDB.unSeenMsgCount = 0;
//         widget.hiveHandler.recentGossipsBox.put(
//           widget.myData.mid,
//           String.fromCharCodes(
//             cDB.writeToBuffer()
//           )
//         );
//       }
//       widget.rGossipController.sink.add(cDB);
//     });
//   }

//   Widget chatDisplayer(BuildContext context, int index) {
//     Chat chat = (listClass.list[index] as Chat);
//     print("chat tp: ${chat.tp}");
//     if (chat.tp == 1) {
//       return plainTextMessage(chat);
//     } else if (chat.tp == 21 || chat.tp == 22 || chat.tp == 23) {
//       return ChatImage(
//         initial: (chat.tp == 21) ? true : false,
//         chat: chat,
//         hiveHandler: widget.hiveHandler, 
//         myData: widget.myData,
//         rGossipController: widget.rGossipController,
//         wsSendPort: widget.wsSendPort
//       );
//     } else {
//       print("showing else");
//       return SizedBox();
//     }
//   }

//   Widget plainTextMessage(Chat chat) {
//     return Align(
//       alignment: chat.self ? Alignment.centerRight : Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 3.0),
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 7 / 10,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: !chat.self
//                   ? Radius.circular(0.0)
//                   : Radius.circular(10.0),
//               bottomRight: chat.self
//                   ? Radius.circular(0.0)
//                   : Radius.circular(10.0),
//               topLeft: Radius.circular(10.0),
//               topRight: Radius.circular(10.0),
//             ),
//             color: chat.self
//               ? Color.fromARGB(255, 135, 212, 182)
//               : Color.fromARGB(255, 114, 153, 242),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(chat.msg,
//                   style: TextStyle(
//                   color: Color.fromARGB(255, 28, 29, 77),
//                   fontSize: 16,
//                   )
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text(
//                     (
//                       (DateTime.parse(chat.datetime).hour) % 12
//                     ).toString() + ":" + DateTime.parse(chat.datetime).minute.toString(),
//                     style: const TextStyle(
//                       fontSize: 12, color: Colors.black54
//                     )
//                   ),
//                 ), // Icons.check_rounded
//               ],
//             ),
//           )
//         ),
//       ),
//     );
//   }
// }

