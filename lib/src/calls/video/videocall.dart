// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:gossip_frontend/protobuf/videocall/videocall.pb.dart';
import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoCall extends StatefulWidget {
  
  final int type;
  final String targetMid;
  final String initiaterMid;
  final String pollName;
  final VideoCallLogic? logic;
  const VideoCall(
    {
      Key? key, 
      this.logic,
      required this.type, 
      required this.targetMid, 
      required this.initiaterMid, 
      required this.pollName
    }

  ) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late VideoCallLogic videoCaller;
  late Widget call;
  bool isBig = false;
  bool isInitalized = false;
  String status = "Calling";

  initializer() {
    print("widget.type: ${widget.type}");
    // Initiator
    if (widget.type == 0) {
      // try {
        videoCaller = VideoCallLogic();
        // videoCaller.startVideoStreaming();
      //   videoCaller.connect(widget.type,
      //     "10.0.2.2", "8001", widget.initiaterMid, widget.targetMid, widget.pollName);
      //   videoCaller.listen();
      // } catch (e) {
      //   print(e);
      // }
    } 
    // Target
    else if (widget.type == 1) {
      // videoCaller.listen(widget.channel!);
      videoCaller = widget.logic!;
      
    }

    // call = StreamBuilder(
    //   stream: videoCaller.videoController.stream.asBroadcastStream(),
    //   builder: (context, snapshot) {
    //     return snapshot.hasData
    //         ? Image.memory(
    //             base64Decode(snapshot.data.toString()),
    //           )
    //         : Center(
    //             child: Text(status),
    //           );
    //   },
    // );

    videoCaller.uiController.stream.listen((event) {
      print("``````` New Ui Event: $event ```````````");
      if (event == 1) {
        setState(() => videoCaller.isLoading = false);
        videoCaller.startVideoStreaming();
      } else if (event == 11) {
        print("Executing type 11");
        setState(() {
          status = "Ringing";
        });
      } else if (event == 14) {
        print("Event 14");
        Navigator.pop(context);
      } else if (event == 15) {
        print("Event 15");
        Navigator.pop(context);
      } else if (event == 23) {
        print("Event 23");
        Navigator.pop(context);
      } else if (event == 24) {
        print("Event 24");
        Navigator.pop(context);
      }
    });

    // videoCaller.videoController.stream.listen((event) {
    //   print("Received Image Data: $event");
    // });

    isInitalized = true;
  }

  @override
  initState() {
    super.initState();
    if (!isInitalized) {
      initializer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoCaller.destroy();
  }

  @override
  Widget build(BuildContext context) {
    if (videoCaller.isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: const Color.fromARGB(255, 135, 212, 182),
              child: Column(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                      child: isBig
                          ? Material(
                              type: MaterialType.transparency,
                              child: Container(
                                color: Colors.red,
                                child: StreamBuilder(
                                  stream: videoCaller.callStreamer.stream.asBroadcastStream(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("has data");
                                      print(snapshot.data);
                                    }
                                    return snapshot.hasData
                                        ? Image.memory(
                                            Uint8List.fromList(snapshot.data.toString().codeUnits),
                                          )
                                        : Center(
                                            child: Text(status),
                                          );
                                  },
                                )
                                // child: Center(
                                //   child: Text(status),
                                // )
                              )
                            )
                          : CameraPreview(videoCaller.cameraController),
                      flex: 6),
                  const Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end, size: 40),
                  onPressed: () {
                    try {
                      CallNotifier notify = CallNotifier(
                        targetMid: widget.targetMid,
                        initiaterMid: widget.initiaterMid,
                        pollName: widget.pollName
                      );

                      Transport trans;

                      if (widget.type == 0) {
                        trans = Transport(
                          type: 24,
                          data: notify.writeToBuffer(),
                          mid: widget.initiaterMid
                        );
                      } else {
                        trans = Transport(
                          type: 15,
                          data: notify.writeToBuffer(),
                          mid: widget.initiaterMid
                        );
                      }
                      videoCaller.channel.sink.add(trans.writeToBuffer());
                      
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 170,
              right: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10.0),
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      child: Container(
                          width: 90,
                          height: 150,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: isBig
                                  ? const Color.fromARGB(255, 135, 212, 182)
                                  : Colors.redAccent),
                          // child: getChild(false, isSmall),
                          child: isBig
                              ? CameraPreview(videoCaller.cameraController)
                              : StreamBuilder(
                                  stream: videoCaller.callStreamer.stream.asBroadcastStream(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("has data");
                                      print(snapshot.data);
                                      print(Uint8List.fromList(snapshot.data.toString().codeUnits));
                                    }
                                    dynamic imageData = snapshot.data;
                                    return snapshot.hasData
                                        ? Image.memory(
                                            imageData,
                                          )
                                        : Center(
                                            child: Text(status),
                                          );
                                  },
                                )
                              // : null
                              ),
                      onTap: () {
                        setState(() {
                          if (isBig) {
                            isBig = false;
                          } else {
                            isBig = true;
                          }
                        });
                        print("Small Screen!");
                      },
                    )),
              ),
            ),
            Positioned(
                bottom: 90,
                left: 100,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 20),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(179, 245, 208, 159)),
                          child: Row(children: [
                            IconButton(
                                color: Colors.white,
                                icon: Icon(videoCaller.isMicOn
                                    ? Icons.mic_off_rounded
                                    : Icons.mic_rounded),
                                onPressed: () async {
                                  if (videoCaller.isMicOn) {
                                    setState(() {
                                      videoCaller.isMicOn = false;
                                    });
                                    // await videoCaller.startRecording();
                                  } else {
                                    setState(() {
                                      videoCaller.isMicOn = true;
                                    });
                                  }
                                }),
                            IconButton(
                                color: Colors.white,
                                icon: Icon(videoCaller.collectFrame
                                    ? Icons.emergency_recording_rounded
                                    : Icons.camera_outlined),
                                onPressed: () {
                                  if (videoCaller.collectFrame) {
                                    setState(() {
                                      videoCaller.collectFrame = false;
                                    });
                                    videoCaller.cameraController
                                        .stopImageStream();
                                    print(
                                        "======Video Streaming Stoped=======");
                                  } else {
                                    setState(() {
                                      videoCaller.collectFrame = true;
                                    });
                                    print(
                                        "=======Starting Video Streaming=======");
                                    // videoCaller.getFrames();
                                  }
                                }),
                            IconButton(
                                color: Colors.white,
                                icon: Icon(videoCaller.isBackCamera
                                    ? Icons.camera_rear_rounded
                                    : Icons.camera_front_rounded),
                                onPressed: () {
                                  if (videoCaller.isBackCamera) {
                                    setState(() {
                                      videoCaller.cameraInit(0);
                                      videoCaller.isBackCamera = false;
                                    });
                                  } else {
                                    setState(() {
                                      videoCaller.cameraInit(1);
                                      videoCaller.isBackCamera = true;
                                    });
                                  }
                                }),
                          ])),
                    )))
          ],
        ),
      );
    }
  }
}

class VideoCallLogic {
  late CameraController cameraController;
  late sound.FlutterSoundRecorder recordingSession;
  late StreamController<sound.Food> audioStreamController;
  late IOWebSocketChannel channel;
  late StreamController<Uint8List> callStreamer;

  late StreamController<int> uiController;
  late StreamController<int> callUiController;
  late StreamController<Uint8List> videoController;
  late StreamController<Uint8List> audioController;

  bool isLoading = true;
  bool isRecording = false;
  bool isBackCamera = false;
  bool isMicOn = true;
  bool collectFrame = false;
  bool cameraInitialised = false;

  VideoCallLogic() {
    cameraInit(0);
    audioStreamController = StreamController<sound.Food>();
    recordingSession = sound.FlutterSoundRecorder();
    callStreamer = StreamController<Uint8List>();
    uiController = StreamController<int>();
    callUiController = StreamController<int>();
    videoController = StreamController<Uint8List>();
    audioController = StreamController<Uint8List>();
    recordingSession.openRecorder();
  }

  Future<void> connect(int type, String host, String port, String initiaterMid, String targetMid, String? pollName) async {
    try {
      channel = IOWebSocketChannel.connect(
          Uri.parse('ws://' + host + ":" + port + "/"));
      NotifyPaylaod notify = NotifyPaylaod(
        targetMid: targetMid,
        initiaterMid: initiaterMid,
        pollName: pollName
      );
       
      Transport trans = Transport(
        type: type,
        mid: initiaterMid, 
        data: notify.writeToBuffer()
      );
      channel.sink.add(trans.writeToBuffer());
    } on SocketException {
      print("Unable To Connect To The Server!");
    } on WebSocketChannelException {
      print("error while connecting to the server");
    } catch (e) {
      print("Something went wrong while connecting to the server");
    }
  }

  listen() {
    channel.stream.asBroadcastStream().listen((data) {
      // proccess data
      Transport trans = Transport.fromBuffer(data);
      print("===========////// New Data ///////===========");
      print("Type: ${trans.type}");

      switch (trans.type) {
        // 11 : 1 -> Initiator, 1 -> Target has connected
        case 11:
          print("Run type nine");
          uiController.sink.add(11);
          break;
        // 12: 1 -> Initiator, 2 -> Start the video streaming
        case 12:
          startCallStream();
          break;
        // 13: 1 -> Initiator, 3 -> target's video and audio data
        case 1322:
          // Step1: collect the data
          CallPacket packet = CallPacket.fromBuffer(trans.data);
          // Step2: process the data
          // Not needed now...
          // Step3: put the data in streaming stream of video and audio
          if (packet.type == 0) {
            // push to audio stream
            audioController.sink.add(Uint8List.fromList(packet.data));
          } else if (packet.type == 1) {
            // push to video stream
            videoController.sink.add(Uint8List.fromList(packet.data));
          }
          break;
        // 14: 1 -> Initiator, 4 -> Target has refused to pick the call        
        case 14:
          uiController.sink.add(14);
          break;
        // 15: 1 -> Initiator, 5 -> Target has drop the call after pick up
        case 15:
          uiController.sink.add(15);
          break;
        // 21: 2 -> Target, 1 -> Start the video and audio streaming
        // case 21:
          
        //   startCallStream();
        //   break;
        // 22: 2 -> Target, 2 -> Initiator's video and audio data
        // case 22:
        //   CallPacket packet = CallPacket.fromBuffer(trans.data);
        //   // Step2: process the data
        //   // Not needed now...
        //   // Step3: put the data in streaming stream of video and audio
        //   if (packet.type == 0) {
        //     // push to audio stream
        //     audioController.sink.add(Uint8List.fromList(packet.data));
        //   } else if (packet.type == 1) {
        //     // push to video stream
        //     videoController.sink.add(Uint8List.fromList(packet.data));
        //   }
        //   break;
        // 23: 2 -> Target, 3 -> Initiator has drop the call before target picking up the call
        case 23:
          uiController.sink.add(23);
          callUiController.sink.add(23);
          // notifyt the ui
          break;
        // 24: 2 -> Target,  4 -> Initiator has drop the call after pick up
        case 24:
          uiController.sink.add(24);
          callUiController.sink.add(24);
          break;
        default:
      }
    });
  }

  Future<void> startCallStream() async {
    // combine both video and audio data <- Done, during previouse function call
    // Step1: start video streaming <- Done
    startVideoStreaming();
    // Step2: start audio streaming <- Done
    startAudioStreaming();
    // process it to be send to the server <- Done, do not need to do this step
    // send to the server using websocket channel <- Done
    callStreamer.stream.listen((event) {
      Transport trans = Transport(type: 1322, mid: "", data: event);
      channel.sink.add(trans.writeToBuffer());
    });
  }

  startVideoStreaming() async {
    cameraController.startImageStream((image) async {
      // print("Format: ${image.format.group.name} | ${image.format.raw}");
      // imglib.Image img = imglib.Image.fromBytes(
      //   image.width,
      //   image.height, 
      //   image.planes[0].bytes.sublist(0, image.planes[0].bytes.length-2),
      //   format: imglib.Format.rgb,
      //   channels: imglib.Channels.rgba
      // );
      // List<int> data = imglib.encodePng(img);
      // print("data length: ${data.length}");
      // Uint8List jpeg = Uint8List.fromList(data);
      // callStreamer.sink.add(jpeg);

      List<int> imageBytes = await convertImagetoPng(image);
      Uint8List imageBytesU8 = Uint8List.fromList(imageBytes);
      print("imagesBytesU8: $imageBytesU8");
      callStreamer.sink.add(imageBytesU8);

      // print("List<int> : $imageBytes");
      // print("Uint8List: ${Uint8List.fromList(imageBytes)}");

      // CallPacket packet = CallPacket(type: 1, data: imageBytes);

      // callStreamer.sink.add(Uint8List.fromList(imageBytes));
      // print(imageBytes.length);
    });
  }

  startAudioStreaming() async {
    await recordingSession.startRecorder(
        toStream: audioStreamController.sink, codec: sound.Codec.pcm16);
    audioStreamController.stream.listen((event) {
      if (event is sound.FoodData) {
        CallPacket packet = CallPacket(type: 0, data: event.data);
        callStreamer.sink.add(packet.writeToBuffer());
      }
    });
  }

  stopRecording() async {
    await recordingSession.stopRecorder();
    await recordingSession.closeRecorder();
    audioStreamController.close();
  }

  destroy() {
    try{
      channel.innerWebSocket!.close();
    } catch (e) {

    }
    cameraController.dispose();
    stopRecording();
  }

  cameraInit(int index) async {
    // index = 0 <- For front camera
    // index = 1 <- For back camera

    final cameras = await availableCameras();

    if (index == 0) {
      final front = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      cameraController = CameraController(front, ResolutionPreset.medium);
      await cameraController.initialize();
    } else if (index == 1) {
      final back = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      cameraController = CameraController(back, ResolutionPreset.medium);
      await cameraController.initialize();
    }
    uiController.sink.add(1);
  }

  Future<List<int>> convertImagetoPng(CameraImage image) async {
    try {
      late imglib.Image img;
      if (image.format.group == ImageFormatGroup.yuv420) {
        // img = _convertBGRA8888(image);
        img = _convertYUV420(image);
      } else if (image.format.group == ImageFormatGroup.bgra8888) {
        img = _convertBGRA8888(image);
      }

      imglib.PngEncoder pngEncoder = imglib.PngEncoder();

      // Convert to png
      List<int> jpeg = pngEncoder.encodeImage(img);
      // print("jpeg: $jpeg");
      return jpeg;
      // List<int> bytes = image.planes[0].bytes;
      // return bytes;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return [];
  }

  imglib.Image _convertYUV420(CameraImage image) {
    var img = imglib.Image(image.width, image.height); // Create Image buffer

    Plane plane = image.planes[0];
    const int shift = (0xFF << 24);

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < image.width; x++) {
      for (int planeOffset = 0;
          planeOffset < image.height * image.width;
          planeOffset += image.width) {
        final pixelColor = plane.bytes[planeOffset + x];
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        // Calculate pixel color
        var newVal =
            shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

        img.data[planeOffset + x] = newVal;
      }
    }

    return img;
  }

  imglib.Image _convertBGRA8888(CameraImage image) {
    return imglib.Image.fromBytes(
      image.width,
      image.height,
      image.planes[0].bytes,
      format: imglib.Format.bgra,
    );
  }
}

// 10 <- 1 - Initiator and 0 - Target connected to VCS



// 20 <- 2 - Target and 0 - 