// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:convert';
// import 'dart:isolate';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../database/hive_handler.dart';
// // import '../chatmsg/chatui.dart';
// import '../../../providers/list_provider.dart';
// import '../../../utility/gbp/internalProto.pb.dart';
// import '../chats/chatui.dart';

// class AllConnection extends StatefulWidget {
//   List<Connection> allConnection = [];
//   List<String> allConnMid = [];
//   HiveH hiveHandler;
//   SendPort wsSendPort;
//   Stream<Chat> chatStream;
//   StreamController<RecentGossips> rGossipController;
//   AllConnection({ Key? key, required this.allConnection, required this.allConnMid, required this.hiveHandler, required this.wsSendPort, required this.chatStream, required this.rGossipController}) : super(key: key);

//   @override
//   State<AllConnection> createState() => _AllConnectionState();
// }

// class _AllConnectionState extends State<AllConnection> {

//   late List<String> allConnMid;
//   late List<Connection> allConnections;

//   @override
//   initState() {
//     super.initState();
//     allConnMid = widget.allConnMid;
//     allConnections = widget.allConnection;
//   }

//   void getAllConnections() {
//     List<String> allconns = widget.hiveHandler.connectionsBox.values.toList();
//     for (int i = 0; i < allconns.length; i++) {
//       Connection conn = Connection();
//       conn.toObject(allconns[i]);
//       if (allConnMid.contains(conn.mid)) {
//         continue;
//       }else {
//         allConnMid.add(conn.mid);
//         allConnections.add(conn);
//       }
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         print("=============REFRESHING=========");
//         getAllConnections();
//         await Future.delayed(const Duration(seconds: 1));
//         setState((){});
//         return;
//       },
//       child: allConnections.isNotEmpty ? ListView.builder(
//         itemCount: allConnections.length,
//         itemBuilder: (BuildContext context, int i) {
//           return Padding(
//             padding: const EdgeInsets.only(
//               bottom: 2.0, left: 10.0, right: 10.0),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: MemoryImage(
//                     base64.decode(allConnections[i].profilepic)
//                   ),
//                   radius: 20,
//                 ),
//                 title: Text(allConnections[i].name,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 135, 212, 182),
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold
//                   )
//                 ),
//                 subtitle: Text(
//                   allConnections[i].mnum,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 79, 100, 92),
//                   )
//                 ),
//                 trailing: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4.0),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.blur_off_sharp,
//                           color: Color.fromARGB(255, 135, 212, 182),
//                         ),
//                         onPressed: () {
//                           print("Hide");
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   print("Next page");
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                         ChangeNotifierProvider(
//                           create: (context) => ListProvider(),
//                           child: ChatUI(
//                             myData: allConnections[i],
//                             wsSendPort: widget.wsSendPort,
//                             hiveHandler: widget.hiveHandler,
//                             chatStream: widget.chatStream,
//                             rGossipController: widget.rGossipController
//                             )
//                         )
//                     )
//                   );
//                 },
//               ),
//             );
//           }) : Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Image(
//                   width: 100,
//                   height: 100,
//                   image: AssetImage("assets/images/antenna.png")
//                 ),
//                 Text(
//                   "You don't have any connections",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 135, 212, 182)
//                   )
//                 )
//               ],
//             )
//           ),
//     );
//   }

  
// }