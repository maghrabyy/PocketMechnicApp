import 'package:flutter/material.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/style.dart';

class TowTruckPage extends StatefulWidget {
  const TowTruckPage({Key? key}) : super(key: key);

  @override
  _TowTruckPageState createState() => _TowTruckPageState();
}

class _TowTruckPageState extends State<TowTruckPage> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: containerColor,
    );
  }
}
