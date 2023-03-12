import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gossip_frontend/utility/network/internet.dart';
import 'post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isButtonLiked = false;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color.fromARGB(255, 238, 61, 202), Color.fromARGB(255, 63, 50, 252)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 11, 27),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: Text("GossiP",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      foreground: Paint()..shader = linearGradient
                    ),
                    )
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.amber,
                    alignment: Alignment.centerRight,
                    child: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        splashRadius: 23,
                        icon: const Icon(Icons.add_box_rounded),
                        onPressed: () async {
                          Connectivity connectivity = GetIt.I.get<Connectivity>(instanceName: "connectivity");
                          String b = await connectivity.getBatteryLevel();
                          print(b);
                          bool i = await connectivity.getInternetConnectivityStatus();
                          print("Internet: $i");
                        },
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.white,
          ),

          Expanded(
            child: ListView(
              children: [
                for (int i = 0; i < 10; i++)
                  const Post()
              ]
            )
          )

        ]
      )
    );
  }

  Widget postActionTrayButton({IconData? icon, VoidCallback? onPressed}) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        splashRadius: 23,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }

}



// Widget moreMenu() {
//   return Dialog(
//     alignment: Alignment.centerRight,
//     backgroundColor: Color.fromARGB(255, 11, 11, 27),
//     // iconPadding: EdgeInsets.zero,
//     insetPadding: EdgeInsets.zero,
//     // titlePadding: EdgeInsets.zero,
//     // buttonPadding: EdgeInsets.zero,
//     // actionsPadding: EdgeInsets.zero,
//     // contentPadding: EdgeInsets.zero,
//     clipBehavior: Clip.hardEdge,
//     child: SizedBox(
//       width: 10,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("Mentions"),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("Edit"),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("Delete"),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: () async {
          //     HiveH hiveHandler = GetIt.I.get<HiveH>();
          //     await hiveHandler.deleteUserData();
          //     print("User Data Deleted");
          //   }
          // ),