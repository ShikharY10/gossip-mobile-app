// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:vajra/vajra.dart';
import '../../apiCallers/caller.dart';
import '../../apiCallers/routes.dart';
import '../../database/config.dart';
import '../../database/models.dart';
import '../../utility/widget/button.dart';
import '../screens/home/navigation.dart';

class SignUp extends StatefulWidget {
  final String token;
  const SignUp(
      {Key? key,
      required this.token,
      })
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  String? address = "192.168.43.58"; // 192.168.43.58

  String imageExt = "";
  String b64Image = "";
  bool validUsername = false;
  bool isSearching = false;
  bool disableSignUpButton = false;
  bool inProcess = false;

  bool showError = false;
  String errorMsg = "";

  String profilPicPath = "";
  bool picSelected = false;

  bool isUsernameAwailable = false;
  bool usernameFieldActive = false;

  bool isCheckUserNameRequestLive = false;
  late Future<http.Response> checkuserNameResponse;
  late DataBase db;
  late Future<bool> futureResult;
  late Vajra vajraClient;

  @override
  void initState() {
    super.initState();
    db = getDataBase();
    vajraClient = getVajra("auth");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 28, 29, 77),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 40, right: 20, left: 20),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 212, 182),
                          fontSize: 40,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                        )),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await readImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: picSelected ? null : Colors.grey,
                        backgroundImage: picSelected ? FileImage(File(profilPicPath)) : null,
                        radius: 30,
                        child: picSelected? null : Icon(Icons.camera_alt_rounded, color: Colors.black, size: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Please complete your"),
                          const Text("details correctly."),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 135, 212, 182),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    style: TextStyle(color: Color.fromRGBO(28, 29, 77, 1)),
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 135, 212, 182),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                      suffixIcon: usernameFieldActive ? isUsernameAwailable 
                        ? Icon(Icons.check, color: Colors.green, size: 30) : 
                        Icon(Icons.close, color: Colors.red, size: 30)
                      : null
                    ),
                    onChanged: (username) {
                      if (username.length > 3) {
                        if (!usernameFieldActive) {
                          setState(() {
                            usernameFieldActive = true;
                          });
                        }
                        checkUserName(username);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: defaultButton(
                    buttonColor: Color.fromARGB(255, 49, 212, 150),
                    context: context,
                    disable: disableSignUpButton,
                    label: "SignUp",
                    progressBar: inProcess,
                    validator: (context) async {
                      if (validate()) {
                        setState(() {
                          inProcess = true;
                          showError = false;
                        });
                        Map<String, dynamic> response = await signup();
                        if (response["ok"]) {
                          bool result = onSignup(response);
                          if (result) {
                            setState(() {
                              inProcess = false;
                              showError = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Navigation()
                              )
                            );
                          } else {
                            setState(() {
                              inProcess = true;
                              showError = true;
                            });
                          }
                        } else {
                          setState(() {
                            inProcess = false;
                          });
                        }
                      }
                    },
                  ),
                ),
              ]
            )
          ),
          showError ? Positioned(
            top: 30.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width-20,
                decoration: BoxDecoration(
                  color: Color.fromARGB(199, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(errorMsg,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 0)
                          )
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 24,
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          showError = false;
                        });
                      },
                    )
                  ],
                )
              ),
            ),
          ) : const SizedBox()
        ],
      )
    );
  }

  bool validate() {
    if (picSelected && nameController.text.isNotEmpty && usernameController.text.isNotEmpty) {
      if (isUsernameAwailable) {
        return true;
      }
    }
    return false;
  }
 
  void checkUserName(String username) {
    if (isSearching)    {
      futureResult.ignore();
    }
    futureResult = searchUsername(username);
    futureResult.then((value) {
      if (value) {
        setState(() {
          isSearching = false;
          isUsernameAwailable = true;
        });
      } else {
        setState(() {
          isSearching = false;
          isUsernameAwailable = false;
        });
      }
    });
  }

  Future<bool> searchUsername(String username) async {
    // Routes route = Routes();
    // await route.loadPath();
    // http.Response response = await Caller.getCall(
    //   route.isUsernameAwailable(username),
    // );
    // print("statusCode: ${response.statusCode}");
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }

    VajraResponse response = await vajraClient.get(
      "/isusernameawailable", 
      queries: {"username": username},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      setState(() {
        errorMsg = response.errorMessage;
      });
      return false;
    }
  }

  Future<void> readImage() async {
    OpenFileDialogParams params = OpenFileDialogParams(
      dialogType: OpenFileDialogType.image,
      sourceType: SourceType.photoLibrary,
    );
    final String? filePath = await FlutterFileDialog.pickFile(params: params);
    if (filePath != null) {
      var compressed = await FlutterNativeImage.compressImage(
        filePath,
        quality: 60,
        percentage: 60
      );
      profilPicPath = compressed.absolute.path;
      Uint8List res = compressed.readAsBytesSync();
      imageExt = profilPicPath.split(".")[profilPicPath.split(".").length-1];
      b64Image = base64.encode(res);
      // widget.hiveHandler.set("temp","bimage", bimage);
      setState(() {
        picSelected = true;
      });
    }
  }

  Future<Map<String,dynamic>> signup() async {

    VajraResponse response1 = await vajraClient.post(
      "/signup",
      {
        "name": nameController.text,
        "username": usernameController.text,
        "avatarData": b64Image,
        "avatarExt": imageExt
      },
      sendCookie: true,
      expectAuthorization: true
    );

    print("response collected");

    if (response1.statusCode == 201) {
      Map<String, dynamic> responseBody = (response1.body as Map<String, dynamic>);
      responseBody["ok"] = true;
      return responseBody;
    } else {
      setState(() {
        errorMsg = response1.errorMessage;
        showError = true;
      });
      return {"ok": false};
    }


    // Routes routes = Routes();
    // await routes.loadPath();
    // http.Response response = await Caller.postCall(
    //   routes.signup, 
    //   {
    //     "avatar": {
    //       "imagedata": b64Image,
    //       "imageext": imageExt,
    //     },
    //     "fullname": nameController.text,
    //     "username": usernameController.text
    //   },
    //   header: {"Authorization": "Bearer " + widget.token}
    // );
    // if (response.statusCode == 201) {
    //   Map<String, dynamic> responseBody = json.decode(String.fromCharCodes(response.bodyBytes));
    //   responseBody["ok"] = true;
    //   return responseBody;
    // } else {
    //   return {"ok": false};
    // }


  }

  bool onSignup(Map<String,dynamic> response) {
    User user = User();

    user.id = response["_id"];
    user.name = response["name"];
    user.username = response["username"];
    user.email = response["email"];
    user.deliveryId = response["deliveryId"];
    user.role = response["role"];
    user.token = response["accessToken"];
    
    user.partnerRequests = [""];
    user.yourPartnerRequests = [""];
    user.partners = [""];
    user.posts = [""];
    
    db.set("userBox", "mydata", user.toString());
    db.set("tempBox", "userRegistered", "1");
    db.set("tempBox", "token", user.token);

    return true;
  }
}
