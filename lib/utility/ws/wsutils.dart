// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypton/crypton.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../database/hive_handler.dart';
import '../gbp/gbProto.pb.dart' as gbp;
import 'package:cryptography/cryptography.dart';

Uint8List _getRandUint8List(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return Uint8List.fromList(values);
}

Future<Uint8List> aesEncrypt(List<int> data, SecretKey secretKey) async {
  final algorithm = AesGcm.with256bits();
  final secretBox = await algorithm.encrypt(
    data,
    secretKey: secretKey,
    nonce: _getRandUint8List(12),
  );
  return secretBox.concatenation();
}

Future<List<int>> aesDecrypt(Uint8List cipherText, SecretKey secretKey) async {
  final algorithm = AesGcm.with256bits();
  SecretBox secretBox =
      SecretBox.fromConcatenation(cipherText, nonceLength: 12, macLength: 16);
  final plainText = await algorithm.decrypt(secretBox, secretKey: secretKey);
  return plainText;
}

String rsaEncrypt(RSAKeypair keyPair, String data) {
  String cipherText = keyPair.publicKey.encrypt(data);
  return cipherText;
}

Uint8List rsaDecrypt(RSAKeypair keyPair, Uint8List cipherText) {
  Uint8List plainText = keyPair.privateKey.decryptData(cipherText);
  return plainText;
}

RSAPublicKey loadpemtopub(String key) {
  RSAPublicKey pubKey = RSAPublicKey.fromPEM(key);
  return pubKey;
}


// ======================================================================

void isolateRunner(IsolateModel model) {
  ReceivePort wsReceivePort = ReceivePort();
  model.mainSendPort.send(wsReceivePort.sendPort);
  WSHandler handler = WSHandler(model.address, model.mid, model.uid, model.mainKey, model.path, wsReceivePort, model.mainSendPort);
  handler.connectAndListen();
}

class IsolateCommunicator {
  SendPort sendPort;
  ReceivePort receivePort;
  IsolateCommunicator(this.sendPort, this.receivePort);
}

class IsolateModel {
  final String address;
  final SendPort mainSendPort;
  final String mid;
  final String uid;
  final String mainKey;
  final String path;
  IsolateModel(this.address, this.mainSendPort, this.mid, this.uid, this.mainKey, this.path);
}

class WSHandler {

  String address;
  String mid;
  String uid;
  String mainKey;
  String path;
  ReceivePort wsReceivePort;
  SendPort mainSendPort;

  late IOWebSocketChannel channel;
  late User myData;

  IsolateHive isoHive = IsolateHive();
  
  WSHandler(this.address, this.mid, this.uid, this.mainKey, this.path, this.wsReceivePort, this.mainSendPort) {
    isoHive.init(path);
    listenForMainEvents();
  }

  Future listenForMainEvents() async {
    wsReceivePort.listen((data) async {
      print("new data");
      if (data is SendPayload) {
        Future<Uint8List> msg = getRawMsg(data.tid, data.msg);
        msg.then((value) {
          channel.sink.add(value);
          print("message send");
        });
      }
      else if (data is User) {
        myData = data;
      }
      else if (data is AckPayload) {
        Future<Uint8List> ack = ackMsg(mid, data.mloc);
        ack.then((value) {
          channel.sink.add(value);
        });
      }
      else if (data is HandshackPayload) {
        Uint8List hs = await handShack(data.number);
        channel.sink.add(hs);
        // hs.then((value) {
          
        // });
      }
    });
  }

  void connectAndListen() async {
    bool connected = false;
    
    try {
      channel = IOWebSocketChannel.connect(
        Uri.parse('ws://'+ address +':8000/'),
      );
      connected = true;
    } on SocketException {
      print("Unable To Connect To The Server!");
    } on WebSocketChannelException {
      print("error while connecting to the server");
    } catch (e) {
      print("Something went wrong while connecting to the server");
    }

    if (connected) {
      Uint8List init = await getInitData();
      channel.sink.add(init);

      var sub = channel.stream.listen((data) async {
        gbp.Transport trans = gbp.Transport.fromBuffer(data);
        if (trans.tp == 2) {
          typeTwo(trans);
        } else if (trans.tp == 4) {
          typeFour(trans);
        } else if (trans.tp == 5) {
          typeFive(trans);
        } else if (trans.tp == 6) {
          typeSix(trans);
        } else if (trans.tp == 7) {
          typeSeven(trans);
        } else if (trans.tp == 8) {
          typeEight(trans);
        }
      });
      sub.onError((e) {
        sub.cancel();
      });
    }

    
  }

  void typeTwo(gbp.Transport trans) async {
    List<int> MSG = await aesDecrypt(Uint8List.fromList(trans.msg),
        SecretKey(base64.decode(mainKey)));
    gbp.MsgFormat chat = gbp.MsgFormat.fromBuffer(MSG);
    Chat c = Chat(
      sMID : chat.sid,
      self: false,
      datetime: DateTime.now().toIso8601String(),
      msg: chat.msg,
      mloc: chat.mloc
    );
    mainSendPort.send(c);
  }

  void typeFour(gbp.Transport trans) async {
    List<int> phs1 = await aesDecrypt(Uint8List.fromList(trans.msg),
        SecretKey(base64.decode(mainKey)));
    gbp.HandShackP1 HS1 = gbp.HandShackP1.fromBuffer(phs1);

    List<int> akey = Hive.generateSecureKey();
    String bskey = base64.encode(akey);
    RSAPublicKey pubKey = loadpemtopub(HS1.publicKey);
    String cipherText = pubKey.encrypt(bskey);

    gbp.HandShackP2 HS2 = gbp.HandShackP2(
      encryptedData: cipherText,
      targetMID: HS1.senderMID,
      senderMID: mid,
      hsid: HS1.hsid,
      permit: 1,
    );
    List<int> MSG = await aesEncrypt(
      HS2.writeToBuffer(),
      SecretKey(base64.decode(mainKey))
    );

    gbp.Transport trans2 = gbp.Transport(
      tp: 5,
      id: mid,
      msg: MSG
    );
  
    channel.sink.add(trans2.writeToBuffer());

    isoHive.isolateBD.put(HS1.hsid, base64.encode(akey));

    Future<Uint8List> ack = ackMsg(mid, HS1.mloc);
    print("mid: $mid, | mloc: ${HS1.mloc}");
    ack.then((value) {
      channel.sink.add(value);
    });
    print("HS-T4-RECVED");
  }
  
  void typeFive(gbp.Transport trans) async {
    List<int> phs1 = await aesDecrypt(
      Uint8List.fromList(trans.msg),
      SecretKey(base64.decode(mainKey))
    );
    gbp.HandShackP2 HS2 = gbp.HandShackP2.fromBuffer(phs1);
    if (HS2.permit == 1) {
      String? pemPriKey = isoHive.isolateBD.get(HS2.hsid);
      RSAPrivateKey priKey = RSAPrivateKey.fromPEM(pemPriKey!);
      String b64AesKey = priKey.decrypt(HS2.encryptedData);
      isoHive.isolateBD.put(HS2.hsid, b64AesKey);
      Future<Uint8List> ack = ackMsg(mid, HS2.mloc);
      print("mid: $mid, | mloc: ${HS2.mloc}");
      ack.then((value) {
        channel.sink.add(value);
      });
      print("HS-T5-RECVED");
    }
  }

  void typeSix(gbp.Transport trans) async {
    List<int> phs1 = await aesDecrypt(Uint8List.fromList(trans.msg),SecretKey(base64.decode(mainKey)));
    gbp.ConnDataTransfer connData = gbp.ConnDataTransfer.fromBuffer(phs1);
    String? aesKey = isoHive.isolateBD.get(connData.hsid);
    if (aesKey == null ) {
      return;
    }

    Connection conn = Connection(
      name: connData.name,
      mnum: connData.number,
      uid: "",
      mid: connData.mID,
      profilepic: connData.profilePic,
      key: aesKey,
    );
    mainSendPort.send(conn);
    Future<Uint8List> ack = ackMsg(mid, connData.mloc);
    print("mid: $mid, | mloc: ${connData.mloc}");
    ack.then((value) {
      channel.sink.add(value);
    });
    print("One side HandShacke process done!");
    mainSendPort.send(HandShackNotification(1, true, connData.number));
  }

  void typeSeven(gbp.Transport trans) async {
    List<int> phs1 = await aesDecrypt(Uint8List.fromList(trans.msg),SecretKey(base64.decode(mainKey)));
    gbp.HandshakeDeleteNotify notify = gbp.HandshakeDeleteNotify.fromBuffer(phs1);

    Future<Uint8List> ack = ackMsg(mid, notify.mloc);
    print("mid: $mid, | mloc: ${notify.mloc}");
    ack.then((value) {
      channel.sink.add(value);
    });
    mainSendPort.send(notify);
  }

  void typeEight(gbp.Transport trans) async {
    print("image change notification");
    List<int> phs1 = await aesDecrypt(Uint8List.fromList(trans.msg),SecretKey(base64.decode(mainKey)));
    gbp.ChangeProfilePayload notify = gbp.ChangeProfilePayload.fromBuffer(phs1);
    mainSendPort.send(notify);
    Future<Uint8List> ack = ackMsg(mid, notify.mloc);
    ack.then((value) {
      channel.sink.add(value);
    });
    
  }

  Future<Uint8List> getInitData() async {
    gbp.ClientName name = gbp.ClientName(uId: uid, mId: mid);
    var dt = name.writeToBuffer();
    Uint8List akey = base64.decode(mainKey);
    Uint8List cipherText = await aesEncrypt(dt, SecretKey(akey));
    gbp.Transport trans = gbp.Transport(tp: 1, id: mid, msg: cipherText);
    return trans.writeToBuffer();
  }

  Future<Uint8List> getRawMsg(String tid, String msg) async {
    gbp.ChatPayload chat = gbp.ChatPayload(tid: tid, sid: mid, msg: msg);
    Uint8List akey = base64.decode(mainKey);
    Uint8List cipherText =
        await aesEncrypt(chat.writeToBuffer(), SecretKey(akey));
    gbp.Transport trans = gbp.Transport(tp: 2, id: mid, msg: cipherText);
    return trans.writeToBuffer();
  }

  Future<Uint8List> ackMsg(String mid, String mLoc) async {
    gbp.ChatAck ackC = gbp.ChatAck(mId: mid, mLoc: mLoc);
    Uint8List akey = base64.decode(mainKey);
    Uint8List cipherText =
        await aesEncrypt(ackC.writeToBuffer(), SecretKey(akey));
    gbp.Transport trans = gbp.Transport(tp: 3, id: mid, msg: cipherText);
    return trans.writeToBuffer();
  } 

  Future<Uint8List> handShack(String number) async {
    print("Starting handshaking process...");
    Uint8List hsid = _getRandUint8List(18);
    RSAKeypair RSAKP = RSAKeypair.fromRandom(keySize: 2048);
    String pubkey = RSAKP.publicKey.toFormattedPEM();
    gbp.HandShackP1 HS1 = gbp.HandShackP1(
      targetMobile: number, 
      senderMID: mid, 
      publicKey: pubkey,
      hsid: base64.encode(hsid),
    );
    Uint8List PHS1 = HS1.writeToBuffer();
    Uint8List akey = base64.decode(mainKey);
    Uint8List cipherText = await aesEncrypt(PHS1, SecretKey(akey));
    gbp.Transport trans = gbp.Transport(msg: cipherText, id: mid, tp: 4);
    Uint8List Ptrans = trans.writeToBuffer();
    String priKey = RSAKP.privateKey.toFormattedPEM();
    isoHive.isolateBD.put(base64.encode(hsid), priKey);
    return Ptrans;
  }
}

class SendPayload {
  String tid;
  String msg;
  SendPayload(this.tid, this.msg);
}

class AckPayload {
  String mid;
  String mloc;
  AckPayload(this.mid, this.mloc);
}

class HandshackPayload {
  String number;
  HandshackPayload(this.number);
}

class DevicePayload {
  bool isRealDevice;
  DevicePayload(this.isRealDevice);
}

class HandShackNotification {
  int type;
  bool completed;
  String number;
  HandShackNotification(this.type, this.completed, this.number);
}

class HSRequestPayload {
  String senderMID;
  String b64AesKey;
  HSRequestPayload(this.senderMID, this.b64AesKey);
}

class IsolateHive {
  late Box<String> isolateBD;
  Future<void> init(String path) async {
    Hive.init(path);
    isolateBD = await Hive.openBox<String>("isolatedb");
  }
}

