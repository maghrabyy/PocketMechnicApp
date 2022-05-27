import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class SubmittedRequest extends StatelessWidget {
  static const String id = 'SubmittedRequest';
  const SubmittedRequest({Key? key, this.unregisteredID}) : super(key: key);
  final String? unregisteredID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserID(_auth.currentUser!.uid),
      builder: (context, AsyncSnapshot userIDSnapshot) {
        if (!userIDSnapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          return StreamBuilder(
              stream: _firestore
                  .collection('PartnershipSubmission')
                  .doc(unregisteredID ?? userIDSnapshot.data)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SpinKitFadingFour(color: fifthLayerColor),
                  );
                } else {
                  if (snapshot.data['ApplicationStatus'] == 'Accepted') {
                    return Center(
                      child: RoundedContainer(
                        boxColor: thirdLayerColor,
                        boxChild: Wrap(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.checkCircle,
                                  size: 60,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Your request has been accepted. You can login with your partner credentials.',
                                    textAlign: TextAlign.center,
                                    style: (TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Text(
                                    'Service Type: ${snapshot.data['ServiceType']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Name: ${snapshot.data['ServiceName']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Contact Number: ${snapshot.data['ServiceContactNum']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Address: ${snapshot.data['ServiceAddress']}',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    );
                  } else {
                    return Center(
                      child: RoundedContainer(
                        boxColor: thirdLayerColor,
                        boxChild: Wrap(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.checkCircle,
                                  size: 60,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Your request has been submitted. We\'ll contact you soon.',
                                    textAlign: TextAlign.center,
                                    style: (TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Text(
                                    'Service Type: ${snapshot.data['ServiceType']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Name: ${snapshot.data['ServiceName']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Contact Number: ${snapshot.data['ServiceContactNum']}',
                                    textAlign: TextAlign.center),
                                Text(
                                    'Service Address: ${snapshot.data['ServiceAddress']}',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    );
                  }
                }
              });
        }
      },
    );
  }
}
