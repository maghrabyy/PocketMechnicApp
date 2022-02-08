import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final String iconText;
  final IconData iconC;
  final Color? iconColor;
  final Color? textColor;
  final double? textSize;
  final double? iconSize;
  const IconContent(
      {required this.iconText,
      required this.iconC,
      this.iconColor,
      this.textColor,
      this.iconSize,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            iconC,
            color: iconColor,
            size: iconSize,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            iconText,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: textSize),
          ),
        )
      ],
    );
  }
}
