import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/img_content.dart';

class MyVehicleSection extends StatefulWidget {
  const MyVehicleSection({Key? key}) : super(key: key);

  @override
  _MyVehicleSectionState createState() => _MyVehicleSectionState();
}

class _MyVehicleSectionState extends State<MyVehicleSection> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: thirdLayerColor,
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
          const RoundedContainer(
            boxColor: fourthLayerColor,
            boxChild: ImgContent(
              imgSrc: 'assets/carCheck.png',
              imgText: 'Periodic services',
              imgHeight: 70,
            ),
          ),
        ],
      ),
    );
  }
}
