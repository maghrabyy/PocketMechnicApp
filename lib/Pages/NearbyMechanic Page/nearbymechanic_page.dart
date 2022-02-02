import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/style.dart';

class NearbyMechanicPage extends StatefulWidget {
  const NearbyMechanicPage({Key? key}) : super(key: key);

  @override
  _NearbyMechanicPageState createState() => _NearbyMechanicPageState();
}

class _NearbyMechanicPageState extends State<NearbyMechanicPage> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: containerColor,
    );
  }
}
