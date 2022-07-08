// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import '../../database/hive_handler.dart';
import '../../utility/widget/button.dart';
import 'askforotp.dart';

// main page of gossip it is the welcome page of gossip.   
class WelcomePage extends StatefulWidget {
  final StreamController<bool> allChatEvent;
  final StreamController<bool> welcomeStatus;
  final StreamController<bool> askOtpEvent;
  final StreamController<bool> signUpEvent;
  final String path;
  HiveH hiveHandler;
  WelcomePage({Key? key, required this.allChatEvent, required this.welcomeStatus, required this.askOtpEvent, required this.signUpEvent, required this.hiveHandler, required this.path}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isCalled = false;

// ---------------WILL GET DELETED IN FUTURE---------------
  var addressController = TextEditingController();
  bool addressBtnClicked = false;
// ---------------WILL GET DELETED IN FUTURE---------------


  void checkInternetStatus() {
    widget.welcomeStatus.stream.listen((event) {
      print("Internet Connection: $event");
    });
  }

  @override
  initState() {
    super.initState();
    checkInternetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 28, 29, 77),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 40, right: 20, left: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text("Welcome!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 28, 146),
                      fontSize: 40,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              const Text("To continue using this app,",
                  style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
              const Text("please sign in first.",
                  style: TextStyle(color: Color.fromARGB(255, 135, 212, 182))),
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 135, 212, 182),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: "Email or Phone",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
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
                child: defaultButton(
                  label: "Sign In",
                  context: context,
                  validator: (BuildContext context) {
                    // await Navigator.pushNamed(context, MyRoutes.signupStep2Route);
                    print("Login Clicked");
                  },
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
                                  askOtpEvent: widget.askOtpEvent,
                                  allChatEvent: widget.allChatEvent,
                                  signUpEvent:widget.signUpEvent,
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
}


// SvgPicture.asset("images/doughnut.svg")
// color: Color.fromARGB(255, 224, 222, `216),
// color: Color.fromARGB(255, 55, 53, 72),