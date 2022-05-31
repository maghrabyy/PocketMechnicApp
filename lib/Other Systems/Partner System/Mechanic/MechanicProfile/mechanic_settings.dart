import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:flutter_course/Services/GoogleMaps/googlemapsservice.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class MechanicSettings extends StatefulWidget {
  static const String id = 'MechanicSettings';
  const MechanicSettings({Key? key}) : super(key: key);

  @override
  State<MechanicSettings> createState() => _MechanicSettingsState();
}

class _MechanicSettingsState extends State<MechanicSettings> {
  TimeOfDay? selectedOpenTime;
  String openHours = '';
  String openMinutes = '';
  TextEditingController locationSearch = TextEditingController();
  Future pickOpenTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: selectedOpenTime ?? initialTime,
    );
    if (newTime == null) return;

    String getCloseHour = '';
    await _firestore
        .collection('Partners')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => getCloseHour = value['workingHours.close']);
    selectedOpenTime = newTime;
    _firestore.collection('Partners').doc(_auth.currentUser!.uid).update({
      'workingHours': {'open': openTimeText(), 'close': getCloseHour}
    });
  }

  String openTimeText() {
    if (selectedOpenTime == null) {
      return 'Working Hours';
    } else {
      openHours = selectedOpenTime!.hour.toString().padLeft(2, '0');
      openMinutes = selectedOpenTime!.minute.toString().padLeft(2, '0');
      return '$openHours:$openMinutes';
    }
  }

  TimeOfDay? selectedCloseTime;
  String closeHours = '';
  String closeMinutes = '';
  Future pickCloseTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: selectedCloseTime ?? initialTime,
    );
    if (newTime == null) return;

    String getOpenHour = '';
    await _firestore
        .collection('Partners')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => getOpenHour = value['workingHours.open']);
    selectedCloseTime = newTime;
    _firestore.collection('Partners').doc(_auth.currentUser!.uid).update({
      'workingHours': {'open': getOpenHour, 'close': closeTimeText()}
    });
  }

  String closeTimeText() {
    if (selectedCloseTime == null) {
      return 'Working Hours';
    } else {
      closeHours = selectedCloseTime!.hour.toString().padLeft(2, '0');
      closeMinutes = selectedCloseTime!.minute.toString().padLeft(2, '0');
      return '$closeHours:$closeMinutes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Partners')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TextDivider(text: Text('Working hours')),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: RoundedButtonContainer(
                    onPressed: () {
                      pickOpenTime(context);
                    },
                    boxColor: fifthLayerColor,
                    height: 35,
                    child: Center(
                      child: Text(
                        snapshot.data['workingHours.open'] == ''
                            ? 'Click here to set Open hour'
                            : 'Opens at: ${snapshot.data['workingHours.open']}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: RoundedButtonContainer(
                    onPressed: () {
                      pickCloseTime(context);
                    },
                    boxColor: fifthLayerColor,
                    height: 35,
                    child: Center(
                      child: Text(
                        snapshot.data['workingHours.close'] == ''
                            ? 'Click here to set Close hour'
                            : 'Closes at: ${snapshot.data['workingHours.close']}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const TextDivider(text: Text('Location')),
                const SizedBox(
                  height: 200,
                  child: GoogleMapAPI(
                    lat: 30.0100845,
                    long: 31.2053852,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RegularInput(
                            label: 'Location', inputController: locationSearch),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Mark current location')),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
