import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:ui' as ui;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class EditPhoto extends StatefulWidget {
  const EditPhoto({Key? key}) : super(key: key);

  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {

  Offset position = Offset.zero;

  int? photoWidth;

  String originalPhotoPath = "";

  bool isPhotoSelected = false;
  String selectedPhotoPath = "";
  late Uint8List selectedPhoto;

  bool isEditing = false;

  bool isFitting = false;
  bool isFilling = false;
  bool isSquaring = false;

  Color selectedColor = Colors.white;

  final GlobalKey globalKey = GlobalKey();

  BoxFit boxFit = BoxFit.fitHeight;

  toImage() async {
    final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final file = await File(resolveUrl("${DateTime.now().microsecondsSinceEpoch}", selectedPhotoPath)).create(recursive: true);
      await file.writeAsBytes(pngBytes.buffer.asUint8List());
    
      setState(() {
        selectedPhotoPath = file.path;
        selectedPhoto = pngBytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 11, 27),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 11, 27),
        title: isEditing 
        ? const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Color.fromARGB(255, 11, 11, 27)
            )
          )
        : const Text("Edit Photo"),
         actions: [
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 14, right: 14),
            child: InkWell(
              onTap: () async {
                setState(() {
                  isEditing = true;
                });

                await toImage();

                setState(() {
                  isEditing = false;
                });

                Navigator.pop(context, selectedPhotoPath);
              },
              child: Container(
                width: 70,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check,
                  color: Color.fromARGB(255, 11, 11, 27)
                )
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RepaintBoundary(
              key: globalKey,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    // border: Border.all(
                    //   color: Colors.white,
                    //   width: 2,
                    // )
                  ),
                  child: isPhotoSelected 
                  ? Image.memory(
                    selectedPhoto,
                    fit: boxFit,
                    filterQuality: FilterQuality.high
                  ) 
                  : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: IconButton(
                              splashRadius: 24,
                              splashColor: Colors.black,
                              color: Colors.black,
                              iconSize: 30,
                              icon: const Icon(Icons.add_photo_alternate_rounded),
                              onPressed: () async {
                                OpenFileDialogParams params = const OpenFileDialogParams(
                                  dialogType: OpenFileDialogType.image,
                                  sourceType: SourceType.photoLibrary,
                                );
                                final String? filePath = await FlutterFileDialog.pickFile(params: params);
                                if (filePath != null) {
                                  Uint8List photoBytes = await File(filePath).readAsBytes();
                                  setState(() {
                                    originalPhotoPath = filePath;
                                    selectedPhotoPath = filePath;
                                    selectedPhoto = photoBytes;
                                    isPhotoSelected = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Select Photo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          isFilling = false;
                          boxFit = BoxFit.cover;
                        });
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: const Text(
                          "Fit",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                    ),
                  )
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          isFilling = true;
                          boxFit = BoxFit.fitHeight;  
                        });
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: const Text(
                          "Fill",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                    ),
                  )
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: ()async  {
                        setState(() {
                          isFilling = false;
                          boxFit = BoxFit.fill;  
                        });
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child:  const Text(
                            "Square",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          )
                      ),
                    ),
                  )
                )
              ]
            ),
          ),
          
          
          isFilling ? Padding(
            padding: const EdgeInsets.all(0.0),
            child: ColorPicker(
                pickerColor: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                pickerAreaHeightPercent: 0.8,
              ),
          ) : const SizedBox(),
          
        ]
      )
    );
  }

  Future<Uint8List?> generateImage(Uint8List source, Color color) async {
    final sourceImage = await decodeImageFromList(source);
    // Create a new image with a red background
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset.zero, Offset(sourceImage.height.toDouble(), sourceImage.height.toDouble())));
    canvas.drawColor(color, BlendMode.color);

    (sourceImage.height - sourceImage.width)/2;
    canvas.drawImage(sourceImage, Offset((sourceImage.height - sourceImage.width)/2, 0), Paint());
    
    final picture = recorder.endRecording();
    final image = await picture.toImage(sourceImage.height, sourceImage.height);

    // Save the image to a file
    final pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);

    if (pngBytes != null) {
      return pngBytes.buffer.asUint8List();
    }
    return null;
  }

  Future<void> fillImage(String source, Color color) async {
    // Load the source image from a file
    final sourceData = await File(source).readAsBytes();
    final sourceImage = await decodeImageFromList(sourceData);

    // Create a new image with the desired dimensions
    final newWidth = sourceImage.height;
    final newHeight = sourceImage.height;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset.zero, Offset(newWidth.toDouble(), newHeight.toDouble())));

    // Draw the source image onto the new canvas
    final srcRect = Rect.fromLTWH((sourceImage.height - sourceImage.width)/2, 0, sourceImage.width.toDouble(), sourceImage.height.toDouble());
    final dstRect = Rect.fromLTWH(0, 0, newWidth.toDouble(), newHeight.toDouble());
    canvas.drawImageRect(sourceImage, srcRect, dstRect, Paint());

    // Fill the remaining area with red color
    final remainingRect = Rect.fromLTWH(sourceImage.width.toDouble(), 0, newWidth.toDouble() - sourceImage.width.toDouble(), newHeight.toDouble());
    canvas.drawRect(remainingRect, Paint()..color = color);

    // Convert the new canvas to a PNG byte data representation
    final picture = recorder.endRecording();
    final newImage = await picture.toImage(newWidth, newHeight);
    final pngBytes = await newImage.toByteData(format: ui.ImageByteFormat.png);

    if (pngBytes != null) {
      selectedPhoto = pngBytes.buffer.asUint8List();

      final file = await File(resolveUrl("fill", source)).create(recursive: true);
      await file.writeAsBytes(pngBytes.buffer.asUint8List());
      selectedPhotoPath = file.path;
    }  
  }

  Future<void> squareImage(String source, Color color) async {
    // Load the source image from a file
    final sourceData = await File(source).readAsBytes();
    final sourceImage = await decodeImageFromList(sourceData);

    // Create a new image with the desired dimensions
    final newWidth = sourceImage.height;
    final newHeight = sourceImage.height;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset.zero, Offset(newWidth.toDouble(), newHeight.toDouble())));

    // Draw the source image onto the new canvas
    final srcRect = Rect.fromLTWH(0, 0, sourceImage.width.toDouble(), sourceImage.height.toDouble());
    final dstRect = Rect.fromLTWH(0, 0, newWidth.toDouble(), newHeight.toDouble());
    canvas.drawImageRect(sourceImage, srcRect, dstRect, Paint());

    // Fill the remaining area with red color
    final remainingRect = Rect.fromLTWH(sourceImage.width.toDouble(), 0, newWidth.toDouble() - sourceImage.width.toDouble(), newHeight.toDouble());
    canvas.drawRect(remainingRect, Paint()..color = color);

    // Convert the new canvas to a PNG byte data representation
    final picture = recorder.endRecording();
    final newImage = await picture.toImage(newWidth, newHeight);
    final pngBytes = await newImage.toByteData(format: ui.ImageByteFormat.png);

    if (pngBytes != null) {
      selectedPhoto = pngBytes.buffer.asUint8List();

      final file = await File(resolveUrl("square", source)).create(recursive: true);
      await file.writeAsBytes(pngBytes.buffer.asUint8List());
      selectedPhotoPath = file.path;
    }  
  }

  String resolveUrl(String name, String path) {
    List<String> splited = path.split("");
    List<int> removeIndex = [];

    for (int i=splited.length-1; i<=0; i--) {
      if (splited[i] != ".") {
        removeIndex.add(i);
      } else if (splited[i] == ".") {
        removeIndex.add(i);
        break;
      }
    }

    for (int index in removeIndex) {
      splited.removeAt(index);
    }

    splited.add("_$name.png");

    return splited.join("");
  }
}