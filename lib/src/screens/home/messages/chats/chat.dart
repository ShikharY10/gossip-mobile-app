import 'package:flutter/material.dart';
import 'package:vajra/vajra.dart';

import '../../../../../broker/broker.dart';
import '../../../../../database/config.dart';
import '../../../../../database/models.dart';
import '../../profile/profile.dart';

class ChatWindow extends StatefulWidget {
  final String partnerId;
  const ChatWindow(this.partnerId, {Key? key}) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  late DataBase db;
  late Broker broker;
  late Vajra vajra;

  Partner partner = Partner();

  @override
  void initState() {
    super.initState();

    db = getDataBase();
    broker = getBroker();
    vajra = getVajra("client");

    String? savedPartnerDetails = db.get("userBox", "partner.${widget.partnerId}");
    if (savedPartnerDetails != null) {
      partner = Partner.toObject(savedPartnerDetails);
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 11, 11, 27),
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 53, 22, 34),
        title: ListTile(
          horizontalTitleGap: 0,
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: const SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: Colors.teal,
            ),
          ),
          title: const Text(
            "Shivani Yadav",
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold
            )
          ),
          subtitle: const Text(
            "shivani22",
            style: TextStyle(
              fontSize:14,
              color: Colors.white
            )
          ),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Profile(
                  id: partner.id,
                  self: false,
                )
              )
            );
          },
        )
      ),
    );
  }
}
