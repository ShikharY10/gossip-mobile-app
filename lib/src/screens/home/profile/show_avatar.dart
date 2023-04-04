import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:vajra/vajra.dart';

import '../../../../database/config.dart';

class ShowProfilePicture extends StatefulWidget {
  final String id;
  final double? radius;
  final double? maxRadius;
  final double? minRadius;
  const ShowProfilePicture(this.id, {this.radius, this.maxRadius, this.minRadius, Key? key}) : super(key: key);

  @override
  State<ShowProfilePicture> createState() => _ShowProfilePictureState();
}

class _ShowProfilePictureState extends State<ShowProfilePicture> {

  late DataBase db;
  late Vajra vajraClient;

  bool isImageLoaded = false;
  bool fetchingImage = false;

  Uint8List? imageData;

  loadImageFromServer() async {
    setState(() {
      fetchingImage = true;
    });

    try {
      VajraResponse response = await vajraClient.get(
        "/getuseravatar/${widget.id}",
        secured: true,
        sendCookie: true,
        queries: {
          "width": "200",
          "height": "200",
          "scale": "0.70"
        },
      );

      setState(() {
        fetchingImage = false;
      });
      
      print("statusCode: ${response.statusCode}");
      print("errorMsg: ${response.errorMessage}");

      if (response.statusCode == 200) {
        db.set("imageBox", "user.profilepic.${widget.id}", String.fromCharCodes(response.body));
        imageData = response.body;
        setState(() {
          isImageLoaded = true;
        });
      } else if (response.statusCode == 401) {
        if ((response.body as Map<String, String>)["reason"] == "access-token-expire") {
          // Step1: refresh the access token
          // Step2: Call loadImageFromServer again
        }
      }
    } catch (e) {
      setState(() {
        isImageLoaded = false;
      });
    }

    // try {
    //   Future<http.Response> futureResponse = Caller.getCall(routes.getavatar("${widget.id}?width=200&height=200&scale=0.70"));
    //   futureResponse.then((response) {
    //     if (response.statusCode == 200) {
    //       db.set("imageBox", "user.profilepic.${widget.id}", String.fromCharCodes(response.bodyBytes));
    //       imageData = response.bodyBytes;
    //       setState(() {
    //         isImageLoaded = true;
    //       });
    //     }
    //   });
    // } catch (e) {
    //   setState(() {
    //     isImageLoaded = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    db = getDataBase();
    vajraClient = getVajra("client");

    String key = "user.profilepic.${widget.id}";
    String? savedImageData = db.get("imageBox",key);
    if (savedImageData != null) {
      imageData = Uint8List.fromList(savedImageData.codeUnits);
      isImageLoaded = true;
    } else {
      loadImageFromServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isImageLoaded ? null : Colors.grey,
      backgroundImage: (imageData != null) ? MemoryImage(imageData!) : null,
      radius: widget.radius,
      minRadius: widget.minRadius,
      maxRadius: widget.maxRadius,
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        child: fetchingImage ? const CircularProgressIndicator(): null
      ),
    );
  }
}