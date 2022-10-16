// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypton/crypton.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:cryptography/cryptography.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import '../../database/hive_handler.dart';
import '../../utility/widget/button.dart';
import '../screens/home/home.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Male"), value: "Male"),
    DropdownMenuItem(child: Text("Female"), value: "Female"),
    DropdownMenuItem(child: Text("Other"), value: "Other"),
  ];
  return menuItems;
}

List<String> Ichar = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
List<String> Uchar = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];
List<String> Lchar = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];
List<String> Schar = [
  "~",
  "!",
  "@",
  "#",
  "%",
  "^",
  "&",
  "*",
  "(",
  ")",
  "_",
  "-",
  "=",
  "+",
  "[",
  "]",
  "{",
  "}",
  "|",
  ":",
  ";",
  "'",
  ",",
  "<",
  ".",
  ">",
  "?"
];

bool checkPassword(String value) {
  int iCharCount = 0;
  int uCharCount = 0;
  int lCharCount = 0;
  int sCharCount = 0;
  for (int i = 0; i < value.length; i++) {
    if (Ichar.contains(value[i])) {
      iCharCount++;
      continue;
    }
    if (Uchar.contains(value[i])) {
      uCharCount++;
      continue;
    }
    if (Lchar.contains(value[i])) {
      lCharCount++;
      continue;
    }
    if (Schar.contains(value[i])) {
      sCharCount++;
      continue;
    }
  }
  if (iCharCount == 2 &&
      uCharCount == 2 &&
      lCharCount == 2 &&
      sCharCount == 2) {
    return true;
  } else {
    return false;
  }
}

class SignUp extends StatefulWidget {
  final Stream<int> internetStatus;
  final HiveH hiveHandler;
  final String path;
  const SignUp(
      {Key? key,
      required this.internetStatus,
      required this.hiveHandler,
      required this.path})
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? selectedValue;

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  String dob = "10/03/2002";
  String? address = "192.168.43.58"; // 192.168.43.58

  bool disableSignUpButton = true;
  bool inProcess = false;
  bool showError = false;

  String profilPicPath = "";
  bool picSelected = false;

  bool passwordError = false;
  bool hidePassword = true;
  String passwordErrorText = "";

  bool repasswordError = false;
  bool hiderepassword = true;
  String repasswordErrorText = "";

  bool _checkbox = false;

  @override
  void initState() {
    super.initState();
    address = widget.hiveHandler.tempBox.get("ipaddress");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 28, 29, 77),
      child: Padding(
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
                    final params = OpenFileDialogParams(
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
                      String bimage = base64.encode(res);
                      widget.hiveHandler.tempBox.put("bimage", bimage);
                      setState(() {
                        picSelected = true;
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: picSelected ? null : Colors.grey,
                    backgroundImage: picSelected
                        ? FileImage(File(profilPicPath))
                        : null, //AssetImage("assets/images/white.jpeg"), /
                    radius: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Please complete your"),
                      const Text("biodata correctly"),
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
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "Full Name",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                controller: emailController,
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
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: DropdownButtonFormField(
                        style:
                            TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                        elevation: 6,
                        decoration: InputDecoration(
                          hintText: "Gender",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 136, 108, 55)),
                          filled: true,
                          fillColor: Color.fromARGB(255, 135, 212, 182),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        validator: (value) => value == null ? "Gender" : null,
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DOBInputField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                      onDateSubmitted: (datetime) {
                        String age = datetime.toString().split(" ")[0];
                        print(age);
                        // Box<String> tempBox = Hive.box<String>("tempdata");
                        widget.hiveHandler.tempBox.put("age", age);
                        // hiveHandler.set("tempData", "age", age);
                        ageController.text = age;
                        dob = age;
                      },
                      onDateSaved: (datetime) {
                        print("done!");
                      },
                      inputDecoration: InputDecoration(
                        suffixIcon: Icon(Icons.date_range,
                            color: Color.fromARGB(255, 28, 29, 77)),
                        counterText: '',
                        hintText: 'DOB',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 136, 108, 55)),
                        filled: true,
                        fillColor: Color.fromARGB(255, 135, 212, 182),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                onChanged: (value) {
                  if (checkPassword(value)) {
                    passwordError = false;
                    disableSignUpButton = false;
                    setState(() {});
                  } else {
                    disableSignUpButton = true;
                    passwordErrorText =
                        "Password does not fulfill the requirement!";
                    passwordError = true;
                    setState(() {});
                  }
                },
                obscureText: hidePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  errorText: passwordError ? passwordErrorText : null,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 12),
                  suffixIcon: IconButton(
                    icon: hidePassword
                        ? Icon(Icons.visibility_off,
                            color: Color.fromARGB(255, 28, 29, 77))
                        : Icon(Icons.visibility,
                            color: Color.fromARGB(255, 28, 29, 77)),
                    onPressed: () {
                      if (hidePassword) {
                        hidePassword = false;
                        setState(() {});
                      } else {
                        hidePassword = true;
                        setState(() {});
                      }
                    },
                    splashRadius: 20.0,
                    splashColor: Color.fromARGB(255, 92, 88, 78),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 135, 212, 182),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "Create Password",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),
                onChanged: (value) {
                  if (value != passwordController.text) {
                    repasswordErrorText = "Password is not matching!";
                    repasswordError = true;
                    setState(() {});
                  } else {
                    repasswordError = false;
                    setState(() {});
                  }
                },
                obscureText: hiderepassword,
                controller: repasswordController,
                decoration: InputDecoration(
                  errorText: repasswordError ? repasswordErrorText : null,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 12),
                  suffixIcon: IconButton(
                    icon: hiderepassword
                        ? Icon(Icons.visibility_off, color: Color(0xFF1C1D4D))
                        : Icon(Icons.visibility,
                            color: Color.fromARGB(255, 28, 29, 77)),
                    onPressed: () {
                      if (hiderepassword) {
                        hiderepassword = false;
                        setState(() {});
                      } else {
                        hiderepassword = true;
                        setState(() {});
                      }
                    },
                    splashRadius: 20.0,
                    splashColor: Color.fromARGB(255, 224, 222, 216),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 135, 212, 182),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "Re-type Password",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 22, right: 22),
              child: Text(
                "Password should contain at least two numbers, uppercase, lowercase and special characters.",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 133, 133, 135),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        if (_checkbox == false) {
                          _checkbox = true;
                        } else {
                          _checkbox = false;
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("I agree to the Terms and Conditions"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 20, left: 20, bottom: 5),
              child: defaultButton(
                context: context,
                disable: disableSignUpButton,
                label: "Sign In",
                progressBar: inProcess,
                validator: (context) async {
                  setState(() {
                    inProcess = true;
                    showError = false;
                  });
                  RSAKeypair keyPair = RSAKeypair.fromRandom(keySize: 2048);

                  // Box<String> tempBox = Hive.box<String>("tempdata");
                  Map<String, String> allData = {};
                  final algorithm = Sha256();
                  final hash =
                      await algorithm.hash(passwordController.text.codeUnits);
                  String passwordHash = base64.encode(hash.bytes);
                  allData["id"] = widget.hiveHandler.tempBox.get("id")!;
                  allData["name"] = nameController.text;
                  allData["age"] = dob;
                  allData["phoneno"] =
                      widget.hiveHandler.tempBox.get("number")!;
                  allData["email"] = emailController.text;
                  allData["profilepic"] =
                      widget.hiveHandler.tempBox.get("bimage")!;
                  allData["gender"] = selectedValue!;
                  allData["password"] = passwordHash;
                  allData["mainkey"] = keyPair.publicKey.toFormattedPEM();

                  // await Navigator.pushNamed(context, MyRoutes.signupStep2Route);
                  var body = json.encode(allData);

                  var response = http.post(
                      Uri.parse("http://$address:8080/api/v1/newuser"),
                      body: body);
                  response.then((value) async {
                    if (value.statusCode == 200) {
                      String res = String.fromCharCodes(value.bodyBytes);
                      if (json.decode(res)['status'] == "successful") {
                        inProcess = false;

                        try {
                          String jsonResponse = json.decode(res)["disc"];
                          var RES = json.decode(String.fromCharCodes(
                              base64.decode(jsonResponse)));
                          String cipherText = RES["Eaeskey"]!;
                          Uint8List aes_key = keyPair.privateKey
                              .decryptData(base64.decode(cipherText));

                          User user = User(
                            name: nameController.text,
                            dob: ageController.text,
                            gender: selectedValue!,
                            mnum: widget.hiveHandler.tempBox.get("number")!,
                            email: emailController.text,
                            mid: RES["mid"]!,
                            uid: RES["uid"]!,
                            profilePic:
                                widget.hiveHandler.tempBox.get("bimage")!,
                            mainKey: String.fromCharCodes(aes_key),
                          );
                          widget.hiveHandler.userDataBox
                              .put("userData", user.toJson());
                          widget.hiveHandler.tempBox.put("initState", "1");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                      internetStatus:
                                          widget.internetStatus,
                                      hiveHandler: widget.hiveHandler,
                                      path: widget.path)));
                        } on Exception catch (e) {
                          inProcess = false;
                          showError = true;
                          setState(() {});
                        }
                      }
                    } else {
                      inProcess = false;
                      showError = true;
                      setState(() {});
                    }
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 133, 135),
                      fontSize: 12,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                    child: Text("SignIn now",
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 161))),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ]
        )
      )
    );
  }
}
