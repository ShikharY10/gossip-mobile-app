import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/github.dart';
import '../../../../../broker/broker.dart';
import 'edit_photo.dart';
import 'tags.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:google_fonts/google_fonts.dart';

class AddNewFeed extends StatefulWidget {
  const AddNewFeed({Key? key}) : super(key: key);

  @override
  State<AddNewFeed> createState() => _AddNewFeedState();
}

class _AddNewFeedState extends State<AddNewFeed> {

  late Broker broker;

  int textBoxIndex = -1;
  bool enablePostBtn = false;

  bool picSelected = false;
  String profilPicPath = "";
  String imageExt = "";
  String b64Image = "";

  TextEditingController captionController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController mentionController = TextEditingController();

  final List<String> _tags = [];

  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  listenForBrokerEvent() {
    broker.listen("addNewPost", (event) {
      Protocol protocol = (event as Protocol);
      if (protocol.publisher == "addNewPost.tags.remove") {
        _tags.removeAt((protocol.data as int));
        print("_tags: $_tags");

        if (captionController.text.isNotEmpty || _tags.isNotEmpty) {
          setState(() {
            enablePostBtn = true;
          });
        } else {
          setState(() {
            enablePostBtn = false;
          });
        }
      }
    });
  }

  Future<void> selectPostPhoto() async {
    Future<dynamic> futureSelectedPhotoPath = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditPhoto()
      )
    );
    futureSelectedPhotoPath.then((selectedPhotoPath) {
      setState(() {
        profilPicPath = (selectedPhotoPath as String);
        picSelected = true;
      });

      if (key.currentState != null) {
        if (key.currentState!.controller != null) {
          if (key.currentState!.controller!.text.isNotEmpty || picSelected) {
            setState(() {
              enablePostBtn = true;
            });
          } else {
            setState(() {
              enablePostBtn = false;
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    broker = getBroker();
    broker.register("addNewPost");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          if (textBoxIndex == 0) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          }
        },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 11, 27),
        appBar: AppBar(
          title: const Text("Add New Post"),
          backgroundColor: const Color.fromARGB(255, 11, 11, 27),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14, right: 14),
              child: InkWell(
                onTap: () {
                  if (enablePostBtn) {
                    addNewPost();
                  }
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: enablePostBtn ? Colors.blue : const Color.fromARGB(131, 33, 149, 243),
                    borderRadius: const BorderRadius.all(Radius.circular(50))
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 11, 11, 27),
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            !picSelected ? ListTile(
              leading:  const Icon(
                Icons.image,
                color: Colors.white,
              ),
              horizontalTitleGap: picSelected ? 5 : 0,
              onTap: () async {
                await selectPostPhoto();
              },
            ) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(File(profilPicPath)))
                      )
                    ),
                    Positioned(
                      top: 1,
                      right: 1,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(141, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: IconButton(
                            splashRadius: 24,
                            icon: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await selectPostPhoto();
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 95, 95, 95),
              height: 1,
              width: MediaQuery.of(context).size.width
            ),
        
            // add caption
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Icon(
                    Icons.text_snippet,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30-24,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0, top: 10, bottom: 10),
                    child: FlutterMentions(
                      key: key,
                      suggestionListDecoration: const BoxDecoration(
                        color: Color.fromARGB(255, 25, 25, 43),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      suggestionPosition: SuggestionPosition.Top,
                      minLines: 2,
                      maxLines: 10,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                      ),
                      decoration: const InputDecoration(
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Color.fromARGB(255, 11, 11, 27),
                        border: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Caption",
                        hintStyle: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      onTap: () {
                        textBoxIndex = 0;
                      },
                      onChanged: (caption) {
                        if (caption.isNotEmpty || picSelected) {
                          setState(() {
                            enablePostBtn = true;
                          });
                        } else {
                          setState(() {
                            enablePostBtn = false;
                          });
                        }
                      },
                      mentions: [
                        Mention(
                          disableMarkup: false,
                          trigger: "@",
                          style: const TextStyle(color: Colors.purple),
                          data: [
                            {
                              "id": "61as61fsa",
                              "display": "fayeedP",
                              "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"
                            },
                            {
                              "id": "61asasgasgsag6a",
                              "display": "khaled",
                              "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                            },
                            {
                              "id": "61asasgasgsag6a",
                              "display": "shikhar",
                              "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                            },
                            {
                              "id": "61asasgasgsag6a",
                              "display": "tushar",
                              "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                            },
                          ],
                          suggestionBuilder: (data) {
                            return ListTile(
                              dense: true,
                              leading:  const CircleAvatar(
                                backgroundColor: Colors.grey,
                                // backgroundImage: Image.network(data[""]),
                              ),
                              title: Text(
                                data["display"],
                                style: const TextStyle(
                                  color: Colors.white
                                )
                              ),
                              subtitle: Text(
                                data["id"],
                                style: const TextStyle(
                                  color: Colors.grey
                                )
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            Container(
              color: const Color.fromARGB(255, 95, 95, 95),
              height: 1,
              width: MediaQuery.of(context).size.width
            ),
        
            AddTags(MediaQuery.of(context).size.width/1.1),
        
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Icon(
                    Icons.tag_sharp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30-24,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 11, 11, 27),
                        border: const OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Tags",
                        hintStyle: const TextStyle(
                          color: Colors.grey
                        ),
                        suffixIcon: InkWell(
                          child: const Icon(Icons.check),
                          onTap: () {
                            String tag = tagController.text;
                            if (tag.isNotEmpty) {
                              _tags.add(tag);
                              print("Tags: $tag");
                              broker.publish("addNewPost.tags.add", "addNewPost.tags", tag);
                              tagController.clear();
                            }
                            
                          },
                        ),                          
                      ),
                      controller: tagController,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      onTap: () {
                        textBoxIndex = 1;
                      },
                    ),
                  ),
                ),
              ],
            ),
        
            Container(
              color: const Color.fromARGB(255, 95, 95, 95),
              height: 1,
              width: MediaQuery.of(context).size.width
            ),
        
          ],
        )
      ),
    );
  }

  Future<String?> readImage() async {
    OpenFileDialogParams params = const OpenFileDialogParams(
      dialogType: OpenFileDialogType.image,
      sourceType: SourceType.photoLibrary,
    );
    final String? filePath = await FlutterFileDialog.pickFile(params: params);
    return filePath;
  }

  addNewPost() {
    print("add new post");
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}



