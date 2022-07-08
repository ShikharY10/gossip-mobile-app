import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final Uint8List imageData;
  final String name;
  const ImagePreview({ Key? key, required this.imageData, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("image size: ${imageData.length}");
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          type: MaterialType.transparency,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left,
              color: Color.fromARGB(255, 28, 29, 77),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
        backgroundColor: Color.fromARGB(255, 135, 212, 182),
        title: Text(name, style: TextStyle(color: Color.fromARGB(255, 28, 29, 77)),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black
            )
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(imageData),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black
            )
          ),
        ],
      ),
    );
  }
}