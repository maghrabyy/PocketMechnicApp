import 'package:flutter/material.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NearbyMechanicPage extends StatefulWidget {
  static String id = 'NearbyMechanicPage';
  final dynamic decodedJsonData;
  const NearbyMechanicPage({Key? key, this.decodedJsonData}) : super(key: key);
  @override
  _NearbyMechanicPageState createState() => _NearbyMechanicPageState();
}

class _NearbyMechanicPageState extends State<NearbyMechanicPage> {
  @override
  void initState() {
    super.initState();
  }

  updatingUI(dynamic theDataPath) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const RoundedContainer(
      boxColor: thirdLayerColor,
      cWidth: double.infinity,
      boxChild: IconContent(
        iconText: 'The map will be here.',
        iconC: FontAwesomeIcons.mapMarked,
        textSize: 50,
        iconSize: 140,
      ),
    );
  }
}
