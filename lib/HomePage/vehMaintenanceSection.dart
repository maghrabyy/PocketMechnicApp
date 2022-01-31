import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: file_names
Expanded vehMaintSubServices() {
  return Expanded(
    child: Row(
      children: [
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const IconContent(
                iconText: 'Nearby Mechanic', iconC: FontAwesomeIcons.mapMarked),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: const IconContent(
                iconText: 'Tow Truck', iconC: FontAwesomeIcons.truckPickup),
          ),
        ),
      ],
    ),
  );
}
