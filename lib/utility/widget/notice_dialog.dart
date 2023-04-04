import 'package:flutter/material.dart';

class NoticeDialog extends StatefulWidget {
  final bool isError;
  final bool isWarning;
  final bool isSuccess;
  final bool showNotice;
  final String noticeMsg;
  final double width;

  final void Function() onCloseBtnPressed;

  const NoticeDialog(this.showNotice, this.noticeMsg, this.width, {required this.onCloseBtnPressed, this.isError = false, this.isWarning = false, this.isSuccess = true, Key? key}) : super(key: key);

  @override
  State<NoticeDialog> createState() => _NoticeDialogState();
}

class _NoticeDialogState extends State<NoticeDialog> {

  _checkNoticeType() {
    if (widget.isError && widget.isWarning && widget.isSuccess) {
      throw("only one notice type is allowed, isError. isWarning and isSuccess all set to true");
    } else if (widget.isError && widget.isSuccess || widget.isSuccess && widget.isWarning || widget.isWarning && widget.isSuccess) {
      throw("only one notice type is allowed,");
    }
  }

  @override
  void initState() {
    super.initState();

    _checkNoticeType();
  }

  @override
  Widget build(BuildContext context) {

    return widget.showNotice ? Positioned(
      bottom: 1.0,
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.bounceInOut,
            width: widget.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(199, 0, 0, 0),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    widget.isSuccess ? Icons.thumb_up_alt
                    : widget.isError ? Icons.error
                    : widget.isWarning ? Icons.warning_amber
                    : null, 
                    color: widget.isSuccess ? Colors.green
                    : widget.isError ? Colors.red
                    : widget.isWarning ? Colors.yellow
                    : null,
                    ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(widget.noticeMsg,
                      style: TextStyle(
                        color: widget.isSuccess ? Colors.green
                        : widget.isError ? Colors.red
                        : widget.isWarning ? Colors.yellow
                        : null,
                      )
                    )
                  ),
                ),
                IconButton(
                  splashRadius: 24,
                  icon: const Icon(Icons.cancel),
                  onPressed: widget.onCloseBtnPressed,
                )
              ],
            )
          ),
        ),
      ),
    ) : const SizedBox();
  }
}