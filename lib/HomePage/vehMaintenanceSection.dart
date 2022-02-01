import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum vMaintanceSubServices { nearbyMechanic, towTruck }
vMaintanceSubServices? selectedSubService;
// ignore: file_names

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
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSubService = vMaintanceSubServices.nearbyMechanic;
                  Navigator.pushNamed(context, 'NearbyMechanicPage');
                });
              },
              boxColor:
                  selectedSubService == vMaintanceSubServices.nearbyMechanic
                      ? tappedButtonColor
                      : containerColor,
              boxChild: const IconContent(
                  iconText: 'Nearby Mechanic',
                  iconC: FontAwesomeIcons.mapMarked),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSubService = vMaintanceSubServices.towTruck;
                  Navigator.pushNamed(context, 'TowTruckPage');
                });
              },
              boxColor: selectedSubService == vMaintanceSubServices.towTruck
                  ? tappedButtonColor
                  : containerColor,
              boxChild: const IconContent(
                  iconText: 'Tow Truck', iconC: FontAwesomeIcons.truckPickup),
            ),
          ),
        ],
      ),
    );
  }
}
