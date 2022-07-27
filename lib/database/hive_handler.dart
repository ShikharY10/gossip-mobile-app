import 'dart:io';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Box<String> userBox = Hive.box<String>("UserDetails");

// uData Box
// Init - string ("1" or "0")
// Name - string
// DOB  - string
// Gender - String
// Number - String
// Email - String
// Mid - string
// Uid - String
// profile_pic - base64-encoded-String
// connections - map<mid - string><number - string>

class HiveH {
  late Box<String> userDataBox;
  late Box<String> connectionsBox;
  late Box<String> encryptedTempBox;
  late Box<String> gossipsBox;
  late Box<String> recentGossipsBox;
  late Box<String> tempBox;

  Future<bool> init(String path) async {
    tempBox = await Hive.openBox<String>("tempData");
    String? res = tempBox.get("initState");
    if (res == null) {

      FlutterSecureStorage secureStorage = const FlutterSecureStorage();

      var uDatakey = Hive.generateSecureKey();
      var connectionkey = Hive.generateSecureKey();
      var encryptedTempKey = Hive.generateSecureKey();

      await secureStorage.write(
          key: 'uDataKey', value: base64UrlEncode(uDatakey));
      await secureStorage.write(
          key: 'connectionKey', value: base64UrlEncode(connectionkey));
      await secureStorage.write(
          key: "encryptedTempKey", value: base64UrlEncode(encryptedTempKey));

      String? uDataKey = await secureStorage.read(key: "uDataKey");
      userDataBox = await Hive.openBox<String>("uData",
          encryptionCipher: HiveAesCipher(base64.decode(uDataKey!)));

      String? connectionKey = await secureStorage.read(key: "connectionKey");
      connectionsBox = await Hive.openBox<String>("connections",
          encryptionCipher: HiveAesCipher(base64.decode(connectionKey!)));

      String? encryptedtempkey = await secureStorage.read(key: "encryptedTempKey");
      encryptedTempBox = await Hive.openBox<String>("EncryptedTemp",
          encryptionCipher: HiveAesCipher(base64.decode(encryptedtempkey!)));

      gossipsBox = await Hive.openBox<String>("gossips");
      recentGossipsBox = await Hive.openBox<String>("recentgossips");
      return false;
    } else {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      String? uDataKey = await secureStorage.read(key: "uDataKey");
      userDataBox = await Hive.openBox<String>("uData",
          encryptionCipher: HiveAesCipher(base64.decode(uDataKey!)));

      String? connectionKey = await secureStorage.read(key: "connectionKey");
      connectionsBox = await Hive.openBox<String>("connections",
          encryptionCipher: HiveAesCipher(base64.decode(connectionKey!)));

      String? encryptedtempkey = await secureStorage.read(key: "encryptedTempKey");
      encryptedTempBox = await Hive.openBox<String>("EncryptedTemp",
          encryptionCipher: HiveAesCipher(base64.decode(encryptedtempkey!)));

      gossipsBox = await Hive.openBox<String>("gossips");
      recentGossipsBox = await Hive.openBox<String>("recentgossips");
      return true;
    }
  }

  Future<bool> flutterInit(String path) async {
    await Hive.initFlutter(path);
    return await init(path);
  }

  Future<bool> dartInit(String path) async {
    Hive.init(path);
    return await init(path);
  }

  void set(String boxName, String key, String value) {
    Box<dynamic> userBox = Hive.box<dynamic>(boxName);;
    userBox.put(key, value);
  }

  String? get(String boxName, String key) {
    Box<dynamic> userBox = Hive.box<dynamic>(boxName);
    String? res = userBox.get(key);
    return res;
  }

  User getUserData() {
    Box<String> userBox = Hive.box<String>("uData");
    String? res = userBox.get("user");
    User response = User();
    response.toObject(res!);
    return response;
  }

  setUserData(User user) {
    Box<String> userBox = Hive.box<String>("uData");
    String res = user.toJson();
    userBox.put("user", res);
  }
}

void addUser({required String boxName, required String key, required data}) {
  Box<String> userBox = Hive.box<String>(boxName);
  String jsonData = jsonEncode(data);
  userBox.put(key, jsonData);
  userBox.close();
}

void deleteUser({required String boxName, required String key}) {
  Box<String> userBox = Hive.box<String>(boxName);
  userBox.delete(key);
}

void updateUser({required String boxName, required String key, required data}) {
  Box<String> userBox = Hive.box<String>(boxName);
  String jsonData = jsonEncode(data);
  userBox.put(key, jsonData);
}

Map<String, dynamic> readUser({required String boxName, required key}) {
  Box<String> userBox = Hive.box<String>(boxName);
  String? data = userBox.get(key);
  Map<String, dynamic> value = jsonDecode(data!);
  return value;
}

dynamic readAllUser({required String boxName, bool withKey = false}) {
  Box<String> userBox = Hive.box<String>(boxName);
  final keys = userBox.keys.toList();
  if (withKey) {
    List<Map<String, dynamic>> userList = [];
    for (int i = 0; i < keys.length; i++) {
      userList.add({"${keys[i]}": jsonDecode(userBox.get(keys[i])!)});
    }
    return userList;
  } else {
    List<dynamic> userList = [];
    for (int i = 0; i < keys.length; i++) {
      userList.add(jsonDecode(userBox.get(keys[i])!));
    }
    return userList;
  }
}

class User {
  User(
      {
        this.name = "",
        this.dob = "",
        this.gender = "", 
        this.mnum = "", 
        this.email = "", 
        this.mid = "",
        this.uid = "", 
        this.profilePic = "",
        this.mainKey = "",
        });

  String name;
  String dob;
  String gender;
  String mnum;
  String email;
  String mid;
  String uid;
  String profilePic;
  String mainKey;
  Map<String, String> connections = {};

  toObject(String data) {
    var mapData = json.decode(data);
    name = mapData["name"];
    dob = mapData["dob"];
    gender = mapData["gender"];
    mnum = mapData["mnum"];
    mid = mapData["mid"];
    uid = mapData["uid"];
    email = mapData["email"];
    profilePic = mapData["profilepic"];
    mainKey = mapData["mainkey"];
  }

  String toJson() {
    Map<String, String> data = <String, String>{};
    data["name"] = name;
    data["dob"] = dob;
    data["gender"] = gender;
    data["mnum"] = mnum;
    data["email"] = email;
    data["mid"] = mid;
    data["uid"] = uid;
    data["profilepic"] = profilePic;
    data["mainkey"] = mainKey;
    String jsonData = json.encode(data);
    return jsonData;
  }
}

class Connection {
  String name;
  String mnum;
  String uid;
  String mid;
  String profilepic;
  String key;
  String done;

  Connection(
      {this.name  = "",
      this.mnum = "", 
      this.uid = "", 
      this.mid = "", 
      this.key = "",
      this.profilepic = "",
      this.done = "", 
      });

  void toObject(String data) {
    var mapData = json.decode(data);
    name = mapData["name"];
    mnum = mapData["mnum"];
    uid = mapData["uid"];
    mid = mapData["mid"];
    key = mapData["key"];
    profilepic = mapData["profilepic"];
    done = mapData["done"];
  }

  String toJson() {
    Map<String, String> data = <String, String>{};
    data["name"] = name;
    data["mnum"] = mnum;
    data["uid"] = uid;
    data["mid"] = mid;
    data["key"] = key;
    data["profilepic"] = profilepic;
    data["done"] = done;
    String jsonData = json.encode(data);
    return jsonData;
  }
}


class Chat {
  String sMID;
  bool self;
  String datetime;
  String msg;
  String mloc;
  Chat({this.sMID = "", this.self = false, this.datetime = "", this.msg = "", this.mloc = ""});

  @override
  String toString() {
    Map<String, String> mapData = <String, String>{
      "smid": sMID,
      "self": self.toString(),
      "datetime": datetime,
      "msg": msg,
      "mloc": mloc,
    };
    return base64.encode(json.encode(mapData).codeUnits);
  }

  void toObject(String data) {
    Uint8List bdata = base64.decode(data);
    var mapData = json.decode(String.fromCharCodes(bdata));
    sMID = mapData["smid"]!;
    self = (mapData["self"] == "true") ? true : false;
    datetime = mapData["datetime"]!;
    msg = mapData["msg"]!;
    mloc = mapData["mloc"]!;
  }
}

class Gossips {
  List<String>? chats = [];
  Gossips({List<String>? chats}) {
    if (chats == null) {
      this.chats = [];
    } else {
      chats = chats;
    }
  }

  @override
  String toString() {
    Map<String, List<String>> mapData = <String, List<String>>{
      "chats": chats!,
    };
    return json.encode(mapData);
  }

  void toObject(String data) {
    Map<String, dynamic> mapData = json.decode(data);
    List<dynamic> temp = mapData["chats"];
    for (int i = 0; i < temp.length; i++) {
      chats!.add(temp[i]);
    }
  }
  // Map<String, String>
  // tmid
  // smid
  // self - string ("1" or "0")
  // msg - string (encrypted message)
  // mloc - string
}

// class RecentGossips {
//   String name;
//   String lastMsg;
//   String senderMID;
//   String dateTime;
//   int unSeenMsgCount;
//   String profilePic;
//   RecentGossips(
//     {this.name = "", this.lastMsg = "", this.senderMID = "", this.dateTime = "", this.unSeenMsgCount = 0, this.profilePic = ""});

//   @override
//   String toString() {
//     Map<String, String> mapData = <String, String>{
//       "name": name,
//       "lastmsg": lastMsg,
//       "sendermid": senderMID,
//       "datetime": dateTime,
//       "usmc": unSeenMsgCount.toString(),
//       "prifilepic": profilePic,
//     };
//    return json.encode(mapData);
//   }

//   void toObject(String data) {
//     Map<String,String> mapData = json.decode(data);
//     name = mapData["name"]!;
//     lastMsg = mapData["lastmsg"]!;
//     senderMID = mapData["sendermid"]!;
//     dateTime = mapData["datetime"]!;
//     unSeenMsgCount = int.parse(mapData["usmc"]!);
//     profilePic = mapData["prifilepic"]!;
//   }
// }




void writeToJson(String path) {
  File file = File(path + "/default.json");
  Map<String, String> mapData = {};
  mapData["status"] = "success";
  String jsonData = json.encode(mapData);
  file.writeAsStringSync(jsonData);
}

void createJsonFile(String path) {
  File file = File(path + "/default.json");
  Map<String, String> mapData = {};
  mapData["status"] = "under-process";
  String jsonData = json.encode(mapData);
  file.writeAsStringSync(jsonData);
}

String readFromJson(String path) {
  try {
    File file = File(path + "/default.json");
    String res = file.readAsStringSync();
    var data = json.decode(res);
    return data["status"];
  } catch (dynamic) {
    createJsonFile(path);
    return "under-process";
  }
}

void checkTime() {
  DateTime tnow = DateTime.now();
  String t = tnow.toIso8601String();
  sleep(const Duration(seconds: 1));
  DateTime tn = DateTime.parse(t);
}
