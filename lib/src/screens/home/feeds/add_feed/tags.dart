import 'package:flutter/material.dart';
import '../../../../../broker/broker.dart';
import 'dart:math' as math;


class AddTags extends StatefulWidget {
  final double width;
  const AddTags(this.width, {Key? key}) : super(key: key);

  @override
  State<AddTags> createState() => _AddTagsState();
}

class _AddTagsState extends State<AddTags> {
  final List<String> _tags = [];

  late Broker broker;

  listenForBrokerEvent() {
    broker.listen("addNewPost.tags", (event) {
      Protocol protocol = (event as Protocol);
      if (protocol.publisher == "addNewPost.tags.add") {
        setState(() {
          _tags.add(protocol.data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    broker = getBroker();
    broker.register("addNewPost.tags");

    listenForBrokerEvent();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all((_tags.isNotEmpty ? 10.0: 0)),
      child: SizedBox(
        width: widget.width,
        child: (_tags.isNotEmpty) ? Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (int i=0; i< _tags.length; i++)
              Container(
                height: 20,
                width: _calcTextSize(_tags[i], const TextStyle(fontSize: 14)).width + 30 + 20,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 29, 29, 72),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Center(
                          child: Text("#${_tags[i]}",
                            style: const TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            _tags.removeAt(i);
                            broker.publish("addNewPost.tags.remove", "addNewPost", i);
                            setState(() {});
                          },
                          child: Container(
                          
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)
                            ),
                          ),
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 20,
                              ),
                          ),
                                            ),
                        )
                        
                      )
                      
                    ],
                  ),
                )
              )
          ]
        ) : null,
      ),
    );
  }

  Size _calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }
}