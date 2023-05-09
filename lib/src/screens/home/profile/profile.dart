import 'package:flutter/material.dart';
import '../../../../database/config.dart';
import '../../../../database/models.dart';
import 'settings/settings.dart';
import '../../../../utility/widget/show_avatar.dart';

class Profile extends StatefulWidget {
  final String? id;
  final bool self;
  const Profile({this.id, this.self = true, Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  User myData = User();
  late DataBase db;

  String _name = "unkown";
  String _username = "unkown";
  String _id = "";
  List<String> _posts = [];
  List<String> _partners = [];
  int _partnersCount = 0;

  void allotSelfData() {
    String? myStrData = db.get("userBox", "mydata");
    if (myStrData != null) {
      myData.toObject(myStrData);
      _name = myData.name;
      _username = myData.username;
      _id = myData.id;
      _posts = myData.posts;
      _partners = myData.partners;
      _partnersCount = myData.partners.length-1;
    }
  }

  void allotPartnerData() {
    Partner partner;

    String? savedPartnerDetails = db.get("userBox", "partner.${widget.id}");
    if (savedPartnerDetails != null) {
      partner = Partner.toObject(savedPartnerDetails);
        _name = partner.name;
        _username = partner.username;
        _id = widget.id ?? "";
        _posts = partner.posts;
        _partnersCount = partner.partners;
    }
  }

  @override
  void initState() {
    super.initState();
    db = getDataBase();

    if (widget.self) {
      allotSelfData();
    } else {
      allotPartnerData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color.fromARGB(255, 11, 11, 27),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("Profile",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      )
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          borderOnForeground: false,
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          child: IconButton(
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            splashColor: Colors.pink,
                            color: Colors.white,
                            icon: const Icon(Icons.settings),
                            onPressed: () {
                              if (widget.self) {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => const Setting()
                                  )
                                );
                              } else {
                                // TODO: implement and create route of partner setting page.
                              }
                            },
                          ),
                        )
                      ]
                    )
                  )
                ]
              ),
              Material(
                shadowColor: const Color.fromARGB(255, 49, 145, 209),
                elevation: 5.0,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.1,
                        0.9,
                      ],
                      colors: [
                        Color.fromARGB(255, 231, 62, 118),
                        Color.fromARGB(255, 39, 57, 223),
                      ],
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ShowProfilePicture(
                              _id,
                              minRadius: 30,
                              maxRadius: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _name,
                                      style: const TextStyle(
                                        letterSpacing: 0.8,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900
                                      )
                                    ),
                                    Text(_username),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Column(
                                              children: [
                                                Text("$_partnersCount", 
                                                  style: const TextStyle(
                                                    color: Colors.black, 
                                                    fontWeight: FontWeight.bold, 
                                                  )
                                                ),
                                                const Text("Partner",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600
                                                  )
                                                )
                                              ]
                                            ),
                                          ),
                                        ]
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white
                  ),
                ),
              ),
              for (int i = 0; i < 5; i++)
                Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/1.2,
                  constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).size.width/1.2)/2-10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                        )
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                        )
                      ),
                    ],
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}