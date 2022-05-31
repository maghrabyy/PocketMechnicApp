import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../Components/rounded_buttoncontainer.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class MechanicRequests extends StatelessWidget {
  const MechanicRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('mechanicRequests')
          .where('serviceStatus', isEqualTo: 'In-progress')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          List requestsList = snapshot.data.docs;
          if (requestsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.pageview,
                    size: 100,
                  ),
                  Text(
                    'There\'s no requests.',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                      children: requestsList.map<Wrap>((dynamic value) {
                    return Wrap(children: [
                      RoundedButtonContainer(
                          onPressed: () {},
                          boxColor: fifthLayerColor,
                          child: StreamBuilder(
                            stream: _firestore
                                .collection('Users')
                                .where('UserID', isEqualTo: value['userID'])
                                .snapshots(),
                            builder: (context, AsyncSnapshot userSnapshot) {
                              if (!userSnapshot.hasData) {
                                return const Center(
                                  child:
                                      SpinKitFadingFour(color: fifthLayerColor),
                                );
                              } else {
                                var docs = userSnapshot.data.docs;
                                final user = docs[0].data()!;
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: fourthLayerColor,
                                    foregroundColor: Colors.white,
                                    radius: 30,
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(user['FullName']),
                                  subtitle: Text(
                                      '${DateTime.parse(value['Date'].toDate().toString())}'),
                                  trailing: Text(value['serviceStatus']),
                                );
                              }
                            },
                          )),
                    ]);
                  }).toList()),
                  Text(_auth.currentUser!.uid)
                ],
              ),
            );
          }
        }
      },
    );
  }
}
