import 'package:flutter/material.dart';

class AddNewPartnerChat extends StatefulWidget {
  const AddNewPartnerChat({Key? key}) : super(key: key);

  @override
  State<AddNewPartnerChat> createState() => _AddNewPartnerChatState();
}

class _AddNewPartnerChatState extends State<AddNewPartnerChat> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 11, 27),
      appBar: AppBar(
        title: const Text("New Message"),
        backgroundColor: const Color.fromARGB(255, 11, 11, 27),
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 11, 11, 27),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 255, 246, 167)),
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                    // suff
                    suffixIcon: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.search), 
                        onPressed: () {}
                      ),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 23, 23, 56),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight:  Radius.circular(20)
                      )
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                  ),
                  onChanged: (username) {},
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (int i=0; i<10; i++)
                    const NewMsgTile()
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewMsgTile extends StatefulWidget {
  const NewMsgTile({Key? key}) : super(key: key);

  @override
  State<NewMsgTile> createState() => _NewMsgTileState();
}

class _NewMsgTileState extends State<NewMsgTile> {
  bool showNextButton = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: showNextButton ? const Color.fromARGB(255, 31, 31, 53) : null,
      child: ListTile(
        leading: const CircleAvatar(
          radius:20,
          backgroundColor: Colors.red,
        ),
        title: const Text("Shikhar Yadav",
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        subtitle: const Text("shikhar.code",
          style: TextStyle(
            color: Colors.grey
          )
        ),
        trailing: showNextButton ? IconButton(
          color: Colors.white,
          icon: const Icon(Icons.send),
          onPressed: () {},
        ) : null,
        onTap: () {
          if (showNextButton) {
            setState(() {
              showNextButton = false;
            });
          } else {
            setState(() {
              showNextButton = true;
            });
          }
        },
      ),
    );
  }
}