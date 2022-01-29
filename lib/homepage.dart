import 'package:flutter/material.dart';
import 'style.dart';
import 'extractedWidgets/rounded_container.dart';
import 'extractedWidgets/icon_content.dart';
import 'extractedWidgets/img_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PmServices { vMaintenance, sparePartsShop, myVehicleSection }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget subServicesDisplay = Row();
  Expanded vehMaintSubServices() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: const IconContent(
                  iconText: 'Nearby Mechanic',
                  iconC: FontAwesomeIcons.mapMarked),
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

  Expanded sparePartsSection() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/carEngine.png', imgText: 'Engine and Oil'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/airFilter.png', imgText: 'Air Filter'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/carBattery.png', imgText: 'Car Battery'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              boxColor: containerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/brakePads.png', imgText: 'Breke Pads'),
            ),
          ),
        ],
      ),
    );
  }

  Expanded myVehicleSection() {
    return Expanded(
      child: RoundedContainer(
        boxColor: containerColor,
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
            RoundedContainer(
              boxColor: tappedButtonColor,
              boxChild: const ImgContent(
                imgSrc: 'assets/carCheck.png',
                imgText: 'Periodic services',
                imgHeight: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectService(PmServices selectedService) {
    setState(() {
      if (selectedService == PmServices.vMaintenance) {
        if (topContainerColor1 == containerColor) {
          topContainerColor1 = tappedButtonColor;
          topContainerColor2 = containerColor;
          topContainerColor3 = containerColor;
          subServicesDisplay = vehMaintSubServices();
        } else {
          topContainerColor1 = containerColor;
          subServicesDisplay = Row();
        }
      }
      if (selectedService == PmServices.sparePartsShop) {
        if (topContainerColor2 == containerColor) {
          topContainerColor1 = containerColor;
          topContainerColor2 = tappedButtonColor;
          topContainerColor3 = containerColor;
          subServicesDisplay = sparePartsSection();
        } else {
          topContainerColor2 = containerColor;
          subServicesDisplay = Row();
        }
      }
      if (selectedService == PmServices.myVehicleSection) {
        if (topContainerColor3 == containerColor) {
          topContainerColor1 = containerColor;
          topContainerColor2 = containerColor;
          topContainerColor3 = tappedButtonColor;
          subServicesDisplay = myVehicleSection();
        } else {
          topContainerColor3 = containerColor;
          subServicesDisplay = Row();
        }
      }
    });
  }

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
                      selectService(PmServices.vMaintenance);
                    },
                    child: RoundedContainer(
                      boxColor: topContainerColor1,
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
                      selectService(PmServices.sparePartsShop);
                    },
                    child: RoundedContainer(
                      boxColor: topContainerColor2,
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
                    selectService(PmServices.myVehicleSection);
                  },
                  child: RoundedContainer(
                    boxColor: topContainerColor3,
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
          subServicesDisplay
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
