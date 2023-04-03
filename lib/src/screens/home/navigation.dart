import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../broker/broker.dart';
import '../../../database/config.dart';
import 'feeds/home.dart';
import 'messages/message.dart';
import 'profile/profile.dart';
import 'partners/people.dart';
import 'ws_connector.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int indexSelected = 0;
  late DataBase db;

  _webSocketConnector() async {
    String? token = db.get("tempBox", "token");
    if (token != null) {
      print("trying to conenct");
      WebSocketConnector wsConnector = WebSocketConnector();
      Future<void> future = wsConnector.connect("ws://10.2.2.0/secure/connect", token);
      print("going to listen");
      future.then((value) => wsConnector.listen());
    }
  }

  @override
  void initState() {
    super.initState();
    db = getDataBase();

    Broker broker = Broker();
    GetIt.I.registerSingleton<Broker>(broker, instanceName: "broker");
    
    _webSocketConnector();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 11, 11, 27),
                child: [
                  const Home(),
                  const Message(),
                  const People(),
                  const Profile(),
                ][indexSelected]
              )
            ),
            NavigationBar(
              selectedIndex: indexSelected,
              onDestinationSelected: (index) {
                setState(() {
                  indexSelected = index;
                });
              },
              height: 50.0,
              elevation: 5.0,
              backgroundColor: const Color.fromARGB(255, 11, 11, 27),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                    color: Color.fromARGB(255, 135, 212, 182)
                  ),
                  label: "Home"
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.chat,
                    size: 30.0,
                    color: Color.fromARGB(255, 135, 212, 182)
                  ),
                  label: "Chat"
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.people_alt_rounded,
                    size: 30.0,
                    color: Color.fromARGB(255, 135, 212, 182)
                  ),
                  label: "People"
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person,
                    size: 30.0,
                    color: Color.fromARGB(255, 135, 212, 182)
                  ),
                  label: "Profile"
                ),
              ]
            )
          ]
        )
      ),
    );
  }
}