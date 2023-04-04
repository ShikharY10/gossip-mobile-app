import 'package:flutter/material.dart';

import '../../../../../utility/widget/notice_dialog.dart';
import 'account_settings.dart';
import 'profile_settings.dart';
import 'security_settings.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  bool showError = false;
  String errorMsg = "error";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.people,
                  size: 30,
                  color: Colors.white
                ),
                title: const Text("Profile",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const ProfleSettings()
                    )
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.security,
                  size: 30,
                  color: Colors.white
                ),
                title: const Text("Security",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const SecuritySettings()
                    )
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  size: 30,
                  color: Colors.white
                ),
                title: const Text("Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const AccountSettings()
                    )
                  );
                },
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

