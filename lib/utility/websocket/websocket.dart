
// ignore_for_file: avoid_print
import 'dart:isolate';
import 'dart:typed_data';

import 'package:web_socket_channel/io.dart';
import '../../database/config.dart';
import '../../schema/schema.pb.dart';
import 'controllers.dart';

class IsolateModel {
  final String address;
  final SendPort mainSendPort;
  final String token;
  final String path;
  IsolateModel(this.address, this.mainSendPort, this.token, this.path);
}

void createIsolate(IsolateModel model) {
  ReceivePort isolateReceivePort = ReceivePort();
  model.mainSendPort.send(isolateReceivePort.sendPort);
  WebSocket(
    model.address, 
    model.token, 
    model.path, 
    isolateReceivePort, 
    model.mainSendPort
  );
}

class WebSocket {
  String address;
  String token;
  String path;
  ReceivePort isolateReceivePort;
  SendPort mainSendPort;

  DataBase db = DataBase();
  bool isDataBaseInitialized = false;
  bool isConnected = false;

  late IOWebSocketChannel channel;
  late Controllers controllers;

  WebSocket(this.address, this.token, this.path, this.isolateReceivePort, this.mainSendPort) {
    initializeDataBase();
    connect();
  }

  initializeDataBase() async {
    Future<bool> isInit = db.dartInit(path);
    isInit.then((value) {
      if (value) {
        controllers = Controllers(db, mainSendPort);
        isDataBaseInitialized = true;
      }
    });
  }

  connect() async {
    try {
      print("connnecting | uri: $address");
      channel = IOWebSocketChannel.connect(
        Uri.parse(address + "?token=" + token),
      );
      
      print("connected");
      channel.ready.then((value) {
        print("Connected to Websocket");
        isConnected = true;
        listen();
      });
    } on Exception catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Something went wrong while connecting to the server");
    } finally {
      print("finally triggered");
    }
  }

  listen() async {
    Payload payload = Payload();
    channel.stream.listen(
      (event) {
        payload.mergeFromBuffer((event as Uint8List));
        switch (payload.type) {
          case "011":
            controllers.makePartnerRequest(payload.data);
            break;
          case "012":
            controllers.makePartnerResponse(payload.data);
            break;
          case "013":
            controllers.removePartnerNotify(payload.data);
            break;     
          default:
        }
      },
      onError: (error) {
        print("LISTNER ERROR: $error");
      },
      onDone: () {
        print("Connection closed");
      }
    );
  }
}
