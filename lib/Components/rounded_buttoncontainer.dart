import 'package:flutter/material.dart';
import 'rounded_container.dart';

class RoundedButtonContainer extends StatelessWidget {
  const RoundedButtonContainer(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.onLongPress,
      this.boxColor,
      this.height,
      this.width})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Color? boxColor;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      cHeight: height,
      cWidth: width,
      boxColor: boxColor,
      boxChild: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
