import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Pages/TowTruckPage/towtruck_drivers.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TowTruckPage extends StatefulWidget {
  static const String id = 'TowTruckPage';
  const TowTruckPage({Key? key}) : super(key: key);

  @override
  _TowTruckPageState createState() => _TowTruckPageState();
}

class _TowTruckPageState extends State<TowTruckPage> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: thirdLayerColor,
      boxChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              FontAwesomeIcons.truckPickup,
              size: 120,
            ),
          ),
          const Text(
            'Stuck somewhere and your vehicle isn\'t helping?',
          ),
          const Text(
            'Don\'t worry about it!',
          ),
          const Text(
            'Just push the button below and make sure that your GPS is turned on and you\'ll be able to request a Tow Truck',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple.shade700,
                  minimumSize: const Size(140, 50)),
              onPressed: () {
                Navigator.pushNamed(context, TowTruckDrivers.id);
              },
              child: const Text('Request Tow Truck'),
            ),
          ),
        ],
      ),
    );
  }
}
