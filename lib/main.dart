import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:permission_handler/permission_handler.dart';
import 'database/hive_handler.dart';
import 'src/auth/welcome.dart';
import 'src/screens/home/home.dart';
import 'utility/extra/connectivity.dart';
import 'utility/extra/themes.dart';
import 'package:path_provider/path_provider.dart';

void getPermissionAndCreateDir() async {
  bool res = await FlutterContacts.requestPermission();
  PermissionStatus status2 = await Permission.storage.request();
  PermissionStatus status1 =  await Permission.manageExternalStorage.request();
  print("Permissions: $res | ${status1.isGranted} | ${status2.isGranted}");
  if (!res || !status2.isGranted) {
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
  creatFileStructure();
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
  runApp(Phoenix(child: MyApp(path: document.path)));
}

class MyApp extends StatefulWidget {
  final String path;
  const MyApp({Key? key, this.path=""}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CheckInternetConnection internet;

  @override
  void initState() {
    super.initState();
    if (!home) {
      getPermissionAndCreateDir();
    }
    internet = CheckInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      routes: {"/": (context) => home ? HomePage(
          internetStatus: internet.statusStream,
          hiveHandler: hiveHandler,
          path: widget.path
        ) : WelcomePage(
              internetStatus: internet.statusStream,
              hiveHandler: hiveHandler,
              path: widget.path
          )},
    );
  }
}

void creatFileStructure() async {
  Directory? directory = await getExternalStorageDirectory();
  if (directory != null) {
    String basePath = "";
    List<String> paths = directory.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        basePath += "/" + folder;
      } else {
        break;
      }
    }
    basePath = basePath + "/Gossip";
    directory = Directory(basePath);
    Directory chatImageDir = Directory(basePath + "/Gossip_Images");
    Directory chatVideoDir = Directory(basePath + "/Gossip_Videos");

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    if (await directory.exists()) {
      if (!await chatImageDir.exists()) {
        await chatImageDir.create();
      }
      if (!await chatVideoDir.exists()) {
        await chatVideoDir.create();
      }
      hiveHandler.tempBox.put("basepath", basePath);
    }
  }
}