import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isButtonLiked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          contentPadding: EdgeInsets.only(left: 10),
          horizontalTitleGap: 4,
          dense: true,
          leading: CircleAvatar(backgroundColor: Colors.red, radius: 15),
          title: Text("Username")
        ),
        Container(
          color: Colors.amber,
          height:MediaQuery.of(context).size.width,
        ),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(isButtonLiked ? EvaIcons.heart : EvaIcons.heartOutline),
                    onPressed: () {
                      print("object");
                      setState(() {
                        if (isButtonLiked) {
                          isButtonLiked = false;
                        } else {
                          isButtonLiked = true;
                        }
                      });
                    },
                  ),
                  postActionTrayButton(
                    icon: Icons.comment_rounded,
                    onPressed:  () {}
                  ),
                ]
              )
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  postActionTrayButton(
                    icon: Icons.tag_sharp,
                    onPressed:  () {}
                  ),
                  postActionTrayButton(
                    icon: Icons.alternate_email_rounded,
                    onPressed:  () {
                      
                    }
                  ),
                ],
              )
            )
          ]
        )
      ]
    );
  }

  Widget postActionTrayButton({IconData? icon, VoidCallback? onPressed}) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        splashRadius: 23,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}