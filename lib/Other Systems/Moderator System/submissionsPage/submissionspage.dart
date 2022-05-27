import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Components/rounded_buttoncontainer.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class Submissions extends StatefulWidget {
  const Submissions({
    Key? key,
  }) : super(key: key);

  @override
  State<Submissions> createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions> {
  TextEditingController newRegEmail = TextEditingController();
  String settedEmail = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('PartnershipSubmission')
          .where('ApplicationStatus', isEqualTo: 'In-progress')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          List submissionsList = snapshot.data.docs;
          if (submissionsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.pageview,
                    size: 100,
                  ),
                  Text(
                    'There\'s no submissions.',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Column(
                    children: submissionsList.map<Wrap>((dynamic value) {
                  return Wrap(children: [
                    RoundedButtonContainer(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      backgroundColor: fifthLayerColor,
                                      title: Text(
                                        '${value['UserID']}',
                                        style:
                                            const TextStyle(color: textColor),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextDivider(
                                            text: Text('User Information'),
                                            color: thirdLayerColor,
                                          ),
                                          Text(
                                              'Full Name: ${value['FullName']}'),
                                          Text(
                                              'Email: ${value['EmailAddress']}'),
                                          Text(
                                              'Phone Number: [+20] ${value['PhoneNumber']}'),
                                          const TextDivider(
                                            text: Text('Partner Information'),
                                            color: thirdLayerColor,
                                          ),
                                          Text(
                                              'Service Name: ${value['ServiceName']}'),
                                          Text(
                                              'Service Address: ${value['ServiceAddress']}'),
                                          Text(
                                              'Contact Number: [+20] ${value['ServiceContactNum']}'),
                                          Text(
                                              'Service Type: ${value['ServiceType']}'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              var rng1 = Random();
                                              var randNum1 =
                                                  rng1.nextInt(900000) + 100000;
                                              String userID = 'U$randNum1';
                                              var rng2 = Random();
                                              var randNum2 =
                                                  rng2.nextInt(900000) + 100000;
                                              String partnerID = 'U$randNum2';
                                              //Unregistered User
                                              if (value['Registered'] ==
                                                  false) {
                                                //Register User
                                                await _auth
                                                    .createUserWithEmailAndPassword(
                                                        email: value[
                                                            'EmailAddress'],
                                                        password: '123456');
                                                //Create User document
                                                await _firestore
                                                    .collection('Users')
                                                    .doc(_auth.currentUser!.uid)
                                                    .set({
                                                  'UserID': userID,
                                                  'FullName': value['FullName'],
                                                  'Email':
                                                      value['EmailAddress'],
                                                  'PhoneNumber':
                                                      value['PhoneNumber'],
                                                  'Vehicle': {
                                                    'VehicleID': '',
                                                    'VehicleName': ''
                                                  },
                                                  'userType': 'Partner',
                                                  'address': '',
                                                  'partnerID': partnerID,
                                                });
                                                //Create Partner document
                                                await _firestore
                                                    .collection('Partners')
                                                    .doc(_auth.currentUser!.uid)
                                                    .set({
                                                  'partnerID': partnerID,
                                                  'serviceName':
                                                      value['ServiceName'],
                                                  'contactNumber': value[
                                                      'ServiceContactNum'],
                                                  'serviceAddress': {
                                                    'addressCoordinates': '',
                                                    'addressName':
                                                        value['ServiceAddress']
                                                  },
                                                  'userID': userID,
                                                  'servicesHistory': [],
                                                  'appointmentDates': [],
                                                  'partnerType':
                                                      value['ServiceType'],
                                                  'available': false,
                                                  'workingHours': {
                                                    'open': '',
                                                    'close': ''
                                                  }
                                                });
                                                //update submission application status
                                                final collection =
                                                    _firestore.collection(
                                                        'PartnershipSubmission');
                                                collection
                                                    .doc(value['UserID'])
                                                    .update({
                                                  'ApplicationStatus':
                                                      'Accepted'
                                                });
                                                //Navigate to partner system

                                              }
                                              //Registered User
                                              else {
                                                //input new email
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                            backgroundColor:
                                                                thirdLayerColor,
                                                            title: const Text(
                                                              'New registration email',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor),
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                      'Set a new email for this already registered user.'),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: EmailInput(
                                                                      inputController:
                                                                          newRegEmail),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    settedEmail =
                                                                        newRegEmail
                                                                            .text;
                                                                    //Register with new email
                                                                    await _auth.createUserWithEmailAndPassword(
                                                                        email:
                                                                            settedEmail,
                                                                        password:
                                                                            '123456');
                                                                    //create User document
                                                                    await _firestore
                                                                        .collection(
                                                                            'Users')
                                                                        .doc(_auth
                                                                            .currentUser!
                                                                            .uid)
                                                                        .set({
                                                                      'UserID':
                                                                          userID,
                                                                      'FullName':
                                                                          value[
                                                                              'FullName'],
                                                                      'Email':
                                                                          settedEmail,
                                                                      'PhoneNumber':
                                                                          value[
                                                                              'PhoneNumber'],
                                                                      'Vehicle':
                                                                          {
                                                                        'VehicleID':
                                                                            '',
                                                                        'VehicleName':
                                                                            ''
                                                                      },
                                                                      'userType':
                                                                          'Partner',
                                                                      'address':
                                                                          '',
                                                                      'partnerID':
                                                                          partnerID,
                                                                    });
                                                                    //create partner document
                                                                    await _firestore
                                                                        .collection(
                                                                            'Partners')
                                                                        .doc(_auth
                                                                            .currentUser!
                                                                            .uid)
                                                                        .set({
                                                                      'partnerID':
                                                                          partnerID,
                                                                      'serviceName':
                                                                          value[
                                                                              'ServiceName'],
                                                                      'contactNumber':
                                                                          value[
                                                                              'ServiceContactNum'],
                                                                      'serviceAddress':
                                                                          {
                                                                        'addressCoordinates':
                                                                            '',
                                                                        'addressName':
                                                                            value['ServiceAddress']
                                                                      },
                                                                      'userID':
                                                                          userID,
                                                                      'servicesHistory':
                                                                          [],
                                                                      'appointmentDates':
                                                                          [],
                                                                      'partnerType':
                                                                          value[
                                                                              'ServiceType'],
                                                                      'available':
                                                                          false,
                                                                      'workingHours':
                                                                          {
                                                                        'open':
                                                                            '',
                                                                        'close':
                                                                            ''
                                                                      }
                                                                    });
                                                                    //update submission application status
                                                                    final collection =
                                                                        _firestore
                                                                            .collection('PartnershipSubmission');
                                                                    collection
                                                                        .doc(value[
                                                                            'UserID'])
                                                                        .update({
                                                                      'ApplicationStatus':
                                                                          'Accepted'
                                                                    });
                                                                    //Navigate to partner system
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Create partner',
                                                                    style: TextStyle(
                                                                        color:
                                                                            textColor),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color:
                                                                            textColor),
                                                                  ))
                                                            ]));
                                              }
                                            },
                                            child: Text(
                                              value['Registered'] == false
                                                  ? 'Create Partner'
                                                  : 'Set email',
                                              style: const TextStyle(
                                                  color: textColor),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style:
                                                  TextStyle(color: textColor),
                                            ))
                                      ]));
                        },
                        boxColor: fifthLayerColor,
                        child: ListTile(
                          leading:
                              Text('#${submissionsList.indexOf(value) + 1}'),
                          title: Text(value['UserID']),
                          subtitle: Text(
                              '${DateTime.parse(value['Date'].toDate().toString())}'),
                          trailing: Text(value['ContactRole']),
                        )),
                  ]);
                }).toList()),
                Text(_auth.currentUser!.uid)
              ],
            );
          }
        }
      },
    );
  }
}
