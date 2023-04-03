import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  bool showError = false;
  String errorMsg = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 77, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 40, right: 20, left: 20),
            child: ListView()
          ),
          ErrorDialog(
            showError,
            errorMsg,
            onCloseBtnPressed: () {},
          )
        ],
      ),
    );
  }
}

class ErrorDialog extends StatefulWidget {
  final bool showError;
  final String errorMsg;

  final void Function() onCloseBtnPressed;

  const ErrorDialog(this.showError, this.errorMsg, {required this.onCloseBtnPressed, Key? key}) : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return widget.showError ? Positioned(
      bottom: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(101, 80, 105, 189),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.error, color: Colors.red),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(widget.errorMsg,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 17, 0)
                    )
                  )
                ),
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: widget.onCloseBtnPressed,
              )
            ],
          )
        ),
      ),
    ) : const SizedBox();
  }
}