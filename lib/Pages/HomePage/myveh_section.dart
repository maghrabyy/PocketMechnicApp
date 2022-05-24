import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/img_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class MyVehicleSection extends StatefulWidget {
  const MyVehicleSection({Key? key}) : super(key: key);

  @override
  _MyVehicleSectionState createState() => _MyVehicleSectionState();
}

class _MyVehicleSectionState extends State<MyVehicleSection> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      boxColor: thirdLayerColor,
      cWidth: double.infinity,
      boxChild: StreamBuilder(
        stream: _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(
              child: Text('......'),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  stream: _firestore
                      .collection('VehicleData')
                      .doc(userSnapshot.data['Vehicle']['VehicleID'])
                      .snapshots(),
                  builder: (context, AsyncSnapshot vehSnapshot) {
                    if (!vehSnapshot.hasData) {
                      return const Center(
                        child: Text('......'),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                userSnapshot.data['Vehicle']['VehicleName']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Engine Capacity: ${vehSnapshot.data['EngineCapacity']} cc'),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Battery Health: 22/08/2022'),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const RoundedContainer(
                  boxColor: fourthLayerColor,
                  boxChild: ImgContent(
                    imgSrc: 'assets/carCheck.png',
                    imgText: 'Periodic services',
                    imgHeight: 70,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
