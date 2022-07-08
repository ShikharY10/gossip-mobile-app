// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gossip_frontend/src/screens/user/imagepreview.dart';
import '../../../database/hive_handler.dart';

class UserProfile extends StatefulWidget {
  HiveH hiveHandler;
  String mid;
  UserProfile({Key? key, required this.hiveHandler, required this.mid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Connection friendData = Connection();
  bool dataObtained = false;

  @override
  initState() {
    super.initState();
    String? strFriendData = widget.hiveHandler.connectionsBox.get(widget.mid);
    if (strFriendData != null) {
      friendData.toObject(strFriendData);
      dataObtained = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 135, 212, 182),
      child: dataObtained ? Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_left_rounded,
                              color: Color.fromARGB(255, 28, 29, 77)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Stack(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: MemoryImage(base64.decode(friendData.profilepic)), //AssetImage("assets/images/white.jpeg"), /
                                    radius: 40,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => ImagePreview(imageData: base64.decode(friendData.profilepic), name: friendData.name)
                                      )
                                    );
                                  },
                                ),
                                Positioned(
                                  left: 40,
                                  top: 40,
                                  child: Container(
                                    
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      
                                      color: Color.fromARGB(153, 38, 38, 39),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: Icon(Icons.mode_edit, size: 30,),
                                      onPressed: () {
                                        print("profile pic edit clicked");
                                      }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Icon(
                            Icons.arrow_circle_left_rounded,
                            color: Color.fromARGB(255, 135, 212, 182)
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(friendData.name.toUpperCase(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 28, 29, 77),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("Goinng Invisible");
                            },
                            icon: const Icon(Icons.admin_panel_settings_outlined,
                                color: Color.fromARGB(255, 28, 29, 77))),
                        IconButton(
                            onPressed: () {
                              print("Goinng Invisible");
                            },
                            icon: const Icon(Icons.call, color: Color.fromARGB(255, 28, 29, 77))),
                        IconButton(
                            onPressed: () {
                              print("Goinng Invisible");
                            },
                            icon: const Icon(Icons.video_call, color: Color.fromARGB(255, 28, 29, 77)))
                      ],
                    )
                  ],
                ),
              ),
              flex: 3),
          Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 28, 29, 77),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(54, 135, 212, 182),
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                const Text("Number:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(friendData.mnum,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ),
                              ],
                            ),
                            trailing: Material(
                              type: MaterialType.transparency,
                              child: IconButton(
                                splashRadius: 20,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  print("Edit clicked");
                                }
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(54, 135, 212, 182),
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                const Text("ID :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(friendData.mid,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(54, 135, 212, 182),
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                          child: ListTile(
                            title: Row(
                              children: const [
                                Text("DOB   :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("10/03/2002",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            widget.hiveHandler.gossipsBox.clear();
                            print("All gossips have been removed.");
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 135, 212, 182),
                            ),
                            child: const Center(
                              child: Text("Erase Connections", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              )),
                            )

                          )
                        ),
                      )
                    ]
                    ),
                  )),
              flex: 8)
        ],
      ) : const Center(
        child: Text("Something Went Wrong!")
      ),
    );
  }
}
