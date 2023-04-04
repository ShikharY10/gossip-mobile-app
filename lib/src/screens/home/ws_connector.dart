import 'dart:io';
import 'dart:isolate';
import 'package:get_it/get_it.dart';
import '../../../broker/broker.dart';
import '../../../database/config.dart';
import '../../../database/models.dart';
import '../../../utility/network/internet.dart';
import '../../../utility/websocket/websocket.dart';

class WebSocketConnector {

  late SendPort isolateSendPort;
  late DataBase _db;
  late Broker _broker;
  late Connectivity _connectivity;

  ReceivePort mainReceivePort = ReceivePort();

  WebSocketConnector() {
    _db = getDataBase();
    _broker = getBroker();
    _broker.register("ws_connector");
    _connectivity = GetIt.I.get<Connectivity>(instanceName: "connectivity");
  }

  connect(String address, String token) async {
    Future<void> status = _checkForInternet(const Duration(seconds: 3));
    status.then((value) async {
      await _connect(address, token);
    });
  }

  _connect(String address, String token) async {
    Directory directoty = GetIt.I.get<Directory>(instanceName: "directory");
    Isolate isolate = await Isolate.spawn<IsolateModel>(createIsolate, IsolateModel(
      address,
      mainReceivePort.sendPort,
      token,
      directoty.path
    ));
    isolate.addErrorListener(mainReceivePort.sendPort);
  }

  listen() {
    mainReceivePort.listen((message) {
      if (message is SendPort) {
        isolateSendPort = message;
        GetIt.I.registerSingleton<SendPort>(isolateSendPort, instanceName: "isolateSendPort");
      } else if (message is List) {
        if (message.isNotEmpty) {
          print("Isolate Error: ${message[0]}");
          print("StackTrace: ${message[0]}");
          print("Type: ${message[1].runtimeType}");
        }
      } else if (message is PartnerRequest) {
        HiveListOfString partnerRequests = HiveListOfString();
        String? savedPartnerRequests = _db.get("userBox", "partnerRequests");
        if (savedPartnerRequests != null) {
          partnerRequests.toObject(savedPartnerRequests);
        }

        String key = "partnerRequest:${message.id}";
        partnerRequests.items.add(key);

        _db.set("userBox", "partnerRequests", partnerRequests.toString());
        _db.set("userBox", key, message.toString());

        if (_broker.isSubscriberAwailable("partnerRequests")) {
          _broker.publish("ws_connector", "partnerRequests", message);
        }
      }
      else if (message is PartnerResponse) {
        HiveListOfString partnerResponses = HiveListOfString();
        String? savedPartnerResponses = _db.get("userBox", "partnerResponses");
        if (savedPartnerResponses != null) {
          partnerResponses.toObject(savedPartnerResponses);
        }

        String key = "partnerResponses:${message.id}";
        partnerResponses.items.add(key);

        _db.set("userBox", "partnerResponses", partnerResponses.toString());
        _db.set("userBox", key, message.toString());

        if (_broker.isSubscriberAwailable("partnerResponses")) {
          _broker.publish("ws_connector", "partnerRequests", message);
        }
      }
      else if (message is RemovePartnerNotify) {

      }
    });
  }

  Future<void> _checkForInternet(Duration duration) async {
    Future future = Future.doWhile(() async {
      await Future.delayed(duration);
      bool status = await _connectivity.getInternetConnectivityStatus();
      return !status;
    });
    return future;
  }
}


