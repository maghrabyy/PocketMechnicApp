// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearbyMechanicPage extends StatefulWidget {
  const NearbyMechanicPage({Key? key}) : super(key: key);

  @override
  _NearbyMechanicPageState createState() => _NearbyMechanicPageState();
}

class _NearbyMechanicPageState extends State<NearbyMechanicPage> {
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('my location: $position');
    print('Hello guys');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedContainer(
          boxColor: containerColor,
          cWidth: double.infinity,
          cHeight: 60,
          boxChild: const Center(
            child: Text(
              'Hold on',
            ),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxColor: containerColor,
            cWidth: double.infinity,
            boxChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconContent(
                  iconText: 'The map will be here.',
                  iconC: FontAwesomeIcons.mapMarked,
                  textSize: 50,
                  iconSize: 140,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: tappedButtonColor,
                        minimumSize: const Size(140, 50)),
                    onPressed: () => getLocation(),
                    child: const Text('Get location')),
              ],
            ),
          ),
        )
      ],
    );
  }
}
