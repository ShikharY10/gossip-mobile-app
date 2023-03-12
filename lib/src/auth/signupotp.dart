// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:gossip_frontend/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import '../../apiCallers/caller.dart';
import '../../apiCallers/routes.dart';
import '../../database/config.dart';
import '../../utility/utils.dart';
import 'login.dart';
import 'signup.dart';

// main page of gossip it is the welcome page of gossip.   
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late DataBase db;
  late Routes routes;

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool progressBar = false;
  bool isGetOtpButtonPressed = false;
  bool isReady = false;
  String buttonLabel = "Get OTP";
  String authToken = "";
  bool showError = false;

  loadConfiguration() {
    Future<Routes> futureRoutes = getDynamicRoutes();
    futureRoutes.then((route) {
      routes = route;
      if (route.isDefault) {
        setState(() {
          isReady = true;
          showError = true;
        });
      } else {
        setState(() {
          isReady = true;
          showError = false;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    db = getDataBase();

    loadConfiguration();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(28, 29, 77, 1),
        body: Stack(
          children: [
            Padding(
              padding:const EdgeInsets.only(top: 60, bottom: 40, right: 20, left: 20),
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
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 147, 128, 255),
                            ),
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(124, 255, 0, 234),
                            ),
                          ],
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
                    child: const Text("please signup now.",
                        style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
                  ),
                  SizedBox(
                    child: const Image(
                        image: AssetImage("assets/images/welcomePic.png")),
                    width: 300,
                    height: 200,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      enabled: isGetOtpButtonPressed ? false : true,
                      controller: emailController,
                      style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 135, 212, 182),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                      ),
                    ),
                  ),
                  isGetOtpButtonPressed ? Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: otpController,
                      style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 135, 212, 182),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                        hintText: "OTP",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                      ),
                    ),
                  ) : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 5),
                    child: InkWell(
                      child: Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 49, 212, 150),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: progressBar ? const CircularProgressIndicator(
                          color: Colors.white
                        ) : Text(buttonLabel,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 28, 29, 77),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                        )
                      ),
                      onTap: () async {
                          await onTap();
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
                                decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 255, 179, 179))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(
                                  // internetStatus: widget.internetStatus,
                                  // hiveHandler: widget.hiveHandler,
                                  // path: widget.path,
                                )
                              )
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            isReady ? SizedBox(width: 0, height: 0) : Container(
              alignment: Alignment.center,
              color: Color.fromARGB(101, 80, 105, 189),
              child: CircularProgressIndicator(),
            ),
            showError ? Positioned(
              bottom: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(101, 80, 105, 189),
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                      Text("Error while fetching configurations."),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text("Retry",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                            ),
                          ),
                        ),
                        onTap: () {
                          loadConfiguration();
                        },
                      ),
                      IconButton(
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
        ));
  }

  bool isValidEmail(String email) {
    if (email.contains("@") && email.contains(".") && (email.indexOf("@")-email.indexOf(".")).abs() > 1) {
      return true; 
    } else {
      return false;
    }
  }

  Future<void> onTap() async {
    if (!isGetOtpButtonPressed && isValidEmail(emailController.text)) {
      setState(() {
        progressBar = true;
      });
      Map<String, dynamic> result = await getOTP(emailController.text);
      if (result["ok"]) {
        setState(() {
          authToken = result["token"];
          progressBar = false;
          isGetOtpButtonPressed = true;
          buttonLabel = "Varify OTP";
        });
      } else {
        setState(() {
          progressBar = false;
        });
      }
    } else if (isGetOtpButtonPressed && otpController.text.length == 6) {
      setState(() {
        progressBar = true;
      });
      bool result = await varifyOTP(otpController.text);
      if (result) {
        setState(() {
          progressBar = false;
          isGetOtpButtonPressed = false;
          buttonLabel = "Get OTP";
          emailController.clear();
          otpController.clear();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignUp(token: authToken)
          )
        );
      } else {
        setState(() {
          progressBar = false;
          showError = true;
        });
      }
    }           
  }

  Future<Map<String, dynamic>> getOTP(String email) async {    
    Routes routes = Routes();
    await routes.loadPath();
    print("Path: " + routes.requestSignupOTP);
    http.Response response = await Caller.postCall(routes.requestSignupOTP, {"email": email});
    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = json.decode(String.fromCharCodes(response.bodyBytes));
      String token = responseBody["token"];
      return {"token": token, "ok": true};
    } else {
      return {"ok": false};
    }
  }

  Future<bool> varifyOTP(String otp) async {
    Routes routes = Routes();
    await routes.loadPath();
    http.Response response = await Caller.postCall(routes.varifySignupOTP, {"otp": otp}, header: {"Authorization": "Bearer " + authToken});
    print(json.decode(String.fromCharCodes(response.bodyBytes)));
    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
    }
  }

  void getDynamicRoutesT() async {
    try {
      String path = "https://raw.githubusercontent.com/ShikharY10/gossip/master/config/routes.yaml";
      http.Response response = await http.get(
        Uri.parse(path)
      );
      if (response.statusCode == 200) {
        String fileContent = String.fromCharCodes(response.bodyBytes);
        Map yaml = loadYaml(fileContent);
        setState(() {
          isReady = true;
          showError = false;
        });
        String jsonData = json.encode(yaml);
        db.set("tempBox", "domain", jsonData);
      } else {
        setState(() {
          isReady = true;
          showError = true;
        });
      }
    } catch (e) {
      setState(() {
        isReady = true;
        showError = true;
      });
    }
  }
}


// SvgPicture.asset("images/doughnut.svg")
// color: Color.fromARGB(255, 224, 222, `216),
// color: Color.fromARGB(255, 55, 53, 72),


