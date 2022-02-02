import 'package:flutter/material.dart';
import 'rounded_container.dart';

class RoundedButtonContainer extends StatelessWidget {
  const RoundedButtonContainer(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.boxColor,
      this.onPressedColor})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color? boxColor;
  final Color? onPressedColor;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: boxColor,
      boxChild: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: onPressedColor,
        highlightColor: onPressedColor,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
