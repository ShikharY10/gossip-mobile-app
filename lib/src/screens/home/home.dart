// ignore_for_file: avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import '../../../database/hive_handler.dart';
import '../../../utility/gbp/internalProto.pb.dart';
import 'package:http/http.dart' as http;
import '../user/myProfile.dart';
import 'selector.dart';

List<String> numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

class HomePage extends StatefulWidget {
  final Stream<int> internetStatus;
  final String path;
  final HiveH hiveHandler;
  const HomePage({Key? key, required this.internetStatus, required this.hiveHandler, this.path = ""}) : super(key: key);
  
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
  bool changeColor = false;

  bool showImage = false;
  bool showLoader = false;

  String thumbnailUrl = "";

  @override
  initState() {
    super.initState();
    String strUser = widget.hiveHandler.userDataBox.get("userData")!;
    userData.toObject(strUser);

    widget.internetStatus.listen((event) {
      if (event == 1 && !changeColor) {
        setState(() {
          changeColor = true;
        });
      } else if (event == 0 && changeColor) {
        setState(() {
          changeColor = false;
        });
      }
    });
  }

  void testUploadChatImage() async {
    setState(() {
      showLoader = true;
    });
    String address1 = "10.0.2.2";
    String address2 = "192.168.43.58";
    const OpenFileDialogParams params = OpenFileDialogParams(
      dialogType: OpenFileDialogType.image,
      sourceType: SourceType.photoLibrary,
    );
    final String? filePath = await FlutterFileDialog.pickFile(params: params);
    if (filePath != null) {
      File file = File(filePath);
      Uint8List imageData = await file.readAsBytes();

      final fileBytes = File(filePath).readAsBytesSync();
      final data = await readExifFromBytes(fileBytes);
      print("data: $data");
      print(data["Image ImageWidth"]);
      String bimage = base64.encode(imageData);

      Map<String, String> allData = {
        "name": "Shikhar Yadav",
        "image": bimage,
        "ext": filePath.split(".")[filePath.split(".").length-1]
      };
      
      String body = json.encode(allData);
      Future<http.Response> res = http.post(
        Uri.parse("http://$address2:8080/api/v3/upload/chat/image"),
        body: body
      );
      res.then((value) async {
        if (value.statusCode == 200) {
          String res = String.fromCharCodes(value.bodyBytes);
          Map<String, dynamic> response = json.decode(res);
          print("Done!");
          print("Response: $response");
          print(response["data"].runtimeType);
          Map<String, dynamic> data = json.decode(response["data"]);
          setState(() {
            showLoader = false;
            thumbnailUrl = data["secureUrl"];
            showImage = true;
          });
          // print("secureUrl: ${response["secureUrl"]}");
          // print("publicId : ${response["publicId"]}");
        }
      }); 
    }
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
                  child: showImage ? CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: NetworkImage(getProperSizeThumbnailUrl(thumbnailUrl)),
                  ) : showLoader ? const CircularProgressIndicator(color: Colors.red) : IconButton(
                    icon: Icon(
                      Icons.online_prediction_rounded, 
                      color: changeColor ? Color.fromARGB(255, 255, 81, 0) : Color.fromARGB(255, 28, 29, 77)
                    ),
                    onPressed: () async {
                      testUploadChatImage();
                    },
                  ),
                ),
              ],
            ),
            flex: 2
          ),
          Expanded(
            child: Selector(
              hiveHandler: widget.hiveHandler, 
              path: widget.path,
              internetStatus: widget.internetStatus,
            ),            
            flex: 9
          )
        ],
      )
    );
  }

  String getProperSizeThumbnailUrl(String url) {
    List<String> lUrl = url.split("upload");
    String newURL = lUrl[0] + "upload" + "/c_scale,w_0.10" + lUrl[1];
    return newURL;
  }
}
// c_scale,w_0.25
// https://res.cloudinary.com/demo/image/
// /docs/models.jpg
// https://res.cloudinary.com/demo/image/upload/docs/models.jpg