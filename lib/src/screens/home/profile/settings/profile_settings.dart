
import 'package:flutter/material.dart';
import 'package:vajra/vajra.dart';

import '../../../../../database/config.dart';
import '../../../../../database/models.dart';
import '../../../../../utility/widget/notice_dialog.dart';
import '../../../../../utility/widget/show_avatar.dart';

class ProfleSettings extends StatefulWidget {
  const ProfleSettings({Key? key}) : super(key: key);

  @override
  State<ProfleSettings> createState() => _ProfleSettingsState();
}

class _ProfleSettingsState extends State<ProfleSettings> {

  late DataBase db;
  late Vajra vajraAuthClient;
  User myData = User();

  bool showError = false;
  String errorMsg = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  bool editingUsername = false;
  bool editingName = false;
  bool editingAvatar = false;

  @override
  void initState() {
    super.initState();
    
    db = getDataBase();
    vajraAuthClient = getVajra("auth");

    String? myStrData = db.get("userBox", "mydata");
    if (myStrData != null) {
      myData.toObject(myStrData);
    }
    
    nameController.text = myData.name;
    usernameController.text = myData.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      body: Stack(
        children: [
          ListView(
            children: [

              Stack(
                alignment: Alignment.center,
                children: [
                  ShowProfilePicture(
                    myData.id,
                    radius: 80,
                  ),
                  // const CircleAvatar(
                  //   backgroundColor: Colors.grey,
                  //   radius: 80,
                  // ),
                  Positioned(
                    bottom: 1,
                    right: MediaQuery.of(context).size.width/3.2,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black
                        ),
                        onPressed: () {},
                      )
                    ),
                  )
                ],
              ),


              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("name",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    editingName 
                    ? SizedBox(
                      height: 40,
                      child: TextFormField(
                        autofocus: true,
                        controller: nameController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Color.fromRGBO(28, 29, 77, 1),
                          border: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                    : Text(nameController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ],
                ),
                trailing: editingName
                ? TrailingEditButton(
                  onCancel: () {
                    setState(() {
                      editingName = false;
                    });
                  },
                  onSubmitValidator: () {
                    return !(nameController.text == myData.username);
                  },
                  onSubmit: () async {

                    setState(() {
                      editingAvatar = false;
                      editingUsername = false;
                      editingName = true;
                    });

                    VajraResponse response = await vajraAuthClient.put(
                      "/updatename",
                      {"fullname": nameController.text},
                      secured: true,
                      sendCookie: true,
                    );
                    
                    if (response.statusCode == 200) {
                      myData.name = nameController.text;

                      db.set("userBox", "mydata", myData.toString());
                    } else {
                      setState(() {
                        nameController.text = myData.name;
                        errorMsg = response.errorMessage;
                        showError = true;
                      });
                    }

                    setState(() {
                      editingName = false;
                    });
                  },
                  showProgressIndicator: true
                )
                : IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      editingName = true;
                    });
                  },
                ),
                horizontalTitleGap: 10,
              ),

              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("username",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    editingUsername 
                    ? SizedBox(
                      height: 40,
                      child: TextFormField(
                        autofocus: true,
                        controller: usernameController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Color.fromRGBO(28, 29, 77, 1),
                          border: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide.none,
                            // borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                      ),
                    )
                    : Text(usernameController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ],
                ),
                trailing: editingUsername
                ? TrailingEditButton(
                  onCancel: () {
                    setState(() {
                      editingUsername = false;
                    });
                  },
                  onSubmitValidator: () {
                    return (usernameController.text == myData.username);
                  },
                  onSubmit: () {
                    setState(() {
                      editingUsername = true;
                    });
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        editingUsername = false;
                      });
                    });
                  },

                  showProgressIndicator: true
                )
                : IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      editingUsername = true;
                    });
                  },
                ),
                horizontalTitleGap: 10,
              ),
            ],
          ),
          NoticeDialog(
            showError,
            errorMsg,
            MediaQuery.of(context).size.width-20,
            onCloseBtnPressed: () {
              setState(() {
                showError = false;
              });
            },
          )
        ],
      ),
    );
  }
}

class TrailingEditButton extends StatefulWidget {
  final void Function() onCancel;
  final void Function() onSubmit;
  final bool Function() onSubmitValidator;
  final bool showProgressIndicator;
  const TrailingEditButton({Key? key, required this.onCancel, required this.onSubmit, required this.onSubmitValidator, required this.showProgressIndicator}) : super(key: key);

  @override
  State<TrailingEditButton> createState() => _TrailingEditButtonState();
}

class _TrailingEditButtonState extends State<TrailingEditButton> {
  bool editingStarted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: 100,
        height: 40,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(18, 18, 57, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  splashRadius: 20,
                  iconSize: 25,
                  color: Colors.white,
                  icon: const Icon(Icons.cancel),
                  onPressed: widget.onCancel,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: editingStarted 
              ? widget.showProgressIndicator 
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.green
                      )
                    ),
                  ],
                )
                : const SizedBox()
              : Material(
                type: MaterialType.transparency,
                child: IconButton(
                  splashRadius: 20,
                  color: Colors.green,
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    if (widget.onSubmitValidator()) {
                      setState(() {
                        editingStarted = true;
                      });
                    widget.onSubmit();
                    }                  
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}