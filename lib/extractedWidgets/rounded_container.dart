import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Color? boxColor;
  final Widget? boxChild;
  final double? cHeight;
  final double? cWidth;
  final VoidCallback? onPressed;

  const RoundedContainer(
      {this.boxColor,
      this.boxChild,
      this.cHeight,
      this.cWidth,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: boxChild,
        height: cHeight,
        width: cWidth,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: boxColor,
        ),
      ),
    );
  }
}
