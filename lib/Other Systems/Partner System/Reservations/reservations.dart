import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class Reservations extends StatelessWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPartnerID(_auth.currentUser!.uid),
      builder: (context, AsyncSnapshot partnerIDSnapshot) {
        if (!partnerIDSnapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          String partnerID = partnerIDSnapshot.data;
          return StreamBuilder(
              stream: _firestore
                  .collection('reservationDates')
                  .where('partnerID', isEqualTo: partnerID)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SpinKitFadingFour(color: fifthLayerColor),
                  );
                } else {
                  List reservationsList = snapshot.data.docs;
                  reservationsList
                      .sort((a, b) => (b['from']).compareTo(a['from']));
                  reservationsList
                      .sort((a, b) => (b['date']).compareTo(a['date']));

                  if (reservationsList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.pageview,
                            size: 100,
                          ),
                          Text(
                            'You haven\'t set any reservation dates yet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: reservationsList.reversed
                          .map<RoundedButtonContainer>((dynamic value) {
                        Widget reservationStatus() {
                          if (value['booked'] == true) {
                            return const IconContent(
                              iconText: 'Booked',
                              iconC: FontAwesomeIcons.book,
                              iconColor: Colors.red,
                              iconSize: 30,
                              padding: 1,
                            );
                          } else {
                            return const IconContent(
                              iconText: 'available',
                              iconC: FontAwesomeIcons.book,
                              iconColor: Colors.green,
                              iconSize: 30,
                              padding: 1,
                            );
                          }
                        }

                        return RoundedButtonContainer(
                            onPressed: () async {
                              if (value['booked'] == true) {
                                String userDocID = '';
                                await _firestore
                                    .collection('Users')
                                    .where('UserID',
                                        isEqualTo: value['bookedBy'])
                                    .get()
                                    .then((value) {
                                  // ignore: avoid_function_literals_in_foreach_calls
                                  value.docs.forEach((element) {
                                    userDocID = element.id;
                                  });
                                });
                                String userFullName = '';
                                _firestore
                                    .collection('Users')
                                    .doc(userDocID)
                                    .get()
                                    .then((userValue) =>
                                        userFullName = userValue['FullName']);
                                String userVehID = '';
                                await _firestore
                                    .collection('Users')
                                    .doc(userDocID)
                                    .get()
                                    .then((userValue) => userVehID =
                                        userValue['Vehicle.VehicleID']);
                                String userVehName = '';
                                _firestore
                                    .collection('Users')
                                    .doc(userDocID)
                                    .get()
                                    .then((userValue) => userVehName =
                                        userValue['Vehicle.VehicleName']);
                                DocumentSnapshot? vehData;
                                await _firestore
                                    .collection('VehicleData')
                                    .doc(userVehID)
                                    .get()
                                    .then((vehValue) => vehData = vehValue);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            backgroundColor: thirdLayerColor,
                                            insetPadding:
                                                const EdgeInsets.all(2.0),
                                            title: Text(
                                              '$userFullName\'s vehicle',
                                              style: const TextStyle(
                                                  color: textColor),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextDivider(
                                                    text: Text(userVehName)),
                                                Text(
                                                    'Brand: ${vehData!['Brand']}'),
                                                Text(
                                                    'Model: ${vehData!['Model']}'),
                                                Text(
                                                    'Model Year: ${vehData!['ModelYear']}'),
                                                Text(
                                                    'Body Type: ${vehData!['BodyType']}'),
                                                Text(
                                                    'Engine Capacity: ${vehData!['EngineCapacity']}'),
                                                Text(
                                                    'Transimission: ${vehData!['Transimission']}'),
                                              ],
                                            )));
                              }
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor: thirdLayerColor,
                                        insetPadding: const EdgeInsets.all(2.0),
                                        title: const Text(
                                          'Remove',
                                          style: TextStyle(color: textColor),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to delete this reservation date?',
                                          style: TextStyle(color: textColor),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _firestore
                                                    .collection(
                                                        'reservationDates')
                                                    .doc(value['reservationID'])
                                                    .delete()
                                                    .then(
                                                        // ignore: avoid_print
                                                        (_) => print('Deleted'))
                                                    // ignore: avoid_print
                                                    .catchError((error) => print(
                                                        'Delete failed: $error'));
                                              },
                                              child: const Text(
                                                'Remove',
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                        ],
                                      ));
                            },
                            boxColor: fifthLayerColor,
                            child: StreamBuilder(
                              stream: _firestore
                                  .collection('Users')
                                  .where('UserID', isEqualTo: value['bookedBy'])
                                  .snapshots(),
                              builder: (context, AsyncSnapshot userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return const Center(
                                    child: SpinKitFadingFour(
                                        color: fifthLayerColor),
                                  );
                                } else {
                                  var docs = userSnapshot.data.docs;
                                  final user = docs[0].data()!;

                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'From ${value['from']} To To: ${value['until']}'),
                                        Text(value['Daily'] == false
                                            ? 'Date: ${DateFormat('yMMMMd').format(DateTime.parse(value['date'].toDate().toString()))}'
                                            : 'Date: ${DateFormat('yMMMMd').format(DateTime.now())} Daily'),
                                      ],
                                    ),
                                    subtitle: Visibility(
                                        visible: value['booked'],
                                        child: Text(
                                            'Booked by: ${user['FullName']}')),
                                    trailing: reservationStatus(),
                                  );
                                }
                              },
                            ));
                      }).toList(),
                    ),
                  );
                }
              });
        }
      },
    );
  }
}
