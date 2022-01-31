import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/img_content.dart';

Expanded sparePartsSection() {
  return Expanded(
    child: Row(
      children: [
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const ImgContent(
                imgSrc: 'assets/carEngine.png', imgText: 'Engine and Oil'),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const ImgContent(
                imgSrc: 'assets/airFilter.png', imgText: 'Air Filter'),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const ImgContent(
                imgSrc: 'assets/carBattery.png', imgText: 'Car Battery'),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const ImgContent(
                imgSrc: 'assets/brakePads.png', imgText: 'Breke Pads'),
          ),
        ),
      ],
    ),
  );
}
