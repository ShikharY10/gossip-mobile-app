import 'package:flutter/material.dart';

Widget defaultButton(
    {required String label,
    required Function validator,
    BuildContext? context,
    bool progressBar = false,
    bool disable = false,
    bool rightArrow = false,
    bool leftArrow = false,
    Color buttonColor = const Color.fromARGB(255, 135, 212, 182),
    }) {
  return InkWell(
      onTap: () {
        if (disable) {
          return;
        }
        validator(context);
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: 300,
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leftArrow
                ? const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 28, 29, 77),
                    size: 15,
                  )
                : const SizedBox(),
            progressBar
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(label,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 28, 29, 77),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
            rightArrow
                ? const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 28, 29, 77),
                    size: 15,
                  )
                : const SizedBox()
          ],
        ),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(50)),
      ));
}
