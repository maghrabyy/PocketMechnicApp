import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({Key? key, required this.text, this.color})
      : super(key: key);
  final Text text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: color ?? fifthLayerColor,
              height: 36,
            )),
      ),
      text,
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: color ?? fifthLayerColor,
              height: 36,
            )),
      ),
    ]);
  }
}
