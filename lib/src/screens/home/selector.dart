
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import '../../../utility/gbp/gbProto.pb.dart' as gbp;
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../database/hive_handler.dart';
import '../../../utility/gbp/internalProto.pb.dart' as internalgbp;
import '../../../utility/ws/wsutils.dart';
import 'allconnections.dart';
import 'allcontacts.dart';
import 'recentgossip.dart';

class Selector extends StatefulWidget {
  HiveH hiveHandler;
  String path;
  Selector({ Key? key, required this.hiveHandler, required this.path}) : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {

  List<internalgbp.RecentGossips> allGossips = [];
  List<internalgbp.Contact> allContacts = [];
  List<Connection> allConnections = [];
  List<String> allConnMid = [];

  bool isRecentChat = true;
  bool isContacts = false;
  bool isConnections = false;
  bool isSetupDone = false;

  late SendPort wsSendPort;
  User myData = User();

  StreamController<Chat> chatController = StreamController<Chat>();
  late Stream<Chat> chatStream;

  StreamController<internalgbp.RecentGossips> rGossipController = StreamController<internalgbp.RecentGossips>();
  late Stream<internalgbp.RecentGossips> rGossipStream;

  StreamController<HandShackNotification> contactSController = StreamController<HandShackNotification>();
  late Stream<HandShackNotification> contactStream;

  @override
  void initState() {
    super.initState();

    contactStream = contactSController.stream.asBroadcastStream();
    chatStream = chatController.stream.asBroadcastStream();
    rGossipStream = rGossipController.stream.asBroadcastStream();
    String strUser = widget.hiveHandler.userDataBox.get("userData")!;
    myData.toObject(strUser);
    createIsolate(myData, widget.path);
    getAllConnections();
    getAllContacts();
    getAllRecentGossips();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: checkColor(isRecentChat)),
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("Chat clicked");
                              isRecentChat = true;
                              isConnections = false;
                              isContacts = false;
                              setState(() {});
                            },
                            
                            
                            child: sectionText("Chat")
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: checkColor(isConnections)),
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("Connection clicked");
                              isRecentChat = false;
                              isConnections = true;
                              isContacts = false;
                              setState(() {});
                            },
                            child: sectionText("Connection")
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: checkColor(isContacts)),
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("Contact clicked");
                              isRecentChat = false;
                              isConnections = false;
                              isContacts = true;
                              setState(() {});
                            },
                            child: sectionText("Contacts")
                          ),
                        ),
                      )
                    ),
                  ]
                ),
              )
            ),
          ),
          Expanded(flex: 13,child: resolveWidgets())
        ]
      )
      // child: allGossips.isNotEmpty ? AllChatList(allGossips) : AlternativeTOChatList(),
    );
  }

  Widget alternativeTOChatList({String msg = "You Have Not Done Any Gossips Yet!"}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/ghost.gif"
          ),
          Text(msg,
          style: const TextStyle(
            color: Color.fromARGB(255, 56, 68, 112),
            fontWeight: FontWeight.bold,
          ),
          ),
        ],
      )
    );
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(255, 135, 212, 182),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget resolveWidgets() {
    if (isRecentChat) {
      isConnections = false;
      isContacts = false;
      return isSetupDone ? AllRecentGossip(
        allGossip: allGossips,
        hiveHandler: widget.hiveHandler,
        rGossipStream: rGossipStream,
        chatStream: chatStream,
        rGossipController: rGossipController,
        wsSendPort: wsSendPort,
        ) : const Center(
          child: CircularProgressIndicator(
            color: Colors.red
          ),
        );
    }
    else if (isConnections) {
      isRecentChat = false;
      isContacts = false;
      return AllConnection(
        allConnection: allConnections,
        allConnMid: allConnMid,
        hiveHandler: widget.hiveHandler,
        wsSendPort: wsSendPort,
        chatStream: chatStream,
        rGossipController: rGossipController
        );
    }
    else if (isContacts) {
      isRecentChat = false;
      isConnections = false;
      return AllContacts(
        allContacts: allContacts,
        hiveHandler: widget.hiveHandler,
        wsSendPort: wsSendPort,
        contactStream: contactStream,
      );
    }
    else {
      return alternativeTOChatList(msg: "nothing!");
    }
  }

  Color checkColor(bool check) {
    if (check) {
      return const Color.fromARGB(255, 135, 212, 182);
    }
    else {
      return Color.fromARGB(255, 28, 29, 77);
    }
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

  void getAllContacts() {
    String? strContacts = widget.hiveHandler.encryptedTempBox.get("contacts");
    if (strContacts != null) {
      internalgbp.Contacts contacts = internalgbp.Contacts.fromBuffer(strContacts.codeUnits);
      allContacts = contacts.all;
    } else {
      try {
        var contacts = FlutterContacts.getContacts(withProperties: true);
        contacts.then((value) {
          for (int i = 0; i < value.length; i++) {
            if (value[i].phones.isNotEmpty) {
              var numbers = value[i].phones;
              String resNumber = resolveNumber(numbers[0].number);
              if (resNumber.isNotEmpty) {
                internalgbp.Contact contact = internalgbp.Contact(
                  name: value[i].displayName,
                  number: resNumber,
                  done: false,
                  inProcess: false,
                  blocked: false,
                  intoggleblock: false,
                );
                allContacts.add(contact);
              }              
            }
          }
          if (allContacts.isNotEmpty) {
            internalgbp.Contacts contacts = internalgbp.Contacts(
              all: allContacts
            );
            String strContacts = String.fromCharCodes(contacts.writeToBuffer());
            widget.hiveHandler.encryptedTempBox.put("contacts", strContacts);
          }
        });
      } on Exception catch (e) {
        print("ERROR: $e");
      }
    }

  }

  void getAllConnections() {
    // Box<String> connBox = Hive.box<String>("connections");
    List<String> allconns = widget.hiveHandler.connectionsBox.values.toList();
    for (int i = 0; i < allconns.length; i++) {
      Connection conn = Connection();
      conn.toObject(allconns[i]);
      if (allConnMid.contains(conn.mid)) {
        continue;
      }else {
        allConnMid.add(conn.mid);
        allConnections.add(conn);
      }
    }
  }

  Future createIsolate(User userData, String path) async {
    ReceivePort mainReceivePort = ReceivePort();
    String address = widget.hiveHandler.tempBox.get("ipaddress")!;
    Isolate.spawn<IsolateModel>(isolateRunner, IsolateModel(address, mainReceivePort.sendPort, userData.mid, userData.uid, userData.mainKey, path));

    mainReceivePort.listen((data) {
      if (data is SendPort) {
        wsSendPort = data;
        wsSendPort.send(userData);
        isSetupDone = true;     
        setState(() {
          
        });
      }
      else if (data is Chat) {
        String? prevMsg = widget.hiveHandler.gossipsBox.get(data.sMID);
        Gossips gossip = Gossips();
        if (prevMsg != null) {
          gossip.toObject(prevMsg);
        }
        else {
          gossip.chats = [];
        }

        Connection myData = Connection();
        String? strMyData = widget.hiveHandler.connectionsBox.get(data.sMID);
        myData.toObject(strMyData!);

        Future<List<int>> fmsg = aesDecrypt(
          Uint8List.fromList(data.msg.codeUnits),
          SecretKey(base64.decode(myData.key))
        );

        fmsg.then( (msg) {
          data.msg = String.fromCharCodes(msg);
          gossip.chats?.add(data.toString());
          widget.hiveHandler.gossipsBox.put(data.sMID, gossip.toString());
          chatController.sink.add(data);

          String? strGossips = widget.hiveHandler.recentGossipsBox.get(data.sMID);
          internalgbp.RecentGossips CDB;

          if (strGossips == null) {
            CDB = internalgbp.RecentGossips(
              name: myData.name,
              lastMsg: String.fromCharCodes(msg),
              senderMID: data.sMID,
              dateTime: DateTime.now().toIso8601String(),
              unSeenMsgCount: 1,
              profilePic: myData.profilepic
            );
            widget.hiveHandler.recentGossipsBox.put(data.sMID, String.fromCharCodes(CDB.writeToBuffer()));
          } else {
            CDB = internalgbp.RecentGossips.fromBuffer(strGossips.codeUnits);
            CDB.lastMsg = String.fromCharCodes(msg);
            CDB.dateTime = DateTime.now().toIso8601String();
            CDB.unSeenMsgCount = 1 + CDB.unSeenMsgCount;
            widget.hiveHandler.recentGossipsBox.put(data.sMID, String.fromCharCodes(CDB.writeToBuffer()));
          }
          rGossipController.sink.add(CDB);
        });

        wsSendPort.send(AckPayload(data.sMID, data.mloc));  
      }
      else if (data is Connection) {
        widget.hiveHandler.connectionsBox.put(data.mid, data.toJson());
      }
      else if (data is HandShackNotification) {
        getAllConnections();
        contactSController.sink.add(data);
        print("handshack notification");
      } 
      else if (data is gbp.HandshakeDeleteNotify) {
        widget.hiveHandler.connectionsBox.delete(data.senderMID);
        HandShackNotification notify = HandShackNotification(0, true, data.number);
        contactSController.sink.add(notify);
      }
      else if (data is gbp.ChangeProfilePayload) {
        print("profile change notification");
        String? strConn = widget.hiveHandler.connectionsBox.get(data.senderMID);
        print("strConn: $strConn");
        if (strConn != null) {
          Connection conn = Connection();
          conn.toObject(strConn);
          conn.profilepic = data.picData;
          widget.hiveHandler.connectionsBox.put(data.senderMID, conn.toJson());
        }



      }
    });
  }
}


String resolveNumber(String number) {
  String temp = "";
  for (int i = 0; i < number.length; i++) {
    if (numberList.contains(number[i])) {
      temp = temp + number[i];
    }                        
  }
  if (temp.length == 10) {
    return temp;
  }
  else if (temp.length > 10) {
    return temp.substring(temp.length - 10);

  }
  else {
    return "";
  }
}
