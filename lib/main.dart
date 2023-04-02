import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vajra/scheme/security_scheme.dart';
import 'database/config.dart';
import 'src/auth/signupotp.dart';
import 'src/screens/home/navigation.dart';
import 'utility/extra/themes.dart';
import 'package:path_provider/path_provider.dart';
import 'utility/network/internet.dart';
import 'package:vajra/vajra.dart';

bool isUserRegistered = false;

void creatFileStructure(DataBase db) async {
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
      db.set("tempBox","basepath", basePath);
    }
  }
}

void getPermissionAndCreateDir(DataBase db) async {
  PermissionStatus status2 = await Permission.storage.request();
  // PermissionStatus status1 =  await Permission.manageExternalStorage.request();
  if (!status2.isGranted) {
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
  creatFileStructure(db);
}

class MyApp extends StatefulWidget {
  final DataBase db;
  const MyApp(this.db, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<Connectivity>(connectivity, instanceName: "connectivity");
    if (!isUserRegistered) {
      getPermissionAndCreateDir(widget.db);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      routes: {"/": (context) => isUserRegistered ? const Navigation() : const WelcomePage()},
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  GetIt.I.registerSingleton<Directory>(directory, instanceName: "directory");
  
  DataBase db = DataBase();
  isUserRegistered = await db.flutterInit(directory.path);

  GetIt.I.registerSingleton<DataBase>(db, instanceName: "db");

  // Initializing Vajra class
  Vajra authClient = Vajra("auth", directory.path, basePath: "http://10.0.2.2:10220/api/v1");
  await authClient.initialize();
  authClient.setDefaultAuthorization(SecurityScheme.bearer, "body", "token");

  Vajra client = Vajra("client", directory.path, basePath: "http://10.0.2.2:10221/api/v1");
  await client.initialize();
  client.setDefaultAuthorization(SecurityScheme.bearer, "body", "token");

  runApp(Phoenix(child: MyApp(db)));
}