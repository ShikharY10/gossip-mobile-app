import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../../../database/hive_handler.dart';
import '../../../protobuf/videocall/videocall.pbserver.dart';
import 'videocall.dart';

class VideoCallController extends StatefulWidget {
  final CallNotifier notifier;
  final Connection conn;
  const VideoCallController({Key? key, required this.notifier, required this.conn}) : super(key: key);

  @override
  State<VideoCallController> createState() => _VideoCallControllerState();
}

class _VideoCallControllerState extends State<VideoCallController> {

  late Timer timer;
  late VideoCallLogic logic;

  @override
  initState() {
    super.initState();

    logic = VideoCallLogic();
    logic.connect(
      1, 
      "10.0.2.2", 
      "8001", 
      widget.notifier.initiaterMid, 
      widget.notifier.targetMid, 
      widget.notifier.pollName
    );
    logic.listen();

    logic.callUiController.stream.listen((event) {
      if (event == 23 || event == 24) {
        timer.cancel();
        FlutterRingtonePlayer.stop();
        Navigator.pop(context);
      }
    });

    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );

    timer = Timer(const Duration(seconds: 30), () {
      FlutterRingtonePlayer.stop();
      print("Exiting...1");
      try {
        logic.channel.innerWebSocket!.close();
      } catch (e) {
        print("Already closed1");
      }
      
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 28, 29, 77)),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(children: [
              CircleAvatar(
                backgroundImage: MemoryImage(base64.decode(widget.conn.profilepic)), //AssetImage("assets/images/white.jpeg"), /
                radius: 50,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.conn.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 135, 212, 182)
                          )
                        ),
                      ),
                      Text(widget.conn.mnum)
                    ]
                  ),
                )
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 135, 212, 182),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Text(
                        "Video Call",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 28, 29, 77)
                        )
                      ),
                    ),
                  )
                )
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.call_rounded, 
                              color: Colors.black, 
                              size: 30
                            ),
                            onPressed: () {
                              timer.cancel();
                              FlutterRingtonePlayer.stop();
                              // =================If target user has picked the call=================
                              CallNotifier notify = CallNotifier(
                                initiaterMid: widget.notifier.initiaterMid,
                                targetMid: widget.notifier.targetMid,
                                pollName: widget.notifier.pollName
                              );

                              Transport trans = Transport(
                                type: 12,
                                data: notify.writeToBuffer(),
                                mid: widget.notifier.initiaterMid,
                              );

                              logic.channel.sink.add(trans.writeToBuffer());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => VideoCall(
                                    logic: logic,
                                    type: 1, 
                                    targetMid: widget.notifier.initiaterMid, 
                                    initiaterMid: widget.notifier.targetMid,
                                    pollName: widget.notifier.pollName
                                  )
                                )
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.call_end_rounded, 
                              color: Colors.black, 
                              size: 30
                            ),
                            onPressed: () {
                              timer.cancel();
                              FlutterRingtonePlayer.stop();
                              CallNotifier notify = CallNotifier(
                                initiaterMid: widget.notifier.initiaterMid,
                                targetMid: widget.notifier.targetMid,
                                pollName: widget.notifier.pollName
                              );

                              Transport trans = Transport(
                                type: 14,
                                data: notify.writeToBuffer(),
                                mid: widget.notifier.initiaterMid,
                              );

                              logic.channel.sink.add(trans.writeToBuffer());
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ]
                )
              )
              
            ]),
          )),
    );
  }
}
