import 'package:flutter/material.dart';

import '../../../../../utility/widget/notice_dialog.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool showError = false;
  String errorMsg = "error";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings"),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      body: Stack(
        children: [
          ListView(
            children: [
              const ListTile(
                title: Text("Logout")
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 161, 19),
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 1,
                  color: Colors.black
                ),
              ),

              // Delete account
              const ListTile(
                title: Text("Delete Account")
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 17, 0),
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 1,
                  color: Colors.black
                ),
              )
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