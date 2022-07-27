// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../utility/gbp/internalProto.pb.dart' as internalgbp;

import '../../../database/hive_handler.dart';
import '../../../utility/widget/alerbox.dart';
import '../../../utility/widget/customhandshakeicon.dart';
import '../../../utility/ws/wsutils.dart';

List<String> numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];


class AllContacts extends StatefulWidget {
  List<internalgbp.Contact> allContacts = [];
  HiveH hiveHandler;
  SendPort wsSendPort;
  Stream<HandShackNotification> contactStream;
  AllContacts({ Key? key, required this.allContacts, required this.hiveHandler, required this.wsSendPort, required this.contactStream}) : super(key: key);

  @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  late List<internalgbp.Contact> allContacts;
  late String userMID;
  bool checkBoxOne = false;
  bool checkBoxTwo = false;

  String address = "10.0.2.2";

  @override
  initState() {
    super.initState();
    address = widget.hiveHandler.tempBox.get("ipaddress")!;
    allContacts = widget.allContacts;
    try {
      widget.contactStream.listen((event) {
        print("event number: ${event.number} | type ${event.type}");
        int i = findIndex(allContacts, event.number);
        if (event.type == 1) {
          allContacts[i].done = true;
        } else if (event.type == 0) {
          allContacts[i].done = false;
        } else if (event.type == 2) {
          allContacts[i].done = true;
          allContacts[i].inlogin = false;
        }
        allContacts[i].inProcess = false;
        setState(() {});
        Uint8List strAllCon = internalgbp.Contacts(all: allContacts).writeToBuffer();
        widget.hiveHandler.encryptedTempBox.put("contacts", String.fromCharCodes(strAllCon));
      });
    } on Exception catch (e) {}
    

    String userData =  widget.hiveHandler.userDataBox.get("userData")!;
    User user = User();
    user.toObject(userData);
    userMID = user.mid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(Icons.sort_rounded),
                  onPressed: () {
                    print("Sort Clicked");
                  },
                  splashColor: Colors.grey,
                  splashRadius: 20,
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(Icons.refresh_rounded),
                  onPressed: () {
                    print("Refresh Clicked");
                    getAllContacts();
                  },
                  splashColor: Colors.grey,
                  splashRadius: 20,
                ),
              )
            ]
          ),
        ),
        Expanded(
          flex: 1,
          child: allContacts.isNotEmpty ? ListView.builder(
          itemCount: allContacts.length,
          itemExtent: 50,
          // shrinkWrap: true,
          itemBuilder: (BuildContext context, int i) {
            
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 0.0, left: 10.0, right: 10.0),
                child: ListTile(
                  title: Text(allContacts[i].name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 135, 212, 182),
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  subtitle: Text(
                    allContacts[i].number,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 79, 100, 92)
                    )
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width/3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: IconButton(
                              icon: allContacts[i].intoggleblock ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue
                                )
                              ) : Icon(Icons.block_flipped,
                                color: allContacts[i].blocked ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context, 
                                  builder: (context) => toggleBlock(
                                    allContacts[i].blocked,
                                    allContacts[i].name,
                                    i
                                  )   //allContacts[i].blocked ? unBlockContact(i) : blockContact(i)
                                );
                              },
                            )
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: IconButton(
                              icon: allContacts[i].inProcess ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color.fromARGB(255, 135, 212, 182)
                                )
                              ) : Icon( allContacts[i].done ? CustomHandShakeIcons.handshake_alt_slash : CustomHandShakeIcons.handshake,
                                color: allContacts[i].inlogin ? Colors.orange : allContacts[i].done ? Color.fromARGB(255, 135, 212, 182) : Colors.grey
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context, 
                                  builder: (context) => toggleHandshake(
                                    allContacts[i].done,
                                    allContacts[i].name,
                                    i
                                  )
                                );
                              },
                              splashRadius: 20,
                              splashColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/find.gif"
                ),
                const Text("No contact found!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 212, 182),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    );
  }

  Widget toggleHandshake(bool isDone, String name, int index) {
    if (isDone) {
      return AlertScreen(
        title: "Remove $name?",
        content: "This action will stop communication with $name",
        firstButtonName: "Remove", 
        secondButtonName: "Cancel",
        firstButtonOnTap: () {
          Navigator.pop(context);
          setState(() {
            allContacts[index].inProcess = true;
          });

          Map payload = {
            'usermid': userMID,
            'targetnum': allContacts[index].number,
          };
          var body = json.encode(payload);
          var rawResponse = http.post(
            Uri.parse("http://$address:8080/removehs"),
            body: body
          );

          rawResponse.then((value) {
            if (value.statusCode == 200) {
              String res = String.fromCharCodes(value.bodyBytes);
              var response = json.decode(res);
              if (response["status"] == "successful") {
                setState(() {
                  allContacts[index].done = false;
                  allContacts[index].inProcess = false;
                });
                Uint8List strAll = internalgbp.Contacts(all: allContacts).writeToBuffer();
                widget.hiveHandler.encryptedTempBox.put("contacts", String.fromCharCodes(strAll));
                widget.hiveHandler.connectionsBox.delete(response["disc"]);
              }
            } else {
              setState(() {
                allContacts[index].inProcess = false;
              });
              Navigator.pop(context);
            }
          });


        },
        secondButtonOnTap: () {
          setState(() {
            allContacts[index].inProcess = false;
          });
          Navigator.pop(context);
        },
      );
    } else {
      return AlertScreen(
        title: "Start Handshake with $name?",
        content: "This action will allow you to start communication with $name",
        firstButtonName: "Handshake", 
        secondButtonName: "Cancel",
        firstButtonOnTap: () async {
          print("HandShake");
          setState(() {
            allContacts[index].inProcess = true;
          });
          // var delay = Future.delayed(const Duration(seconds: 60));
          // delay.then((value) {
          //   setState(() {
          //     allContacts[index].inProcess = false;
          //   });
          // });
          widget.wsSendPort.send(HandshackPayload(allContacts[index].number));
          Navigator.pop(context);
        },
        secondButtonOnTap: () {

          Navigator.pop(context);
          setState(() {
            allContacts[index].inProcess = false;
          });
        },
      );
    }
  }

  Widget toggleBlock(bool isBlocked, String name, int index) {
    if (isBlocked) {
      return AlertScreen(
        title: "Unblock $name?",
        content: "This action will allow $name to start communication with you.",
        firstButtonName: "Unblock",
        secondButtonName: "Cancel",
        firstButtonOnTap: () {
          allContacts[index].intoggleblock = false;
            setState(() {});
            Navigator.pop(context);

            Map payload = {
              'type': -1,
              'sendermid': userMID,
              'number': allContacts[index].number
            };
            var body = json.encode(payload);
            var rawResponse = http.post(
              Uri.parse("http://$address:8080/toggleblock"),
              body: body
            );
            rawResponse.then((value) {
              if (value.statusCode == 200) {
                String res = String.fromCharCodes(value.bodyBytes);
                var response = json.decode(res);
                if (response["status"] == "successful") {
                  setState(() {
                    allContacts[index].blocked = false;
                    allContacts[index].intoggleblock = false;
                  });
                  Uint8List strAll = internalgbp.Contacts(all: allContacts).writeToBuffer();
                  widget.hiveHandler.encryptedTempBox.put("contacts", String.fromCharCodes(strAll));
                }
              }
            });
        },
        secondButtonOnTap: () {
          Navigator.pop(context);
        }
      );
    } else {
      return AlertScreen(
        title: "Block $name",
        content: "This action will stop all kind of communication with $name.",
        firstButtonName: "Block",
        secondButtonName: "Cancel",
        firstButtonOnTap: () {
          allContacts[index].intoggleblock = true;
          setState(() {});
          Navigator.pop(context);
          
          Map payload = {
            'type': 1,
            'sendermid': userMID,
            'number': allContacts[index].number
          };
          var body = json.encode(payload);
          var rawResponse = http.post(
            Uri.parse("http://$address:8080/toggleblock"),
            body: body
          );
          rawResponse.then((value) {
            if (value.statusCode == 200) {
              String res = String.fromCharCodes(value.bodyBytes);
              var response = json.decode(res);
              if (response["status"] == "successful") {
                setState(() {
                  // allContacts[index].done = false;
                  allContacts[index].blocked = true;
                  allContacts[index].intoggleblock = false;
                });
                Uint8List strAll = internalgbp.Contacts(all: allContacts).writeToBuffer();
                widget.hiveHandler.encryptedTempBox.put("contacts", String.fromCharCodes(strAll));

                String? strBlocked = widget.hiveHandler.encryptedTempBox.get("blocked");
                if (strBlocked != null) {
                  internalgbp.Blocks blocks =  internalgbp.Blocks.fromBuffer(strBlocked.codeUnits);
                  blocks.all.add(allContacts[index].number);
                  widget.hiveHandler.encryptedTempBox.put("blocked", String.fromCharCodes(blocks.writeToBuffer()));
                }
                else {
                  List<String> all = [allContacts[index].number];
                  internalgbp.Blocks blocks =  internalgbp.Blocks(all: all);
                  widget.hiveHandler.encryptedTempBox.put("blocked", String.fromCharCodes(blocks.writeToBuffer()));
                }
              }
            }
          });
        },
        secondButtonOnTap: () {
          Navigator.pop(context);
          // showDialog(
          //   context: context, 
          //   builder: (context) {
          //     var a = Future.delayed(const Duration(seconds: 1));
          //     a.then((value) {
          //       Navigator.pop(context);
          //     });
          //     return const AlertDialog(
          //       alignment: Alignment.bottomCenter,
          //       elevation: 0,
          //       backgroundColor: Colors.transparent,
          //       content: Text(
          //         "This action is canceled!",
          //         style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))
          //       ),
          //     );
          //   }
          // );
        }
      );
    }
  }

  int findIndex(List<internalgbp.Contact> contacts, String number) {
    for (int i = 0; i < contacts.length; i++) {
      if (contacts[i].number == number) {
        return i;
      }
    }
    return -1;
  }

  void getAllContacts() {
    print("Refreshing contact list");
    try {
        var contacts = FlutterContacts.getContacts(withProperties: true);
        contacts.then((value) {
          for (int i = 0; i < value.length; i++) {
            if (value[i].phones.isNotEmpty) {
              var numbers = value[i].phones;
              String resNumber = resolveNumber(numbers[0].number);
              if (resNumber.isNotEmpty) {
                if (!isPresent(allContacts, resNumber)) {
                  internalgbp.Contact _contact = internalgbp.Contact(
                    name: value[i].displayName,
                    number: resNumber,
                    done: false,
                    inProcess: false,
                    blocked: false,
                    intoggleblock: false,
                    inlogin: false,
                  );
                  allContacts.add(_contact);
                }
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

  bool isPresent(List<internalgbp.Contact> contacts, String number) {
    bool found = false;
    contacts.forEach((element) {
      if (element.number == number) {
        found = true;
      }
    });
    return found;
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

}