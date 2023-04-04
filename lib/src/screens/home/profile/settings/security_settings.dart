import 'package:flutter/material.dart';
import 'package:vajra/vajra.dart';

import '../../../../../database/config.dart';
import '../../../../../database/models.dart';
import '../../../../../utility/widget/notice_dialog.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({Key? key}) : super(key: key);

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool showNotice = false;
  String noticeMsg = "notice";

  bool isError = false;
  bool isWarning = false;
  bool isSuccess = true;

  bool isRefreshingAccessToken = false;

  late DataBase db;
  late Vajra vajraAuthClient;
  User myData = User();

  @override
  void initState() {
    super.initState();
    
    db = getDataBase();
    vajraAuthClient = getVajra("auth");

    String? myStrData = db.get("userBox", "mydata");
    if (myStrData != null) {
      myData.toObject(myStrData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Settings"),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(
                title: const Text(
                  "Refresh Access Token",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                trailing: isRefreshingAccessToken ? const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  )
                ) : null,
                onTap: () async {
                  setState(() {
                    isRefreshingAccessToken = true;
                  });

                  Vajra vajraAuthCliet = getVajra("auth");
                  VajraResponse response = await vajraAuthCliet.put(
                    "/refreshaccesstoken/${myData.id}",
                    {},
                    sendCookie: true,
                    expectAuthorization: true
                  );

                  if (response.statusCode == 200) {
                    Map<String, dynamic> responseBody = (response.body as Map<String, dynamic>);
                    myData.token = responseBody["accessToken"];
                    db.set("userBox", "mydata", myData.toString());

                    

                    setState(() {
                      showNotice = true;
                      noticeMsg = "Access token refreshed";
                      isSuccess = true;
                      isError = false;
                    });

                  } else {
                    setState(() {
                      showNotice = true;
                      noticeMsg = response.errorMessage;
                      isSuccess = false;
                      isError = true;
                    });
                  }

                  Future.delayed(const Duration(seconds: 15), () {
                    if (context.mounted) {
                      setState(() {
                        showNotice = false;
                      });
                    }
                  });
                  setState(() {
                    isRefreshingAccessToken = false;
                  });
                },
              ),
            ],
          ),
          NoticeDialog(
            showNotice,
            noticeMsg,
            MediaQuery.of(context).size.width-20,
            isError: isError,
            isWarning: isWarning,
            isSuccess: isSuccess,
            onCloseBtnPressed: () {
              setState(() {
                showNotice = false;
              });
            },
          )
        ],
      ),
    );
  }
}