// ignore_for_file: avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/material.dart';
import '../../../database/hive_handler.dart';
import '../../../utility/gbp/internalProto.pb.dart';
import '../user/myProfile.dart';
import 'selector.dart';

List<String> numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

class HomePage extends StatefulWidget {
  final StreamController<bool> allConnectionStatus;
  String path;
  HiveH hiveHandler;
  HomePage({Key? key, required this.allConnectionStatus, required this.hiveHandler, this.path = ""}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<RecentGossips> allGossips = [];
  List<Map<String, String>> allContacts = [];
  List<Connection> allConnections = [];
  List<String> allConnMid = [];

  bool isRecentChat = true;
  bool isContacts = false;
  bool isConnections = false;

  late SendPort wsSendPort;
  late StreamController<Chat> myStreamController = StreamController();
  late Stream<Chat> myStream = myStreamController.stream.asBroadcastStream();
  User userData = User();

  @override
  initState() {
    super.initState();
    String strUser = widget.hiveHandler.userDataBox.get("userData")!;
    userData.toObject(strUser);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 135, 212, 182),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () async {
                      print("Icon Button Clicked For List.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyProfile(hiveHandler: widget.hiveHandler)
                        )
                      );
                    },
                    icon: const Icon(Icons.person, color: Color.fromARGB(255, 28, 29, 77))),
                ),
                const Expanded(
                    flex: 8,
                    child: Center(
                      child: Text("GossiP",
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 29, 77),
                          fontSize: 24,
                          fontWeight: FontWeight.w900
                        )
                      ),
                    ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.online_prediction_rounded, color: Color.fromARGB(255, 28, 29, 77)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            flex: 2
          ),
          Expanded(
            child: Selector(hiveHandler: widget.hiveHandler, path: widget.path),            
            flex: 9
          )
        ],
      )
    );
  }


}
