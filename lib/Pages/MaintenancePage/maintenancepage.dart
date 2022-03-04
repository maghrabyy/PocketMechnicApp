import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/NearbyMechanic%20Page/nearbymechanicloading.dart';
import 'package:flutter_course/Pages/TowTruckPage/towtruck_page.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_course/components/rounded_buttoncontainer.dart';

class MaintenancePage extends StatefulWidget {
  static const String id = 'MaintenancePage';
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButtonContainer(
          child: const IconContent(
              iconSize: 100,
              textSize: 40,
              iconText: 'Nearby Mechanic',
              iconC: FontAwesomeIcons.mapMarked),
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, NearbyMechanicLoading.id);
            });
          },
          boxColor: thirdLayerColor,
        ),
        RoundedButtonContainer(
          child: const IconContent(
              iconSize: 100,
              textSize: 40,
              iconText: 'Tow Truck',
              iconC: FontAwesomeIcons.truckPickup),
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, TowTruckPage.id);
            });
          },
          boxColor: thirdLayerColor,
        ),
      ],
    );
  }
}
