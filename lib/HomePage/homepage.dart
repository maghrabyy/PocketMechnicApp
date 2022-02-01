import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'vehMaintenanceSection.dart';
import 'sparepart_section.dart';
import 'myveh_section.dart';

enum PmServices { vMaintenance, sparePartsShop, myVehicleSection }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PmServices selectedService = PmServices.vMaintenance;
  Widget hi(Widget child) {
    return RawMaterialButton(
      child: child,
      onPressed: () {},
      elevation: 8.0,
      constraints: const BoxConstraints.tightFor(width: 56, height: 56),
      shape: const CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget middleContainer = const GradProjectCards();
    return Column(
      children: [
        RoundedContainer(
          boxColor: containerColor,
          boxChild: const Center(
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
                      ? tappedButtonColor
                      : containerColor,
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
                      ? tappedButtonColor
                      : containerColor,
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
                    ? tappedButtonColor
                    : containerColor,
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
          child: RoundedContainer(
            boxColor: containerColor,
            boxChild: middleContainer,
          ),
        ),
        // subServicesDisplay

        selectedService == PmServices.vMaintenance
            ? const VehMaintenanceSection()
            : Row(),
        selectedService == PmServices.sparePartsShop
            ? const SparePartSection()
            : Row(),
        selectedService == PmServices.myVehicleSection
            ? const MyVehicleSection()
            : Row()
      ],
    );
  }
}

class SlidderTest extends StatefulWidget {
  const SlidderTest({Key? key}) : super(key: key);

  @override
  _SlidderTestState createState() => _SlidderTestState();
}

class _SlidderTestState extends State<SlidderTest> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 50),
        ),
        Slider(
          min: 0,
          max: 120,
          value: num.toDouble(),
          onChanged: (double incNum) {
            setState(() {
              num = incNum.round();
            });
          },
        )
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
