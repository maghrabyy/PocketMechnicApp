import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/img_content.dart';

Expanded myVehicleSection() {
  return Expanded(
    child: RoundedContainer(
      boxColor: containerColor,
      cWidth: double.infinity,
      boxChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Vehicle Model: '),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Oil date: '),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Battery Health: '),
              ),
            ],
          ),
          RoundedContainer(
            boxColor: tappedButtonColor,
            boxChild: const ImgContent(
              imgSrc: 'assets/carCheck.png',
              imgText: 'Periodic services',
              imgHeight: 70,
            ),
          ),
        ],
      ),
    ),
  );
}
