import 'package:flutter/material.dart';

class numPad extends StatelessWidget {
  final Object child;
  final VoidCallback onTap;
  var buttonColor = const Color(0xFFE3D4AD);
  numPad({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (child.toString() == "Icon(IconData(U+0E35A))") {
      buttonColor = const Color.fromARGB(153, 139, 195, 74);
    } else if (child.toString() == "Icon(IconData(U+0E1B9))") {
      buttonColor = const Color.fromARGB(153, 244, 67, 54);
    } else if (child.toString() == "Icon(IconData(U+0E357))") {
      buttonColor = const Color.fromARGB(153, 102, 179, 224);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: buttonColor),
          child: Center(child: (child as Widget)),
        ),
      ),
    );
  }
}
