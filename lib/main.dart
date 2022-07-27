import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'database/hive_handler.dart';
import 'src/auth/welcome.dart';
import 'src/screens/home/home.dart';
import 'utility/extra/connectivity.dart';
import 'utility/extra/themes.dart';
import 'package:path_provider/path_provider.dart';

void getContact() async {
  bool res = await FlutterContacts.requestPermission();
  if (!res) {
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
}

HiveH hiveHandler = HiveH();

bool home = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  bool res = await hiveHandler.flutterInit(document.path);
  if (res) {
    home = true;
  } else {
    home = false;
  }
  hiveHandler.tempBox.put("working", "1");
  runApp(Phoenix(child: MyApp(path: document.path)));
}

class MyApp extends StatefulWidget {
  String path;
  MyApp({Key? key, this.path=""}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<dynamic, bool> conStatus = {};

  final MyConnectivity _connectivity = MyConnectivity.instance;
  final StreamController<bool> allChatController = StreamController<bool>();
  final StreamController<bool> welcomeController = StreamController<bool>();
  final StreamController<bool> askOtpController = StreamController<bool>();
  final StreamController<bool> signUpController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    getContact();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() {
        allChatController.sink.add(source);
        welcomeController.sink.add(source);
        askOtpController.sink.add(source);
        signUpController.sink.add(source);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      routes: {"/": (context) => home ? HomePage(
          allConnectionStatus: allChatController,
          hiveHandler: hiveHandler,
          path: widget.path
        ) : WelcomePage(
              allChatEvent: allChatController,
              welcomeStatus: welcomeController,
              askOtpEvent: askOtpController,
              signUpEvent: signUpController,
              hiveHandler: hiveHandler,
              path: widget.path
          )},
    );
  }
}
