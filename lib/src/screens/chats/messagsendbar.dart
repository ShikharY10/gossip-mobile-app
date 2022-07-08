import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:gossip_frontend/main.dart';

import '../../../database/hive_handler.dart';
import '../../../utility/ws/wsutils.dart';

class MessageSendBar extends StatefulWidget {
  StreamController<Chat> chatStreamController;
  final Connection myData;
  final SendPort wsSendPort;
  MessageSendBar({ Key? key, required this.myData, required this.wsSendPort, required this.chatStreamController}) : super(key: key);

  @override
  State<MessageSendBar> createState() => _MessageSendBarState();
}

class _MessageSendBarState extends State<MessageSendBar> {
  var msgController = TextEditingController();

  bool alternate = false;
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
              color: Color.fromARGB(255, 135, 212, 182),
              padding: const EdgeInsets.only(right: 0, left: 1),
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                print("Camera!");
              },
            ),
          ),
          Expanded(
            flex: 18,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 4),
              child: TextFormField(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 208, 209, 212),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: IconButton(
                      color: const Color.fromARGB(255, 43, 60, 135),
                      icon: const Icon(Icons.attachment_outlined),
                      onPressed: () {
                        print("Text Fiels Suffix!");
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 1),
              iconSize: 40,
              splashColor: Color.fromARGB(184, 100, 98, 95),
              icon: const Icon(Icons.send, color: Color.fromARGB(255, 135, 212, 182)),
              onPressed: () async {
                print("Send!");
                String msg = msgController.text;
                msgController.text = "";
                Future<Uint8List> fCipherText = aesEncrypt(msg.codeUnits, SecretKey(base64.decode(widget.myData.key)));
                fCipherText.then((value) {
                  Chat chat = Chat();
                  chat.datetime = DateTime.now().toIso8601String();
                  chat.mloc = "";
                  chat.msg = msg ;
                  chat.sMID = widget.myData.mid;
                  chat.self = true;
                  widget.chatStreamController.sink.add(chat);
                  chat.msg = String.fromCharCodes(value);
                  widget.wsSendPort.send(SendPayload(widget.myData.mid, String.fromCharCodes(value)));
                  String? strGossipData = hiveHandler.gossipsBox.get(widget.myData.mid);
                  Gossips gossip = Gossips();
                  if (strGossipData != null) {                    
                    gossip.toObject(strGossipData);
                    gossip.chats!.add(chat.toString());
                  } else {
                    gossip.chats = [];
                    gossip.chats!.add(chat.toString());
                  }
                  hiveHandler.gossipsBox.put(widget.myData.mid, gossip.toString());
                });
              },
            )
          )

        ]
      )
    );
  }
}
