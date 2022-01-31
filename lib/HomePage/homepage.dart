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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PmServices selectedService = PmServices.vMaintenance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child:
              ClipOval(child: Image(image: AssetImage('assets/pmLogo3.png'))),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedService = PmServices.vMaintenance;
                      });
                    },
                    child: RoundedContainer(
                      boxColor: selectedService == PmServices.vMaintenance
                          ? tappedButtonColor
                          : containerColor,
                      boxChild: const IconContent(
                        iconText: 'Vehicle Maintenance',
                        iconC: FontAwesomeIcons.tools,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedService = PmServices.sparePartsShop;
                      });
                    },
                    child: RoundedContainer(
                      boxColor: selectedService == PmServices.sparePartsShop
                          ? tappedButtonColor
                          : containerColor,
                      boxChild: const IconContent(
                        iconText: 'Spare-Parts Shop',
                        iconC: FontAwesomeIcons.shoppingCart,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedService = PmServices.myVehicleSection;
                    });
                  },
                  child: RoundedContainer(
                    boxColor: selectedService == PmServices.myVehicleSection
                        ? tappedButtonColor
                        : containerColor,
                    boxChild: const IconContent(
                      iconC: FontAwesomeIcons.car,
                      iconText: 'My Vehicle',
                    ),
                  ),
                ))
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: Column(
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
              ),
            ),
          ),
          // subServicesDisplay
          selectedService == PmServices.vMaintenance
              ? vehMaintSubServices()
              : Row(),
          selectedService == PmServices.sparePartsShop
              ? sparePartsSection()
              : Row(),
          selectedService == PmServices.myVehicleSection
              ? myVehicleSection()
              : Row(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_sharp),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Repair',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
