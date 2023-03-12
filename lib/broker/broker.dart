import 'dart:async';
import 'package:get_it/get_it.dart';

Broker getBroker() {
  Broker broker;
  broker = GetIt.I.get<Broker>(instanceName: "broker");
  return broker;
}

class Broker {

  late StreamController<Protocol> streamController;
  final Map<String, StreamController<dynamic>> _subscribers = {};
  final Map<String, Stream<dynamic>> _broadCasters = {};
  
  Broker() {
    streamController = StreamController<Protocol>();
    _listen();
  }

  register(String name) {
    StreamController<dynamic> externalStream = StreamController<dynamic>();
    _subscribers[name] = externalStream;
  }

  registerBroadCaster(String name) {
    StreamController<dynamic> externalStream = StreamController<dynamic>();
    _subscribers[name] = externalStream;
    _broadCasters[name] = externalStream.stream.asBroadcastStream();
  }

  delete(String name) {
    _subscribers.remove(name);
  }

  _listen() {
    streamController.stream.listen((event) {
      if (_subscribers.containsKey(event.subscriber)) {
        StreamController? externalStream = _subscribers[event.subscriber];
        if (externalStream != null) {
          externalStream.sink.add(event);
        }
      }
    });
  }

  StreamController<dynamic> _getSubscriber(String name) {
    StreamController<dynamic>? subscriber = _subscribers[name];
    if (subscriber == null) {
      throw Exception("listening to publisher which are not yet registered");
    }
    return subscriber;
  }

  StreamSubscription<dynamic> listen(String name, void Function(dynamic event) onData) {
    StreamController<dynamic> externalStream = _getSubscriber(name);
    return externalStream.stream.listen((event) {
      onData(event);
    });
  }

  Stream<dynamic> _getBroadCaster(String subscriber) {
    Stream<dynamic>? bStream = _broadCasters[subscriber];
    if (bStream == null) {
      throw Exception("subscriber not registered");
    }
    return bStream;
  }

  StreamSubscription<dynamic> listenBroadCast(String subscriber, void Function(dynamic event) onData) {
    Stream<dynamic> externalStream = _getBroadCaster(subscriber);
    return externalStream.listen((event) {
      onData(event);
    });
  }

  publish(String publisher, String subscriber, dynamic data) {
    Protocol serviceIdentifier = Protocol(publisher, subscriber, data);
    streamController.sink.add(serviceIdentifier);
  }

  bool isSubscriberAwailable(String name) {
    return _subscribers.containsKey(name);
  }
}

class Protocol {
  final String publisher;
  final String subscriber;
  final dynamic data;
  Protocol(this.publisher, this.subscriber, this.data);
}