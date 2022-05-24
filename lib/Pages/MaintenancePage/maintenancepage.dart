import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/RequestMechanicPage/requestmechanicpage.dart';
import 'package:flutter_course/Pages/TowTruckPage/towtruck_page.dart';
import 'package:flutter_course/Pages/nearbyMechanic/nearbymechanic.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_course/components/rounded_buttoncontainer.dart';

List<Widget> vehicleMaintenance(
    BuildContext context, double? iconSize, double? textSize) {
  return [
    Expanded(
      child: RoundedButtonContainer(
        child: IconContent(
            iconSize: iconSize,
            textSize: textSize,
            iconText: 'Nearby Mechanic',
            iconC: FontAwesomeIcons.mapMarked),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatingPage(
                  title: 'Nearby Mechanic', page: NearbyMechanic()),
            ),
          );
        },
        boxColor: thirdLayerColor,
      ),
    ),
    Expanded(
      child: RoundedButtonContainer(
        child: IconContent(
            iconSize: iconSize,
            textSize: textSize,
            iconText: 'Request Mechanic',
            iconC: Icons.car_repair),
        onPressed: () {
          Navigator.pushNamed(context, RequestMechanicPage.id);
        },
        boxColor: thirdLayerColor,
      ),
    ),
    Expanded(
      child: RoundedButtonContainer(
        child: IconContent(
            iconSize: iconSize,
            textSize: textSize,
            iconText: 'Request Tow Truck',
            iconC: FontAwesomeIcons.truckPickup),
        onPressed: () {
          Navigator.pushNamed(context, TowTruckPage.id);
        },
        boxColor: thirdLayerColor,
      ),
    ),
  ];
}

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
      children: vehicleMaintenance(context, 70, 30),
    );
  }
}
