import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Components/rounded_container.dart';
import '../../../../Components/textdivider.dart';
import '../../../../Pages/ProfilePage/profilepage.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class MechanicProfile extends StatelessWidget {
  const MechanicProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedContainer(
            boxColor: thirdLayerColor,
            boxChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black,
                            spreadRadius: 5)
                      ],
                    ),
                    child: const CircleAvatar(
                        backgroundColor: fourthLayerColor,
                        foregroundColor: Colors.white,
                        radius: 60,
                        child: Image(
                          image: AssetImage('assets/mechanicLogo.png'),
                          height: 80,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileData(
                    snapshotCollection: 'Users',
                    snapshotDocumentPath: _auth.currentUser!.uid,
                    snapshotField: 'FullName',
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  indent: 30,
                  endIndent: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileData(
                    text: '${_auth.currentUser?.email}',
                    textSize: 25,
                    icon: Icons.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileData(
                    snapshotCollection: 'Users',
                    snapshotDocumentPath: _auth.currentUser!.uid,
                    snapshotField: 'PhoneNumber',
                    snapshotFrontText: '[+20]',
                    icon: Icons.phone,
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            boxColor: thirdLayerColor,
            boxChild: StreamBuilder(
                stream: _fireStore
                    .collection('Partners')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SpinKitFadingFour(
                        color: fifthLayerColor,
                      ),
                    );
                  } else {
                    Widget availability() {
                      if (snapshot.data['available'] == true) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Available',
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.circle,
                                  color: Colors.green, size: 15),
                            )
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Not Available',
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.circle,
                                  color: Colors.red, size: 15),
                            )
                          ],
                        );
                      }
                    }

                    List reviewsList = snapshot.data['reviews'];
                    return Column(
                      children: [
                        TextDivider(
                            text: Text(
                          snapshot.data['partnerType'],
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileData(
                              snapshotCollection: 'Partners',
                              snapshotDocumentPath: _auth.currentUser!.uid,
                              snapshotField: 'serviceName',
                              snapshotFrontText: 'Service Name:',
                              icon: Icons.car_repair),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileData(
                              snapshotCollection: 'Partners',
                              snapshotDocumentPath: _auth.currentUser!.uid,
                              snapshotField: 'contactNumber',
                              snapshotFrontText: 'Contact Number: [+20]',
                              icon: FontAwesomeIcons.phone),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileData(
                              snapshotCollection: 'Partners',
                              snapshotDocumentPath: _auth.currentUser!.uid,
                              snapshotField: 'serviceAddress.addressName',
                              snapshotFrontText: 'Address:',
                              icon: FontAwesomeIcons.map),
                        ),
                        const TextDivider(
                          text: Text(
                            'Working Hours',
                          ),
                          color: fifthLayerColor,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: availability()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileData(
                              snapshotCollection: 'Partners',
                              snapshotDocumentPath: _auth.currentUser!.uid,
                              snapshotField: 'workingHours.open',
                              snapshotFrontText: 'Opens at:',
                              icon: FontAwesomeIcons.clock),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileData(
                              snapshotCollection: 'Partners',
                              snapshotDocumentPath: _auth.currentUser!.uid,
                              snapshotField: 'workingHours.close',
                              snapshotFrontText: 'Closes at:',
                              icon: FontAwesomeIcons.clock),
                        ),
                        TextDivider(
                            text: Text('Reviews (${reviewsList.length})')),
                        Column(
                          children: reviewsList.isEmpty
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'No one has submitted a review yet.'),
                                  ),
                                ]
                              : reviewsList.map<Column>((dynamic value) {
                                  return Column(
                                    children: [
                                      StreamBuilder(
                                          stream: _fireStore
                                              .collection('Users')
                                              .where('UserID',
                                                  isEqualTo: value['userID'])
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot userSnapshot) {
                                            if (!userSnapshot.hasData) {
                                              return const Center(
                                                child: SpinKitFadingFour(
                                                    color: fifthLayerColor),
                                              );
                                            } else {
                                              var docs = userSnapshot.data.docs;
                                              final user = docs[0].data()!;
                                              return ListTile(
                                                leading: Text(
                                                    '(${value['rate'].toString()}/5)'),
                                                title: Text(user['FullName'],
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    )),
                                                subtitle: Text(value['comment'],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              );
                                            }
                                          }),
                                      const Divider(
                                        color: fifthLayerColor,
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                    ],
                                  );
                                }).toList(),
                        )
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
