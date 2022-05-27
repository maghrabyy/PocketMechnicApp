import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.color,
      this.radius,
      this.hint})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final double? radius;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hint,
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: color,
        child: child,
        padding: EdgeInsets.all(radius ?? 15.0),
        shape: const CircleBorder(),
      ),
    );
  }
}
