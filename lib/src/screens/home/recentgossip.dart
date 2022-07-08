import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/gbp/internalProto.pb.dart' as internalgbp;
import '../../../database/hive_handler.dart';
import '../../../providers/list_provider.dart';
import '../../../utility/gbp/internalProto.pb.dart';
import '../../../utility/ws/wsutils.dart';
import '../chats/chatui.dart';

class AllRecentGossip extends StatefulWidget {
  List<RecentGossips> allGossip = [];
  HiveH hiveHandler;
  Stream<RecentGossips> rGossipStream;
  Stream<Chat> chatStream;
  StreamController<RecentGossips> rGossipController;
  SendPort wsSendPort;
  AllRecentGossip({ Key? key, required this.allGossip, required this.hiveHandler, required this.rGossipStream, required this.chatStream, required this.rGossipController, required this.wsSendPort}) : super(key: key);
  @override
  State<AllRecentGossip> createState() => _AllRecentGossipState();
}

class _AllRecentGossipState extends State<AllRecentGossip> {

  late List<RecentGossips> allGossips;
  late StreamSubscription<RecentGossips> sub;

  void listenForUiEvent() {
    bool found = false;
    int i = -1;
    sub = widget.rGossipStream.listen((event) {
      print("new event");
      allGossips.forEach((element) {
        if (element.senderMID == event.senderMID) {
          found = true;
          i = allGossips.indexOf(element);
        }
      });
      if (!found) {
        allGossips.add(event);
      } else {
        allGossips[i] = event;
      }
      
      // allGossips.sort( (a, b) {
      //   var aDT = DateTime.parse(a.dateTime);
      //   var bDT = DateTime.parse(b.dateTime);
      //   return aDT.compareTo(bDT);
      // });
      setState(() {});
    });

  }

  void getAllRecentGossips() {
    // Box<String> recentGossips = Hive.box<String>("recentgossips");
    List<String> all = widget.hiveHandler.recentGossipsBox.values.toList();
    List<internalgbp.RecentGossips> allChat = [];
    for (int i = 0; i < all.length; i++) {
      internalgbp.RecentGossips c = internalgbp.RecentGossips.fromBuffer(all[i].codeUnits);
      allChat.add(c);
    }
    allChat.sort(
      (a,b) {
        int aDate = DateTime.parse(a.dateTime).microsecondsSinceEpoch;
        int bDate = DateTime.parse(b.dateTime).microsecondsSinceEpoch;
        return aDate.compareTo(bDate);
      }
    );
    allGossips = allChat;
  }

  @override
  void dispose() {
    print("dispose called");
    super.dispose();
    sub.cancel();
  }
  
  @override
  initState() {
    super.initState();
    getAllRecentGossips();
    // allGossips = widget.allGossip;
    listenForUiEvent();
  }
  
  @override
  Widget build(BuildContext context) {
    return allGossips.isNotEmpty ? ListView.builder(
      itemCount: allGossips.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 2.0, left: 10.0, right: 10.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: MemoryImage(
                  base64.decode(allGossips[i].profilePic)
                ), //AssetImage("assets/images/white.jpeg"), /
                radius: 20,
              ),
              title: Text(allGossips[i].name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 135, 212, 182),
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                )
              ),
              subtitle: Text(
                allGossips[i].lastMsg,
                style: TextStyle(
                  color: Color.fromARGB(255, 79, 100, 92)
                )
              ),
              trailing: Column(
                children: [
                  (allGossips[i].unSeenMsgCount != 0) ? Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor:
                          const Color.fromARGB(255, 43, 60, 135),
                      child: Text(allGossips[i].unSeenMsgCount.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ) : const SizedBox(
                    height: 16,
                    width: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(((DateTime.parse(allGossips[i].dateTime).hour)%12).toString() + ":" + DateTime.parse(allGossips[i].dateTime).minute.toString(),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  )
                ],
              ),
              onTap: () {
                String? myStrData = widget.hiveHandler.connectionsBox.get(allGossips[i].senderMID);
                Connection conn = Connection();
                conn.toObject(myStrData!);

                String? strRGossip = widget.hiveHandler.recentGossipsBox.get(conn.mid);
                RecentGossips rgossip = RecentGossips.fromBuffer(strRGossip!.codeUnits);
                rgossip.unSeenMsgCount = 0;
                widget.hiveHandler.recentGossipsBox.put(conn.mid, String.fromCharCodes(rgossip.writeToBuffer()));
                setState(() {
                  allGossips[i].unSeenMsgCount = 0;
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ChangeNotifierProvider(
                              create: (context) => ListProvider(),
                              child: ChatUI(
                                myData: conn,
                                wsSendPort: widget.wsSendPort,
                                hiveHandler: widget.hiveHandler,
                                chatStream: widget.chatStream,
                                rGossipController: widget.rGossipController,
                              ),
                            )
                          )
                        );
              },
            ),
          );
        }) : alternativeTOChatList();
  }

  Widget alternativeTOChatList({String msg = "You Have Not Done Any Gossips Yet!"}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/find.gif"
          ),
          Text(msg,
          style: const TextStyle(
            color: Color(0xFF87D4B6),
            fontWeight: FontWeight.bold,
          ),
          ),
        ],
      )
    );
  }

  String getPlainMsg(String msg, String sid) {
    // Box<String> connData = Hive.box<String>("connections");
    String connS = widget.hiveHandler.connectionsBox.get(sid)!;
    Connection connection = Connection();
    connection.toObject(connS);
    Future<List<int>> plainMsg = aesDecrypt(Uint8List.fromList(msg.codeUnits), SecretKey(base64.decode(connection.key)));
    plainMsg.then((value) {
      return value.toString();
    });
    return "";
  }
}

