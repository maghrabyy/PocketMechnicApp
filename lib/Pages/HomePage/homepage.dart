import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'vehMaintenanceSection.dart';
import 'sparepart_section.dart';
import 'myveh_section.dart';

enum PmServices { vMaintenance, sparePartsShop, myVehicleSection }

class MyHomePage extends StatefulWidget {
  static const String id = 'MyHomePage';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PmServices selectedService = PmServices.vMaintenance;
  Widget middleContainer = const GradProjectCards();

  Widget bottomServices() {
    if (selectedService == PmServices.vMaintenance) {
      return const VehMaintenanceSection();
    } else if (selectedService == PmServices.sparePartsShop) {
      return const SparePartSection();
    } else {
      return const MyVehicleSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RoundedContainer(
          boxColor: thirdLayerColor,
          boxChild: Center(
            child: Text(
              'Our services',
              textAlign: TextAlign.center,
            ),
          ),
          cHeight: 30.0,
          cWidth: double.infinity,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: RoundedContainer(
                  onPressed: () {
                    setState(() {
                      selectedService = PmServices.vMaintenance;
                    });
                  },
                  boxColor: selectedService == PmServices.vMaintenance
                      ? fourthLayerColor
                      : thirdLayerColor,
                  boxChild: const IconContent(
                    iconText: 'Vehicle Maintenance',
                    iconC: FontAwesomeIcons.tools,
                  ),
                ),
              ),
              Expanded(
                child: RoundedContainer(
                  onPressed: () {
                    setState(() {
                      selectedService = PmServices.sparePartsShop;
                    });
                  },
                  boxColor: selectedService == PmServices.sparePartsShop
                      ? fourthLayerColor
                      : thirdLayerColor,
                  boxChild: const IconContent(
                    iconText: 'Spare-Parts Shop',
                    iconC: FontAwesomeIcons.shoppingCart,
                  ),
                ),
              ),
              Expanded(
                  child: RoundedContainer(
                onPressed: () {
                  setState(() {
                    selectedService = PmServices.myVehicleSection;
                  });
                },
                boxColor: selectedService == PmServices.myVehicleSection
                    ? fourthLayerColor
                    : thirdLayerColor,
                boxChild: const IconContent(
                  iconC: FontAwesomeIcons.car,
                  iconText: 'My Vehicle',
                ),
              ))
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: middleContainer,
        ),
        bottomServices()
      ],
    );
  }
}

class GradProjectCards extends StatelessWidget {
  const GradProjectCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'SAMS Graduation Project 2022',
          style: TextStyle(fontFamily: 'Righteous', fontSize: 25),
        ),
        Column(
          children: [
            const Card(
              child: ListTile(
                  leading: Icon(FontAwesomeIcons.projectDiagram),
                  title: Text('Project Name'),
                  subtitle: Text('Pocket Mechanic')),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Project Team'),
                subtitle: Column(
                  children: const [
                    Text('Mahmoud Mohamed Gamal'),
                    Text('Muhammed Khaled Mostafa'),
                    Text('Youssef Ramses Allam'),
                    Text('Ahmed Heshan Taha'),
                  ],
                ),
              ),
            ),
            const Card(
              child: ListTile(
                  leading: Icon(Icons.supervisor_account),
                  title: Text('Supervisor'),
                  subtitle: Text('Dr. Christena Albert')),
            ),
          ],
        )
      ],
    );
  }
}
