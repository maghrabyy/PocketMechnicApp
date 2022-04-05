import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Services/GoogleMaps/fetching_currentlocation.dart';
import 'package:flutter_course/style.dart';

class RequestMechanicPage extends StatefulWidget {
  static const String id = 'RequestMechanicPage';
  const RequestMechanicPage({Key? key}) : super(key: key);

  @override
  State<RequestMechanicPage> createState() => _RequestMechanicPageState();
}

class _RequestMechanicPageState extends State<RequestMechanicPage> {
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
              Icons.car_repair,
              size: 150,
            ),
          ),
          const Text(
            'Push the button bellow and you will be able to request a mechanic to make check-ups on your vehicle',
            textAlign: TextAlign.center,
          ),
          const Text(
              'Right at your current location the mechanic will be able to accept your request and perform the required service.',
              textAlign: TextAlign.center),
          const Text(
            'You can simply send a photo of what is defected on your vehicle or you can send a voice message for the unusual noises your vehicle makes.',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple.shade700,
                  minimumSize: const Size(140, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FetchCurrentLocation(
                        pageTitle: 'Request Mechanic'),
                  ),
                );
              },
              child: const Text('Request Mechanic'),
            ),
          ),
        ],
      ),
    );
  }
}
