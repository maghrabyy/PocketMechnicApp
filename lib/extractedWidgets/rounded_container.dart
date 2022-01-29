import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Color? boxColor;
  final Widget boxChild;
  final double? cHeight;
  final double? cWidth;

  const RoundedContainer(
      {this.boxColor, required this.boxChild, this.cHeight, this.cWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: boxChild,
      height: cHeight,
      width: cWidth,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: boxColor,
      ),
    );
  }
}
