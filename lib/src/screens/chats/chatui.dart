// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:gossip_frontend/main.dart';
import 'package:provider/provider.dart';
import '../../../database/hive_handler.dart';
import '../../../providers/list_provider.dart';
import '../../../providers/models.dart';
import '../../../utility/gbp/internalProto.pb.dart';
import '../../../utility/ws/wsutils.dart';
import '../user/userprofile.dart';
import '../../../utility/gbp/internalProto.pb.dart' as internalgbp;

class ChatUI extends StatefulWidget {
  Connection myData;
  final SendPort wsSendPort;
  HiveH hiveHandler;
  Stream<Chat> chatStream;
  StreamController<RecentGossips> rGossipController;
  ChatUI({ Key? key, required this.myData, required this.wsSendPort, required this.hiveHandler, required this.chatStream, required this.rGossipController}) : super(key: key);

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _controller = TextEditingController();

  var taskItems;

  int counter = 0;

  late DynamicList listClass;

  void listenForUIEvent() {
    widget.chatStream.listen((event) {
      print("msg received");
      try {
        taskItems.addItem(event);
      } on Exception {}
    });
  }

  void getAllGossips() {
    String? strGossip = widget.hiveHandler.gossipsBox.get(widget.myData.mid);
    if (strGossip == null) return;
    Gossips gossips = Gossips();
    gossips.toObject(strGossip);
    
    gossips.chats!.forEach((element) {
      Chat chat = Chat();
      chat.toObject(element);
      listClass.list.add(chat);
    });
  }


  @override
  void initState() {
    super.initState();
    taskItems = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(taskItems.list);
    getAllGossips();
    listenForUIEvent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 135, 212, 182),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_circle_left, color: Color.fromARGB(255, 28, 29, 77))
            ),
            title: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Color.fromARGB(255, 148, 148, 167),
                radius: 40,
                onTap: () {
                  print("Profile Clicked");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => UserProfile(hiveHandler: widget.hiveHandler, mid: widget.myData.mid)
                    )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: MemoryImage(base64.decode(widget.myData.profilepic)), //AssetImage("assets/images/white.jpeg"), /
                      radius: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.myData.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 28, 29, 77)
                        )
                        ),
                    )
                  ]
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call, color: Color.fromARGB(255, 28, 29, 77)),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_call, color: Color.fromARGB(255, 28, 29, 77)),
              ),
            ],
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
      body: Container(
        color: const Color.fromARGB(255, 135, 212, 182),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 28, 29, 77),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Consumer<ListProvider>(
                builder: (contex, provider, listTile) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: listClass.list.length,
                        itemBuilder: buildListTwo,
                        reverse: false,
                      ),
                    )
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          print("Camera Clicked");
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Color.fromARGB(255, 135, 212, 182),
                          )
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: TextFormField(
                            cursorColor: Colors.yellow,
                            style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                            maxLines: 4,
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Message",
                              contentPadding: const EdgeInsets.all(10.0),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 135, 212, 182),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 1.0),
                                child: IconButton(
                                  color: const Color.fromARGB(255, 28, 29, 77),
                                  icon: const Icon(Icons.emoji_emotions),
                                  onPressed: () {
                                    print("Emoji Clicked");
                                  },
                                ),
                              ),
                              suffixIcon: IconButton(
                                color: const Color.fromARGB(255, 28, 29, 77),
                                icon: const Icon(Icons.add_to_photos_sharp ),
                                onPressed: () {
                                  print("Attachment Clicked");
                                },
                              ),
                            ),
                            onSaved: (val) async {
                              Future<Uint8List> CipherText = aesEncrypt(val!.codeUnits, SecretKey(base64.decode(widget.myData.key)));
                              CipherText.then((valCipherText) {
                                widget.wsSendPort.send(SendPayload(widget.myData.mid, String.fromCharCodes(valCipherText)));
                                
                                Chat chat = Chat(
                                  sMID: widget.myData.mid,
                                  self: true,
                                  datetime: DateTime.now().toString(),
                                  msg: val,
                                  mloc: "",
                                );

                                // write to the database
                                String? strGossipData = widget.hiveHandler.gossipsBox.get(widget.myData.mid);
                                Gossips gossip = Gossips();
                                if (strGossipData != null) {                    
                                  gossip.toObject(strGossipData);
                                  gossip.chats!.add(chat.toString());
                                } else {
                                  gossip.chats = [];
                                  gossip.chats!.add(chat.toString());
                                }
                                widget.hiveHandler.gossipsBox.put(widget.myData.mid, gossip.toString());
                                // show on ui
                                taskItems.addItem(chat);
                                _controller.clear();

                                String? strGossips = widget.hiveHandler.recentGossipsBox.get(widget.myData.mid);
                                RecentGossips CDB;

                                if (strGossips == null) {
                                  CDB = RecentGossips(
                                    name: widget.myData.name,
                                    lastMsg: val,
                                    senderMID: widget.myData.mid,
                                    dateTime: DateTime.now().toIso8601String(),
                                    unSeenMsgCount: 0,
                                    profilePic: widget.myData.profilepic
                                  );
                                  widget.hiveHandler.recentGossipsBox.put(widget.myData.mid, String.fromCharCodes(CDB.writeToBuffer()));
                                } else {
                                  CDB = RecentGossips.fromBuffer(strGossips.codeUnits);
                                  CDB.lastMsg = val;
                                  CDB.dateTime = DateTime.now().toIso8601String();
                                  CDB.unSeenMsgCount = 0;
                                  widget.hiveHandler.recentGossipsBox.put(widget.myData.mid, String.fromCharCodes(CDB.writeToBuffer()));
                                }
                                widget.rGossipController.sink.add(CDB);
                                });
                            },
                            // validator: (val) {
                            //   if (val!.isNotEmpty) {
                            //     return null;
                            //   } else {
                            //     return "";
                            //   }
                            // }
                          ),
                        ),
                      )
                    ),
                    SizedBox(
                      width: 50,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              String? strBlocked = widget.hiveHandler.encryptedTempBox.get("blocked");
                              if (strBlocked != null) {
                                internalgbp.Blocks blocks = internalgbp.Blocks.fromBuffer(strBlocked.codeUnits);

                              }
                              _formKey.currentState!.save();
                              FocusScope.of(context).unfocus();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 30,
                            color: Color.fromARGB(255, 135, 212, 182),
                            ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildListTwo(BuildContext context, int index) {
    return Align(
  alignment: listClass.list[index].self ? Alignment.centerRight : Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 7 / 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: !listClass.list[index].self ? Radius.circular(0.0) : Radius.circular(10.0),
          bottomRight: listClass.list[index].self ? Radius.circular(0.0) : Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: listClass.list[index].self ? Color.fromARGB(255, 135, 212, 182) : Color.fromARGB(255, 114, 153, 242),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              listClass.list[index].msg,
              style: TextStyle(
                color: Color.fromARGB(255, 28, 29, 77),
                fontSize: 16,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(((DateTime.parse(listClass.list[index].datetime).hour)%12).toString() + ":" + DateTime.parse(listClass.list[index].datetime).minute.toString(),
                style: const TextStyle(
                  fontSize: 12, color: Colors.black54
                )
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 3.0),
            //   child: Icon(Icons.error, size: 15, color: Color.fromARGB(255, 255, 0, 0)),
            // ),  // Icons.check_rounded
          ],
        ),
      )
    ),
  ),
);
  }

}

// void getAllGossips() async {
//     Uint8List aesKey = base64.decode(myData.key);
//     String? msgs = widget.hiveHandler.gossipsBox.get(myData.mid);
//     if (msgs != null) {
//       Gossips g = Gossips();
//       g.toObject(msgs);
//       if (g.chats!.isNotEmpty) {
//         for (int i = 0; i < g.chats!.length; i++) {
//           Chat chat = Chat();
//           chat.toObject(g.chats![i]);
//           try {
//             chat.msg = await decryptmsg(aesKey, chat.msg);
//           } on SecretBoxAuthenticationError {
//             continue;
//           }
          
//           myChat.add(chat);
//         }
//         allMsgLoaded = true;
//         setState(() {});
//       }
//       allMsgLoaded = true;
//       setState(() {});
//     } else {
//       allMsgLoaded = true;
//       setState(() {});
//     }
//   }