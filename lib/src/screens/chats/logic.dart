// import 'dart:async';

// import '../../../database/hive_handler.dart';

// class Logic {
//   StreamController<int> checkForUser = StreamController<int>();
//   StreamController<Chat> chatData = StreamController<Chat>();

//   late Stream<int> checkForUserStream;
//   late Stream<Chat> chatDataStream;

//   StreamSink<int> notify;

//   Logic({required this.notify}) {
//     checkForUserStream = checkForUser.stream.asBroadcastStream();
//     chatDataStream = chatData.stream.asBroadcastStream();
//   }

//   Future<void> notifyForUserAvailibity() async {
//     checkForUserStream.listen((event) { 
      
//     });
//   }

// }