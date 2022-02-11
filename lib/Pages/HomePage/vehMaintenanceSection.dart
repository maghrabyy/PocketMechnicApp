// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_course/components/rounded_buttoncontainer.dart';

enum vMaintanceSubServices { nearbyMechanic, towTruck }
vMaintanceSubServices? selectedSubService;

class VehMaintenanceSection extends StatefulWidget {
  const VehMaintenanceSection({Key? key}) : super(key: key);

  @override
  _VehMaintenanceSectionState createState() => _VehMaintenanceSectionState();
}

class _VehMaintenanceSectionState extends State<VehMaintenanceSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: RoundedButtonContainer(
              child: const IconContent(
                  iconText: 'Nearby Mechanic',
                  iconC: FontAwesomeIcons.mapMarked),
              onPressed: () {
                setState(() {
                  selectedSubService = vMaintanceSubServices.nearbyMechanic;
                  Navigator.pushNamed(context, '/NearbyMechanicLoading');
                });
              },
              boxColor: containerColor,
              onPressedColor: tappedButtonColor,
            ),
          ),
          Expanded(
            child: RoundedButtonContainer(
              child: const IconContent(
                  iconText: 'Tow Truck', iconC: FontAwesomeIcons.truckPickup),
              onPressed: () {
                setState(() {
                  selectedSubService = vMaintanceSubServices.towTruck;
                  Navigator.pushNamed(context, '/TowTruckPage');
                });
              },
              boxColor: containerColor,
              onPressedColor: tappedButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
