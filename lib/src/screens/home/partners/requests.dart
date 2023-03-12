import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 11, 27),
        title: const Text("Requests",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 11, 27),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const RequestTile();
        }
      )
    );
  }
}

class RequestTile extends StatefulWidget {
  const RequestTile({Key? key}) : super(key: key);

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {

  bool isAcceptBtnClicked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.amber,),
      title: const Text(
        "Shikhar Yadav",
        style: TextStyle(
          fontSize: 16,
        )
      ),
      subtitle: const Text(
        "shikhar.code",
        style: TextStyle(
          color: Colors.grey,
        )
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Container(
              width: 80,
              height: 25,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 83, 126),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              alignment: Alignment.center,
              child: isAcceptBtnClicked 
                ? const SizedBox(
                  width: 13,
                  height: 13,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Text("Accept")
              // child: const Icon(Icons.check, color: Colors.white),
            ),
            onTap: () {
              setState(() {
                isAcceptBtnClicked = true;
              });
              Future.delayed(
                const Duration(seconds: 3),
                () {
                  if (context.mounted) {
                    setState(() {
                      isAcceptBtnClicked = false;
                    });
                  }
                }
              );
            },
          ),
        ],
      ),
      dense: true,
    );
  }
}
