import 'package:flutter/material.dart';

class ImgContent extends StatelessWidget {
  final String imgText;
  final String imgSrc;
  final Color? textColor;
  final double? imgHeight;
  final double? imgWidth;
  const ImgContent(
      {required this.imgSrc,
      required this.imgText,
      this.textColor,
      this.imgHeight,
      this.imgWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
              height: imgHeight,
              width: imgWidth,
              image: AssetImage(imgSrc),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            imgText,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        )
      ],
    );
  }
}
