import 'dart:convert';
import 'dart:typed_data';


// userBox
class User {
  String id;
  String name;
  String username;
  String email;
  String deliveryId;
  String role;
  String token;
  List<String> posts = [];
  List<String> partners = [];
  List<String> partnerRequests = [];
  List<String> yourPartnerRequests = [];
    
  User({
    this.id = "",
    this.name = "",
    this.username = "",
    this.email = "", 
    this.deliveryId = "",
    this.role = "",
    this.token = "",
  });

  toObject(String data) {
    Map<String, dynamic> mapData = json.decode(data);
    id = mapData["id"];
    name = mapData["name"];
    username = mapData["username"];
    email = mapData["email"];
    deliveryId = mapData["deliveryId"];
    role = mapData["role"];
    token = mapData["token"];

    for (var partner in (mapData["partners"] as List<dynamic>)) {
      partners.add(partner);
    }

    for (var partnerRequest in (mapData["partnerRequests"] as List<dynamic>)) {
      partnerRequests.add(partnerRequest);
    }

    for (var yourPartnerRequest in (mapData["yourPartnerRequests"] as List<dynamic>)) {
      yourPartnerRequests.add(yourPartnerRequest);
    }

    for (var post in (mapData["posts"] as List<dynamic>)) {
      posts.add(post);
    }

  }

  @override
  String toString() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["username"] = username;
    data["email"] = email;
    data["deliveryId"] = deliveryId;
    data["role"] = role;
    data["token"] = token;

    data["partners"] = partners;
    data["partnerRequests"] = partnerRequests;
    data["yourPartnerRequests"] = yourPartnerRequests;
    data["posts"] = posts;
    
    String jsonData = json.encode(data);
    return jsonData;
  }
}

class Partner {
  final String id;
  final String name;
  final String username;
  final String deliveryId;
  final String eKey;
  List<String> posts = [];
  final int partners;
  final String? status;
  final bool? done;

  Partner(
      {this.name  = "",
      this.username = "", 
      this.id = "", 
      this.deliveryId = "", 
      this.eKey = "",
      this.partners = 0,
      this.status = "",
      this.done = false 
      });

  static Partner toObject(String data) {
    var mapData = json.decode(data);

    List<String> _posts = [];

    for (var post in (mapData["posts"] as List<dynamic>)) {
      _posts.add(post);
    } 

    Partner partner = Partner(
      name: mapData["name"],
      username: mapData["username"],
      id: mapData["userId"],
      deliveryId: mapData["mid"],
      eKey: mapData["eKey"],
      status: mapData["status"],
      done: mapData["done"],
      partners: mapData["partners"]
    );

    partner.posts = _posts;
    return partner;
  }

  @override
  String toString() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["username"] = username;
    data["id"] = id;
    data["deliveryId"] = deliveryId;
    data["eKey"] = eKey;
    data["posts"] = posts;
    data["status"] = status;
    data["done"] = done;
    data["partners"] = partners;
    
    String jsonData = json.encode(data);
    return jsonData;
  }
}

class Request {
  String id;
  String targetUserName;
  String targetName;
  String senderUserName;
  String senderName;
  String publicKey;
  bool self;

  Request({
    this.id = "",
    this.targetUserName = "",
    this.targetName = "",
    this.senderUserName = "",
    this.senderName = "",
    this.publicKey = "",
    this.self = true
  });

  void toObject(String data) {
    Map<String, dynamic> mapData = json.decode(data);
    id = mapData["id"];
    targetUserName = mapData["targetUserName"];
    targetName = mapData["targetName"];
    senderUserName = mapData["senderUserName"];
    senderName = mapData["senderName"];
    publicKey = mapData["publicKey"];
    self = mapData["self"];
  }

  @override
  String toString() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["targetUserName"] = targetUserName;
    data["targetName"] = targetName;
    data["senderUserName"] = senderUserName;
    data["senderName"] = senderName;
    data["publicKey"] = publicKey;
    data["self"] = self;
    String jsonData = json.encode(data);
    return jsonData;
  }
}

class Response {
  String? id;
  bool? status;
  String? eAesKey;

  Response({this.id, this.status,  this.eAesKey});

  toObject(String source) {
    Map<String, dynamic> mapData = json.decode(source);
    id = mapData["id"];
    status = mapData["status"];
    eAesKey = mapData["eAesKey"];
  }

  @override
  String toString() {
    Map<String, dynamic> mapData = {};
    mapData["id"] = id;
    mapData["status"] = status;
    mapData["eAesKey"] = eAesKey;
    String jsonData = json.encode(mapData);
    return jsonData;
  }
}

class PartnerRequest {
  String id;
  String requesterId;
  String requesterUsername;
  String requesterName;
  String targetId;
  String targetUsername;
  String targetName;
  String publicKey;
  String createdAt;

  PartnerRequest({
    this.id = "",
    this.requesterId = "",
    this.requesterUsername = "",
    this.requesterName = "",
    this.targetId = "",
    this.targetUsername = "",
    this.targetName = "",
    this.publicKey = "",
    this.createdAt = "",
  });
  
  @override
  String toString() {
    Map<String, dynamic> mapData = {
      "id": id,
      "requesterId": requesterId,
      "requesterUsername": requesterUsername,
      "requesterName": requesterName,
      "targetId": targetId,
      "targetUsername": targetUsername,
      "targetName": targetName,
      "publicKey": publicKey,
      "createdAt": createdAt,
    };
    return json.encode(mapData);
  }

  toObject(String jsonEncoded) {
    Map<String, dynamic> mapData = json.decode(jsonEncoded);
    id = mapData["id"];
    requesterId = mapData["requesterId"];
    requesterUsername = mapData["requesterUsername"];
    requesterName = mapData["requesterName"];
    targetId = mapData["targetId"];
    targetUsername = mapData["targetUsername"];
    targetName = mapData["targetName"];
    publicKey = mapData["publicKey"];
    createdAt = mapData["createdAt"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = {
      "id": id,
      "requesterId": requesterId,
      "requesterUsername": requesterUsername,
      "requesterName": requesterName,
      "targetId": targetId,
      "targetUsername": targetUsername,
      "targetName": targetName,
      "publicKey": publicKey,
      "createdAt": createdAt,
    };
    return mapData;
  }
}

class PartnerResponse {
  String id;
  bool isAccepted;
  String responserId;
  String targetId;
  String sharedKey;

  PartnerResponse({
    this.id = "",
    this.isAccepted = false,
    this.responserId = "",
    this.targetId = "",
    this.sharedKey = "",
  });

  @override
  String toString() {
    Map<String, dynamic> mapData = {
      "id": id,
      "isAccepted": isAccepted,
      "responserId": responserId,
      "targetId": targetId,
      "sharedKey": sharedKey
    };
    return json.encode(mapData);
  }

  toObject(String jsonEncoded) {
    Map<String, dynamic> mapData = json.decode(jsonEncoded);
    id = mapData["id"];
    isAccepted = mapData["isAccepted"];
    responserId = mapData["responserId"];
    targetId = mapData["targetId"];
    sharedKey = mapData["sharedKey"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = {
      "id": id,
      "isAccepted": isAccepted,
      "responserId": responserId,
      "targetId": targetId,
      "sharedKey": sharedKey
    };
    return mapData;
  }
}

class RemovePartnerNotify {
  String id;
  String notifierId;
  String targetId;

  RemovePartnerNotify({
    this.id = "",
    this.notifierId = "",
    this.targetId = "",
  });

  @override
  String toString() {
    Map<String, dynamic> mapData = {
      "id": id,
      "notifierId": notifierId,
      "targetId": targetId
    };
    return json.encode(mapData);
  }

  toObject(String jsonEncoded) {
    Map<String, dynamic> mapData = json.decode(jsonEncoded);
    id = mapData["id"];
    notifierId = mapData["notifierId"];
    targetId = mapData["targetId"];
  }
}

class HiveListOfString {
  List<dynamic> items = [];

  @override
  String toString() {
    return json.encode(items);
  }

  toObject(String jsonEncoded) {
    List<dynamic> savedItems = json.decode(jsonEncoded);
    savedItems.forEach((item) => items.add(item));
  }
}

// chatBox
class Chat {
  String sMID;
  bool self;
  String datetime;
  String msg;
  String mloc;
  int tp;
  Chat({this.sMID = "", this.self = false, this.datetime = "", this.msg = "", this.mloc = "", this.tp = -1});

  @override
  String toString() {
    Map<String, String> mapData = <String, String>{
      "smid": sMID,
      "self": self.toString(),
      "datetime": datetime,
      "msg": msg,
      "mloc": mloc,
      "tp": tp.toString(),
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
    tp = int.parse(mapData["tp"]);
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
}

class RecentGossips {
  String name;
  String lastMsg;
  String senderMID;
  String dateTime;
  int unSeenMsgCount;
  String profilePic;
  RecentGossips(
    {this.name = "", this.lastMsg = "", this.senderMID = "", this.dateTime = "", this.unSeenMsgCount = 0, this.profilePic = ""});

  @override
  String toString() {
    Map<String, String> mapData = <String, String>{
      "name": name,
      "lastmsg": lastMsg,
      "sendermid": senderMID,
      "datetime": dateTime,
      "usmc": unSeenMsgCount.toString(),
      "prifilepic": profilePic,
    };
   return json.encode(mapData);
  }

  void toObject(String data) {
    Map<String,String> mapData = json.decode(data);
    name = mapData["name"]!;
    lastMsg = mapData["lastmsg"]!;
    senderMID = mapData["sendermid"]!;
    dateTime = mapData["datetime"]!;
    unSeenMsgCount = int.parse(mapData["usmc"]!);
    profilePic = mapData["prifilepic"]!;
  }
}

// postBox
class Posts {
  String postId;
  String userId;
  String caption;
  bool containsImage;
  bool containsCaption;
  int likes;
  int commentCount;
  List<String> comments = [];
  List<String> tags = [];
  List<String> mentions = [];
  DateTime createdAt = DateTime.now();

  Posts({
    this.postId = "",
    this.userId = "",
    this.caption = "",
    this.containsImage = false,
    this.containsCaption = false,
    this.likes = 0,
    this.commentCount = 0,
  });

  void toObject(String source) {
    Map<String, dynamic> mapData = json.decode(source);
    postId = mapData["postId"];
    userId = mapData["userId"];
    caption = mapData["caption"];
    containsImage = mapData["containsImage"];
    containsCaption = mapData["containsCaption"];
    likes = mapData["likes"];
    commentCount = mapData["commentCount"];
    createdAt = DateTime.parse(mapData["createdAt"]);

    for (var comment in (mapData["comments"] as List<dynamic>)) {
      comments.add(comment);
    }

    for (var tag in (mapData["tags"] as List<dynamic>)) {
      tags.add(tag);
    }

    for (var mention in (mapData["mentions"] as List<dynamic>)) {
      mentions.add(mention);
    }
  }

  @override
  String toString() {
    Map<String, dynamic> mapData = {};
    mapData["postId"] = postId;
    mapData["userId"] = userId;
    mapData["caption"] = caption;
    mapData["containsImage"] = containsImage;
    mapData["containsCaption"] = containsCaption;
    mapData["likes"] = likes;
    mapData["commentCount"] = commentCount;
    mapData["comments"] = comments;
    mapData["tags"] = tags;
    mapData["mentions"] = mentions;
    mapData["createdAt"] = createdAt.toIso8601String();

    String jsonData = json.encode(mapData);
    return jsonData;
  }
}