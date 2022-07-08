import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  final String title;
  final String content;
  final String firstButtonName;
  final String secondButtonName;
  void Function()? firstButtonOnTap;
  void Function()? secondButtonOnTap;
  AlertScreen({ Key? key, required this.title, required this.content, required this.firstButtonName, required this.secondButtonName, this.firstButtonOnTap, this.secondButtonOnTap} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 28, 29, 77),
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 135, 212, 182),
            width: MediaQuery.of(context).size.width/4 + 10,
            child: Center(
              child: Text(
                firstButtonName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 28, 29, 77),
                  fontWeight: FontWeight.bold
                )
              )
            )
          ),
          onTap: firstButtonOnTap,
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 135, 212, 182),
            width: MediaQuery.of(context).size.width/4 + 10,
            child: Center(
              child: Text(
                secondButtonName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 28, 29, 77),
                  fontWeight: FontWeight.bold
                )
              )
            )
          ),
          onTap: secondButtonOnTap,
        ),
      ]
    );
  }
}