import 'package:flutter/material.dart';

class Requested extends StatefulWidget {
  const Requested({Key? key}) : super(key: key);

  @override
  State<Requested> createState() => _RequestedState();
}

class _RequestedState extends State<Requested> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 11, 27),
        title: const Text("Your Requests",
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
          return const RequestedTile();
        }
      )
    );
  }
}

class RequestedTile extends StatefulWidget {
  const RequestedTile({Key? key}) : super(key: key);

  @override
  State<RequestedTile> createState() => _RequestedTileState();
}

class _RequestedTileState extends State<RequestedTile> {

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
                : const Text("Cancel")
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
