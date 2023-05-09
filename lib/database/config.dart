import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

// class DataBaseT {
//   late Box<String> _userAndFriendBox;
//   late Box<String> _eTempBox;
//   late Box<String> _gossipsBox;
//   late Box<String> _recentGossipBox;
//   late Box<String> _tempBox;

//   bool _isInitalized = false;

//   Future<bool> _init(String path) async {
//     _tempBox = await Hive.openBox<String>("temp");
//     String? res = _tempBox.get("initState");
//     if (res == null) {

//       FlutterSecureStorage secureStorage = const FlutterSecureStorage();
//       {
//         // Creating AES Keys for encrypted hive box
//         List<int> userAndFriendBoxKey = Hive.generateSecureKey();
//         List<int> eTempBox = Hive.generateSecureKey();

//         // Saving AES Keys for future use
//         await secureStorage.write(
//           key: 'userAndFriendBoxKey', 
//           value: base64UrlEncode(userAndFriendBoxKey)
//         );
//         await secureStorage.write(
//           key: "eTempBoxKey", 
//           value: base64UrlEncode(eTempBox)
//         );
//       }
      

//       // Opening encrypted boxes for the first time.

//       // Opening box that contains user and friends data.
//       String? userAndFriendBoxKey = await secureStorage.read(key: "userAndFriendBoxKey");
//       _userAndFriendBox = await Hive.openBox<String>(
//         "userAndFriendBox",
//         encryptionCipher: HiveAesCipher(base64.decode(userAndFriendBoxKey!))
//       );

//       // Opening box that contains temperory data in encrypted form.
//       String? eTempBoxKey = await secureStorage.read(key: "eTempBoxKey");
//       _eTempBox = await Hive.openBox<String>("etemp",
//           encryptionCipher: HiveAesCipher(base64.decode(eTempBoxKey!)));

//       _gossipsBox = await Hive.openBox<String>("gossips");
//       _recentGossipBox = await Hive.openBox<String>("recentgossips");
//       return false;
//     } else {
//       FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//       String? userAndFriendBoxKey = await secureStorage.read(key: "userAndFriendBoxKey");
//       _userAndFriendBox = await Hive.openBox<String>(
//         "userAndFriendBox",
//         encryptionCipher: HiveAesCipher(base64.decode(userAndFriendBoxKey!))
//       );

//       String? eTempBoxKey = await secureStorage.read(key: "eTempBoxKey");
//       _eTempBox = await Hive.openBox<String>(
//         "etemp",
//         encryptionCipher: HiveAesCipher(base64.decode(eTempBoxKey!))
//       );

//       _gossipsBox = await Hive.openBox<String>("gossips");
//       _recentGossipBox = await Hive.openBox<String>("recentgossip");
//       return true;
//     }
    
//   }

//   Future<bool> flutterInit(String path) async {
//     await Hive.initFlutter(path);
//     _isInitalized = true;
//     return await _init(path);
//   }

//   Future<bool> dartInit(String path) async {
//     Hive.init(path);
//     _isInitalized = true;
//     return await _init(path);
//   }

//   void set(String boxName, String key, dynamic value) {
//     if (!_isInitalized) {
//       throw Exception("Hive handler is not yet initialiazed.");
//     }
//     String jsonData = value.toString();
//     if (boxName == "userAndFriendBox") {
//       _userAndFriendBox.put(key, jsonData);
//     } else if (boxName == "gossips") {
//       _gossipsBox.put(key, jsonData);
//     } else if (boxName == "recentGossip") {
//       _recentGossipBox.put(key, jsonData);
//     } else if (boxName == "eTemp") {
//       _eTempBox.put(key, jsonData);
//     } else if (boxName == "temp") {
//       _tempBox.put(key, jsonData);
//     }
//   }

//   void printAll() {
//     print("Keys:");
//     print(_userAndFriendBox.keys.toList());
//     print("Values: ");
//     print(_userAndFriendBox.values.toList());
//   }

//   dynamic get(String boxName, String key) {
//     if (!_isInitalized) {
//       throw Exception("Gossip Hive wrapper is not yet initialiazed.");
//     }
//     if (boxName == "userAndFriendBox") {
//       String? res = _userAndFriendBox.get(key);
//       if (res != null) {
//         if (key == "mydata") {
//           User user = User();
//           user.toObject(res);
//           return user;
//         } else {
//           Partner friend = Partner();
//           friend.toObject(res);
//           return friend;
//         }
//       }
//     } else if (boxName == "gossips") {
//       String? res = _gossipsBox.get(key);
//       if (res != null) {
//         Gossips gossips = Gossips();
//         gossips.toObject(res);
//         return gossips;
//       }
//     } else if (boxName == "recentGossip") {
//         String? res = _recentGossipBox.get(key);
//         if (res != null) {
//           RecentGossips recentGossips = RecentGossips();
//           recentGossips.toObject(res);
//           return recentGossips;
//         }
//     } else if (boxName == "eTemp") {
//         String? res = _eTempBox.get(key);
//         if (res != null) {
//           return res;
//         }
//     } else if (boxName == "temp") {
//       String? res = _tempBox.get(key);
//       if (res != null) {
//         return res;
//       }
//     }
//     return null;
//   } 

//   Future<void> deleteUserData() async {
//     await _userAndFriendBox.delete("mydata");
//     await _tempBox.delete("initState");
//   }
// }

DataBase getDataBase() {
  return GetIt.I.get<DataBase>(instanceName: "db");
}

class DataBase {
  late Box<String> userBox;
  late Box<String> postBox;
  late Box<String> chatBox;
  late Box<String> tempBox;
  late Box<String> imageBox;

  Future<bool> _isInitialized() async {
    tempBox = await Hive.openBox<String>("tempBox");
    String? res = tempBox.get("userRegistered");
    if (res != null) {
      return true;
    }
    return false;
  }

  Future<bool> _init() async {
    bool result = await _isInitialized();
    userBox = await Hive.openBox<String>("userBox");
    postBox = await Hive.openBox<String>("postBox");
    chatBox = await Hive.openBox<String>("chatBox");
    imageBox = await Hive.openBox<String>("imageBox");
    return result;
  }

  Future<bool> flutterInit(String path) async {
    await Hive.initFlutter(path);
    return await _init();
  }

  Future<bool> dartInit(String path) async {
    Hive.init(path);
    return await _init();
  }

  Future<void> set(String boxName, String key, String value) async {
    switch (boxName) {
      case "tempBox":
        await tempBox.put(key, value);
        break;
      case "userBox":
        await userBox.put(key, value);
        break;
      case "postBox":
        await postBox.put(key, value);
        break;
      case "chatBox":
        await chatBox.put(key, value);
        break;
      case "imageBox":
        await imageBox.put(key, value);
        break;
      default:
        return;
    }
  }

  String? get(String boxName, String key){
    switch (boxName) {
      case "tempBox":
        return tempBox.get(key);
      case "userBox":
        return userBox.get(key);
      case "postBox":
        return postBox.get(key);
      case "chatBox":
        return chatBox.get(key);
      default:
        return null;
    }
  }

  delete(String boxName, String key) async {
    switch (boxName) {
      case "tempBox":
        await tempBox.delete(key);
        break;
      case "userBox":
        await userBox.delete(key);
        break;
      case "postBox":
        await postBox.delete(key);
        break;
      case "chatBox":
        await chatBox.delete(key);
        break;
      case "imageBox":
        await imageBox.delete(key);
        break;
      default:
        break;
    }
  }

  clearBox(String boxName) {
    switch (boxName) {
      case "tempBox":
        tempBox.clear();
        break;
      case "userBox":
        userBox.clear();
        break;
      case "postBox":
        postBox.clear();
        break;
      case "chatBox":
        chatBox.clear();
        break;
      case "imageBox":
        imageBox.clear();
        break;
      default:
        break;
    }
  }
}

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
