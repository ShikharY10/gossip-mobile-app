import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:gossip_frontend/database/models.dart';
import 'package:vajra/vajra.dart';
import '../../../../database/config.dart';

class ShowUserDetails extends StatefulWidget {
  final Map<String ,dynamic> data;
  const ShowUserDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ShowUserDetails> createState() => _ShowUserDetailsState();
}

class _ShowUserDetailsState extends State<ShowUserDetails> {

  bool isRequestedSending = false;
  bool isRequestAlreadySent = false;
  User myData = User();

  late DataBase db;

  @override
  void initState() {
    super.initState();
    db = getDataBase();

    String? mySavedData = db.get("userBox", "mydata");
    if (mySavedData != null) {
      myData.toObject(mySavedData);
    } else {
      return;
    }

    if (myData.yourPartnerRequests.contains("parterrequested.${widget.data["id"]}")) {
      isRequestAlreadySent = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      elevation: 3,
      backgroundColor: const Color.fromARGB(255, 29, 30, 49),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        // width: 200,
        height: 150,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image(
                        image: NetworkImage(widget.data["avatar"]),
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                      )
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data["name"] ?? "unknown",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      )
                    ),
                    Text(widget.data["username"] ?? "unknown",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 68, 171, 255),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Text("${widget.data["postCount"]}"),
                                const Text("Posts",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Text("${widget.data["partnerCount"]}"),
                                const Text("Partners",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: InkWell(
                        
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 150
                          ),
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 69, 86, 245),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: isRequestedSending 
                            ? Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            )
                            : Text(isRequestAlreadySent ? "Already Sent" : "Partner",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                          )
                        ),
                        onTap: () async {
                          if (!isRequestAlreadySent) {

                            setState(() {isRequestedSending = true;});

                            Future.delayed(const Duration(seconds: 1), () async {
                              String? token = db.get("tempBox", "token");

                              RSAKeypair keyPair = RSAKeypair.fromRandom();

                              PartnerRequest partnerRequest = PartnerRequest();
                              partnerRequest.createdAt = DateTime.now().toIso8601String();
                              partnerRequest.id = base64.encode(DateTime.now().microsecondsSinceEpoch.toString().codeUnits);
                              partnerRequest.publicKey = base64.encode(keyPair.publicKey.toFormattedPEM().codeUnits);
                              partnerRequest.requesterId = myData.id;
                              partnerRequest.requesterName = myData.name;
                              partnerRequest.requesterUsername = myData.username;
                              partnerRequest.targetId = widget.data["id"];
                              partnerRequest.targetName = widget.data["name"];
                              partnerRequest.targetUsername = widget.data["username"];

                              Vajra vajraClient = getVajra("client");
                              VajraResponse response = await vajraClient.post(
                                "partnerrequest",
                                partnerRequest.toMap(),
                                secured: true,
                                sendCookie: true
                              );

                              if (response.statusCode == 200) {
                                String key = "parterrequested." + partnerRequest.targetId;
                                myData.yourPartnerRequests.add(key);
                                
                                db.set("userBox", "myData", myData.toString());
                                db.set("userBox", key, partnerRequest.toString());
                                db.set("tempBox", "privatekey.${partnerRequest.id}", base64.encode(keyPair.privateKey.toFormattedPEM().codeUnits));

                                setState(() {
                                  isRequestedSending = false;
                                  isRequestAlreadySent = true;
                                });
                              } else {
                                setState(() {
                                  isRequestedSending = false;
                                });
                              }
                            });
                          }
                        },
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
