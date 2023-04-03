import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vajra/vajra.dart';
import '../../../../apiCallers/caller.dart';
import '../../../../apiCallers/routes.dart';
import '../../../../database/config.dart';
import '../../../../database/models.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User myData = User();
  late DataBase db;

  @override
  void initState() {
    super.initState();
    db = getDataBase();
    String? myStrData = db.get("userBox", "mydata");
    if (myStrData != null) {
      myData.toObject(myStrData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 11, 27),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text("Profile",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                )
              ),
            ),
            Material(
              shadowColor: const Color.fromARGB(255, 49, 145, 209),
              elevation: 5.0,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.1,
                      0.9,
                    ],
                    colors: [
                      Color.fromARGB(255, 231, 62, 118),
                      Color.fromARGB(255, 39, 57, 223),
                    ],
                  )
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ShowProfilePicture(myData.id),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              // color: Colors.blue,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myData.name,
                                        // "Shikhar Yadav",
                                        style: const TextStyle(
                                          letterSpacing: 0.8,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900
                                        )
                                      ),
                                      Text(myData.username),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: Column(
                                                children: [
                                                  Text("${myData.partners.length-1}", 
                                                    style: const TextStyle(
                                                      color: Colors.black, 
                                                      fontWeight: FontWeight.bold, 
                                                    )
                                                  ),
                                                  const Text("Partner",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                    )
                                                  )
                                                ]
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(left: 10.0),
                                            //   child: Column(
                                            //     children: [
                                            //       Text("${myData!.following!.length-1}", 
                                            //         style: TextStyle(
                                            //           color: Colors.black, 
                                            //           fontWeight: FontWeight.bold, 
                                            //         )
                                            //       ),
                                            //       Text("Followering",
                                            //         style: TextStyle(
                                            //           fontWeight: FontWeight.w600
                                            //         )
                                            //       )
                                            //     ]
                                            //   ),
                                            // )
                                          ]
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          )
                        ]
                      )
                    ),
                    Positioned(
                      top: 0.1,
                      right: 0.1,
                      child: Material(
                        type: MaterialType.transparency,
                        borderOnForeground: false,
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        child: IconButton(
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          splashColor: Colors.pink,
                          color: Colors.white,
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      )
                    )
                  ],
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                height: 4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white
                ),
              ),
            ),
            for (int i = 0; i < 5; i++)
              Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/1.2,
                constraints: BoxConstraints(
                  maxHeight: (MediaQuery.of(context).size.width/1.2)/2-10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        ),
                      )
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        ),
                      )
                    ),
                  ],
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class ShowProfilePicture extends StatefulWidget {
  final String id;
  const ShowProfilePicture(this.id, {Key? key}) : super(key: key);

  @override
  State<ShowProfilePicture> createState() => _ShowProfilePictureState();
}

class _ShowProfilePictureState extends State<ShowProfilePicture> {

  late DataBase db;
  late Vajra vajraClient;

  bool isImageLoaded = false;
  bool fetchingImage = false;

  Uint8List? imageData;

  loadImageFromServer() async {
    setState(() {
      fetchingImage = true;
    });

    try {
      VajraResponse response = await vajraClient.get(
        "/getuseravatar/${widget.id}",
        secured: true,
        sendCookie: true,
        queries: {
          "width": "200",
          "height": "200",
          "scale": "0.70"
        },
      );

      setState(() {
        fetchingImage = false;
      });
      
      print("statusCode: ${response.statusCode}");
      print("errorMsg: ${response.errorMessage}");

      if (response.statusCode == 200) {
        db.set("imageBox", "user.profilepic.${widget.id}", String.fromCharCodes(response.body));
        imageData = response.body;
        setState(() {
          isImageLoaded = true;
        });
      } else if (response.statusCode == 401) {
        if ((response.body as Map<String, String>)["reason"] == "access-token-expire") {
          // Step1: refresh the access token
          // Step2: Call loadImageFromServer again
        }
      }
    } catch (e) {
      setState(() {
        isImageLoaded = false;
      });
    }

    // try {
    //   Future<http.Response> futureResponse = Caller.getCall(routes.getavatar("${widget.id}?width=200&height=200&scale=0.70"));
    //   futureResponse.then((response) {
    //     if (response.statusCode == 200) {
    //       db.set("imageBox", "user.profilepic.${widget.id}", String.fromCharCodes(response.bodyBytes));
    //       imageData = response.bodyBytes;
    //       setState(() {
    //         isImageLoaded = true;
    //       });
    //     }
    //   });
    // } catch (e) {
    //   setState(() {
    //     isImageLoaded = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    db = getDataBase();
    vajraClient = getVajra("client");

    String key = "user.profilepic.${widget.id}";
    String? savedImageData = db.get("imageBox",key);
    if (savedImageData != null) {
      imageData = Uint8List.fromList(savedImageData.codeUnits);
      isImageLoaded = true;
    } else {
      loadImageFromServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: isImageLoaded ? null : Colors.grey,
        backgroundImage: (imageData != null) ? MemoryImage(imageData!) : null,
        minRadius: 30,
        maxRadius: 40,
        child: Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          child: fetchingImage ? const CircularProgressIndicator(): null
        ),
      ),
    );
  }
}