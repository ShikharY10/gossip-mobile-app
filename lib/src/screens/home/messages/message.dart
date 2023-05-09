import 'package:flutter/material.dart';

import 'add_new_partner.dart';
import 'chats/chat.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 11, 27),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Message",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        splashRadius: 23,
                        icon: const Icon(Icons.add_comment),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNewPartnerChat()
                            )
                          );
                        },
                      ),
                    )
                  )
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
                for (int i = 0; i < 5; i++)
                  ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.amber,),
                    title: Text(
                      "shikhar.code",
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    subtitle: Text(
                      "Hi, what are you doing?",
                      style: TextStyle(
                        color: Colors.grey,

                      )
                    ),
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const ChatWindow("")
                        )
                      );
                    }
                      
                  ),
                  
              ],
            )
          ),
        ]
      )
    );
  }
}