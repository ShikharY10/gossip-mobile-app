// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import '../../database/hive_handler.dart';
import '../../../utility/gbp/internalProto.pb.dart' as internalgbp;
import '../../../utility/gbp/gbProto.pb.dart' as gbp;
import '../screens/home/home.dart';
import 'askforotp.dart';

List<String> numberList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

// main page of gossip it is the welcome page of gossip.   
class WelcomePage extends StatefulWidget {
  final Stream<int> internetStatus;
  final String path;
  final HiveH hiveHandler;
  const WelcomePage({Key? key, required this.internetStatus, required this.hiveHandler, required this.path}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isCalled = false;
  bool progressBar = false;

  String? address = "192.168.43.58";

// ---------------WILL GET DELETED IN FUTURE---------------
  var addressController = TextEditingController();
  bool addressBtnClicked = false;
// ---------------WILL GET DELETED IN FUTURE---------------

  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void checkInternetStatus() {
    widget.internetStatus.listen((event) {
      print("Internet Connection: $event");
    });
  }

  @override
  initState() {
    super.initState();
    checkInternetStatus();
    address = widget.hiveHandler.tempBox.get("ipaddress");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 29, 77),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 40, right: 20, left: 20),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Center(
                  child: Text("WELCOME TO",
                    
                    style: TextStyle(
                      letterSpacing: 9,
                      color: Color.fromARGB(255, 241, 28, 146),
                      fontSize: 18,
                      // letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                    )),
                ),
              ),
              Center(
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text("GossiP",
                    
                    style: TextStyle(
                      letterSpacing: 12,
                      color: Color.fromARGB(255, 241, 28, 146),
                      fontSize: 45,
                      // letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                    )),
                ),
              ),
              Center(
                child: const Text("To continue using this app,",
                    style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
              ),
              Center(
                child: const Text("please sign in first.",
                    style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
              ),
              // Container(
              //   child: const Image(
              //       image: AssetImage("assets/images/welcomePic.png")),
              //   width: 300,
              //   height: 300,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 135, 212, 182),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          hintText: "IP Address",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                        ),
                      ),
                    ),
                    Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_circle_right, 
                          color: addressBtnClicked ? Colors.red : Colors.blue
                        ),
                        onPressed: () {
                          setState(() {
                            address = addressController.text;
                            addressBtnClicked = true;
                          });
                          print("address: ${addressController.text}");
                          widget.hiveHandler.tempBox.put("ipaddress", addressController.text);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: TextFormField(
                  controller: numberController,
                  style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 135, 212, 182),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: "Phone Number",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  // scrollPadding: EdgeInsets.only(bottom:50),
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                  decoration: InputDecoration(
                    
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility, color: Color.fromARGB(255, 28, 29, 77)),
                      onPressed: () {
                        print("visible clicked");
                      },
                      splashRadius: 20.0,
                      splashColor: Color.fromARGB(255, 224, 222, 216),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 135, 212, 182),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: "Password",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, right: 20, left: 20, bottom: 5),
                child: InkWell(
                  child: Container(
                    width: 300,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 135, 212, 182),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: progressBar ? const CircularProgressIndicator(
                      color: Colors.white
                    ) : Text("Sign In",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 28, 29, 77),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ),
                  onTap: () async {
                    print("Working");
          
                    setState(() {
                      progressBar = true;
                    });
          
                    RSAKeypair keyPair = RSAKeypair.fromRandom(keySize: 2048);
                  
                    final algorithm = Sha256();
                    final hash = await algorithm.hash(passwordController.text.codeUnits);
                    String passwordHash = base64.encode(hash.bytes);
                    
                    Map<String, String> allData = {
                      "number": numberController.text,
                      "password": passwordHash,
                      "publickey": keyPair.publicKey.toFormattedPEM()
                    };
          
                    String body = json.encode(allData);
          
                    Future<http.Response> response = http.post(
                      Uri.parse("http://$address:8080/login"),
                      body: body
                    );
          
                    response.then((value) {
                      if (value.statusCode == 200) {
                        // String jsonRes = String.fromCharCodes(value.bodyBytes);
                        gbp.Response response = gbp.Response.fromBuffer(value.bodyBytes);
                        // var res = json.decode(jsonRes);
                        // print(res);
                        if (response.status) {
                          var data = response.data;
                          print("data: ${data}");
                          internalgbp.LoginResponse logInRes = internalgbp.LoginResponse.fromBuffer(base64.decode(data));
                          User user = User(
                            name: logInRes.myData.name,
                            dob: logInRes.myData.dob,
                            gender: logInRes.myData.gender,
                            mnum: logInRes.myData.number,
                            email: logInRes.myData.email,
                            mid: logInRes.myData.mid,
                            uid: "",
                            profilePic: logInRes.myData.profilePic,
                            mainKey: logInRes.myData.mainKey,
                          );
          
                          widget.hiveHandler.userDataBox.put("userData", user.toJson());
                          widget.hiveHandler.tempBox.put("initState", "1");
          
                          Map<String, int> cContacts = {};
          
                          logInRes.connData.forEach((element) {

                            cContacts[element.number] = 1;
                            Connection conn = Connection(
                              name: element.name,
                              mnum: element.number,
                              uid: "",
                              mid: element.mid,
                              profilepic: element.profilePic,
                              key: "",
                            );
                            if (element.logout) {
                              List<int> akey = Hive.generateSecureKey();
                              String b64AesKey = base64.encode(akey);
                              conn.key = b64AesKey;
                            } else {
                              conn.key = keyPair.privateKey.toFormattedPEM();
                            }
                            widget.hiveHandler.connectionsBox.put(conn.mid, conn.toJson());
                          });
          
                          List<internalgbp.Contact> allContacts = [];
          
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
                                      if (cContacts[resNumber] == 1) {
                                        _contact.inlogin = true;
                                      }
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
          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(
                                internetStatus: widget.internetStatus,
                                hiveHandler: widget.hiveHandler, 
                                path: widget.path
                              )
                            )
                          );
                        }
                      }
                      setState(() {
                        progressBar = false;
                      });
                    });
                  }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have any account?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 133, 133, 135),
                        fontSize: 12,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      splashColor: Color.fromARGB(255, 63, 68, 92),
                      radius: 50,
                      child: Text("SignUp now",
                          style: TextStyle(
                              color: Color.fromARGB(255, 70, 70, 161))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AskOTP(
                                  internetStatus: widget.internetStatus,
                                  hiveHandler: widget.hiveHandler,
                                  path: widget.path,
                                )));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
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


// SvgPicture.asset("images/doughnut.svg")
// color: Color.fromARGB(255, 224, 222, `216),
// color: Color.fromARGB(255, 55, 53, 72),