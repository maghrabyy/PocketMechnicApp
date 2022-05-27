import 'package:flutter/material.dart';
import 'package:flutter_course/Components/circlebutton.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Pages/nearbyMechanic/bookdate.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import '../../Services/GoogleMaps/googlemapsservice.dart';

class NearbyMechanic extends StatefulWidget {
  const NearbyMechanic({Key? key}) : super(key: key);

  @override
  State<NearbyMechanic> createState() => _NearbyMechanicState();
}

class _NearbyMechanicState extends State<NearbyMechanic> {
  bool mechanicPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(children: [
          const GoogleMapAPI(),
          Visibility(
            visible: mechanicPressed,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MechanicAction(
                    text: 'Contact',
                    icon: Icons.contact_phone,
                    onPressed: () {},
                  ),
                  MechanicAction(
                    text: 'Navigation',
                    icon: Icons.navigation,
                    onPressed: () {},
                  ),
                  MechanicAction(
                    text: 'Book a date',
                    icon: Icons.book,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigatingPage(
                              title: 'Book a mechanic',
                              page: MechanicBookDate()),
                        ),
                      );
                    },
                  ),
                  MechanicAction(
                    text: 'Reviews',
                    icon: Icons.reviews,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ])),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              nearbyMechanicBox(true),
              nearbyMechanicBox(false),
              nearbyMechanicBox(true),
              nearbyMechanicBox(true),
            ],
          ),
        ),
      ],
    );
  }

  RoundedButtonContainer nearbyMechanicBox(bool isOpen) {
    return RoundedButtonContainer(
        boxColor: thirdLayerColor,
        onPressed: () {
          setState(() {
            mechanicPressed = !mechanicPressed;
          });
        },
        height: 180,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.car_repair_rounded,
              color: isOpen == true ? Colors.green : Colors.red,
            ),
            const Text('Mechanic Name'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.star,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                )
              ],
            ),
            const Text(
              'Mechanic Address Description Data',
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}

class MechanicAction extends StatelessWidget {
  const MechanicAction(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: fourthLayerColor,
          ),
        ),
        CircleButton(
          hint: text,
          radius: 10,
          child: Icon(
            icon,
            size: 25,
          ),
          onPressed: onPressed,
          color: fifthLayerColor,
        ),
      ],
    );
  }
}
