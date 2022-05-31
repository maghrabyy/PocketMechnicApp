import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class MechanicBookDate extends StatelessWidget {
  const MechanicBookDate({Key? key, required this.reservationsPartnerID})
      : super(key: key);
  final String reservationsPartnerID;
  static const String id = 'MechanicBookDate';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('reservationDates')
            .where('partnerID', isEqualTo: reservationsPartnerID)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SpinKitFadingFour(color: fifthLayerColor),
            );
          } else {
            List reservationsList = snapshot.data.docs;
            reservationsList.sort((a, b) => (b['from']).compareTo(a['from']));
            reservationsList.sort((a, b) => (b['date']).compareTo(a['date']));
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
                      'Reservation dates aren\'t set yet.',
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

                  DateTime date =
                      DateTime.parse(value['date'].toDate().toString());
                  return RoundedButtonContainer(
                      onPressed: () async {
                        if (value['booked'] == false) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: fifthLayerColor,
                                    title: const Text(
                                      'Book date',
                                      style: TextStyle(color: textColor),
                                    ),
                                    content: Text(
                                        'Are you sure you want to book a appointment starts from ${value['from']} to ${value['until']}?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            String currentUserID =
                                                await getUserID(
                                                    _auth.currentUser!.uid);
                                            _firestore
                                                .collection('reservationDates')
                                                .doc(value['reservationID'])
                                                .update({
                                              'bookedBy': currentUserID,
                                              'booked': true
                                            });
                                          },
                                          child: const Text(
                                            'Book',
                                            style: TextStyle(color: textColor),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(color: textColor),
                                          )),
                                    ],
                                  ));
                        } else {
                          String userID =
                              await getUserID(_auth.currentUser!.uid);
                          if (value['bookedBy'] == userID) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: fifthLayerColor,
                                      title: const Text(
                                        'Unbook date',
                                        style: TextStyle(color: textColor),
                                      ),
                                      content: const Text(
                                          'Are you sure you want to unbook this appointment?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              _firestore
                                                  .collection(
                                                      'reservationDates')
                                                  .doc(value['reservationID'])
                                                  .update({
                                                'bookedBy': '',
                                                'booked': false
                                              });
                                            },
                                            child: const Text(
                                              'unbook',
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
                          }
                        }
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
                              child: SpinKitFadingFour(color: fifthLayerColor),
                            );
                          } else {
                            var docs = userSnapshot.data.docs;
                            final user = docs[0].data()!;

                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'From ${value['from']} To To: ${value['until']}'),
                                  Text(
                                      'Date: ${DateFormat('yMMMMd').format(date)}'),
                                ],
                              ),
                              subtitle: Visibility(
                                  visible: value['booked'],
                                  child:
                                      Text('Booked by: ${user['FullName']}')),
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
}
