import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MediaBoxDisplay extends StatefulWidget {
  const MediaBoxDisplay({Key? key}) : super(key: key);

  @override
  State<MediaBoxDisplay> createState() => _MediaBoxDisplayState();
}

class _MediaBoxDisplayState extends State<MediaBoxDisplay> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.amberAccent,
        alignment: Alignment.bottomLeft,
        child: const MediaBox()
      )
    );
  }
}


class MediaBox extends StatefulWidget {
  const MediaBox({Key? key}) : super(key: key);

  @override
  State<MediaBox> createState() => _MediaBoxState();
}

class _MediaBoxState extends State<MediaBox> {

  bool self = true;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Container(
    //     decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(25)),
    //       color: Color.fromARGB(255, 3, 209, 109),
    //     ),
    //     width: MediaQuery.of(context).size.width/1.7,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(25)),
    //           ),
    //           width: MediaQuery.of(context).size.width/1.8,
    //           height: MediaQuery.of(context).size.width/2,
    //           child: Padding(
    //             padding: const EdgeInsets.all(3.0),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(20),
    //               child: Image(
    //                 fit: BoxFit.cover,
    //                 image: AssetImage("assets/images/white.jpeg"),
    //               ),
    //             ),
    //           ),
    //         )
    //       ]
    //     )
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: false ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 7 / 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: self
                    ? const Radius.circular(0.0)
                    : const Radius.circular(10.0),
                bottomRight: false
                    ? Radius.circular(0.0)
                    : const Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              color: false
                ? Color.fromARGB(255, 135, 212, 182)
                : Color.fromARGB(255, 114, 153, 242),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/dst.jpg"),
                ),
              )
            )
          ),
        ),
      ),
    );
  }
}


