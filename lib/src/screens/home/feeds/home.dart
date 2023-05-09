import 'package:flutter/material.dart';
import 'add_feed/add_feeds.dart';
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

                          // Connectivity connectivity = GetIt.I.get<Connectivity>(instanceName: "connectivity");
                          // String b = await connectivity.getBatteryLevel();
                          // print(b);
                          // bool i = await connectivity.getInternetConnectivityStatus();
                          // print("Internet: $i");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNewFeed()
                            )
                          );
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


