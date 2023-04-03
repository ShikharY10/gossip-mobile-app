import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vajra/vajra.dart';
import '../../../../apiCallers/caller.dart';
import '../../../../apiCallers/routes.dart';
import '../../../../database/config.dart';
import '../../../../database/models.dart';
import 'requested.dart';
import 'requests.dart';
import 'userpopups.dart';

class People extends StatefulWidget {
  const People({Key? key}) : super(key: key);

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  bool isSearchBarActive = false;
  bool isSearching = false;
  bool showSearchResult = false;

  late Future<List<dynamic>> futureResult;
  late List<dynamic> searchResult;

  late Vajra vajraClient;

  TextEditingController searchController = TextEditingController();
  late DataBase db;
  User myData = User();

  @override
  void initState() {
    super.initState();
    db = getDataBase();
    vajraClient = getVajra("client");

    String? mySavedData = db.get("userBox", "mydata");
    if (mySavedData != null) {
      myData.toObject(mySavedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 11, 27),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text("Partner",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Requests())
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text("${myData.partnerRequests!.length-1}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  )
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text("Requests",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )
                                    )
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Requested())
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50)
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text("${myData.yourPartnerRequests.length-1}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  )
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text("Your",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )
                                    )
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
              child: Container(
                height: 4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 255, 246, 167)),
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                    // suff
                    suffixIcon: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.search), 
                        onPressed: () {}
                      ),
                    ),
                    prefix: isSearching ? const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)),
                    ) : null,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 23, 23, 56),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: showSearchResult ? const Radius.circular(0) : const Radius.circular(20),
                        bottomRight:  showSearchResult ? const Radius.circular(0) : const Radius.circular(20)
                      )
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 136, 108, 55)),
                  ),
                  onChanged: (username) {
                    if (username.isNotEmpty) {
                      if (isSearching) {
                        futureResult.ignore();
                      }
                      futureResult = searchUsername(username);
                      futureResult.then((result) {
                        setState(() {
                          isSearching = false;
                          searchResult = result;
                          showSearchResult = true;
                        });
                      });
                    } else {
                      futureResult.ignore();
                      setState(() {
                        isSearching = false;
                        showSearchResult = false;
                      });
                    }
                  },
                )
              ),
            ),
            showSearchResult ? Padding(
              padding: const EdgeInsets.only(top: 1.0, bottom: 20),
              child: Container(
                height: MediaQuery.of(context).size.height-330,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 23, 23, 56),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
                child: ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PeopleTile(searchResult[index]["_id"], myData.token);
                  }
                )
              ),
            ) : const SizedBox()
          ]
        )
      )
    );
  }

  Future<Map<String, dynamic>> getUserDetails(String id) async {

    VajraResponse response = await vajraClient.get(
      "getuserdetails/$id",
      secured: true,
      sendCookie: true,
    );

    if (response.statusCode == 200) {
      return (response.body as Map<String, dynamic>);
    } else {
      return {};
    }
  }

  Future<List<dynamic>> searchUsername(String username) async {

    VajraResponse response = await vajraClient.get(
      "isusernameawailable",
      secured: true,
      sendCookie: true,
      queries: {"username": username}
    );

    if (response.statusCode == 200) {
      return (response.body as List<dynamic>);
    } else {
      return [];
    }
  }
}

class PeopleTile extends StatefulWidget {
  final String id;
  final String token;
  const PeopleTile(this.id, this.token, {Key? key}) : super(key: key);

  @override
  State<PeopleTile> createState() => _PeopleTileState();
}

class _PeopleTileState extends State<PeopleTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDetails(widget.id),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          Map<String, dynamic> data = (snapShot.data as Map<String, dynamic>);
          return Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                onTap: () {
                  showDialog(
                    context: context, 
                    builder: (context) => ShowUserDetails(data: data)
                  );
                },
                dense: true,
                minVerticalPadding: 0,
                title: Text(data["name"] ?? "unknown", 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )
                ),
                subtitle: Text(data["username"] ?? "unknown",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 68, 171, 255),
                  )
                ),
                // tileColor: Color.fromARGB(255, 153, 156, 168),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(data["avatar"]),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      }
    );
  }

  Future<Map<String, dynamic>> getUserDetails(String id) async {
    Vajra vajraClient = getVajra("client");
    VajraResponse response = await vajraClient.get(
      "getuserdetails/$id",
      secured: true,
      sendCookie: true,
    );

    if (response.statusCode == 200) {
      return (response.body as Map<String, dynamic>);
    } else {
      return {};
    }
  }
}