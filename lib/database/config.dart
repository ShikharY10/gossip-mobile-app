import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

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
      case "imageBox":
        return imageBox.get(key);
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
