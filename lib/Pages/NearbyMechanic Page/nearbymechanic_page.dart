import 'package:flutter/material.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/welcomepage.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NearbyMechanicPage extends StatefulWidget {
  static const String id = 'NearbyMechanicPage';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const IconContent(
          iconText: 'The map will be here.',
          iconC: FontAwesomeIcons.mapMarked,
          textSize: 50,
          iconSize: 140,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, WelcomePage.id);
          },
          child: const Text('Test here'),
          style: ElevatedButton.styleFrom(primary: fifthLayerColor),
        )
      ],
    );
  }
}
