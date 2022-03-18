import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/rounded_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marquee/marquee.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              RoundedContainer(
                boxColor: thirdLayerColor,
                boxChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: fourthLayerColor,
                        foregroundColor: Colors.white,
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          size: 90,
                        ),
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
              Expanded(
                child: RoundedContainer(
                  cWidth: 370,
                  boxColor: thirdLayerColor,
                  boxChild: FutureBuilder(
                      future: getUserData(_auth.currentUser!.uid),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: SpinKitFadingFour(
                                color: fifthLayerColor,
                              ),
                            );
                          case ConnectionState.done:
                            String vehID = snapshot.data['Vehicle.VehicleID'];
                            String vehName =
                                snapshot.data['Vehicle.VehicleName'];
                            return Column(
                              children: [
                                Text(
                                  vehName,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontFamily: 'Kanit',
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                      snapshotCollection: 'VehicleData',
                                      snapshotDocumentPath: vehID,
                                      snapshotField: 'Brand',
                                      snapshotFrontText: 'Brand:',
                                      icon: FontAwesomeIcons.car),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                      snapshotCollection: 'VehicleData',
                                      snapshotDocumentPath: vehID,
                                      snapshotField: 'Model',
                                      snapshotFrontText: 'Model:',
                                      icon: FontAwesomeIcons.carAlt),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                      snapshotCollection: 'VehicleData',
                                      snapshotDocumentPath: vehID,
                                      snapshotField: 'BodyType',
                                      snapshotFrontText: 'Body Type:',
                                      icon: FontAwesomeIcons.carSide),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                      snapshotCollection: 'VehicleData',
                                      snapshotDocumentPath: vehID,
                                      snapshotField: 'Color',
                                      snapshotFrontText: 'Color:',
                                      icon: FontAwesomeIcons.palette),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                    snapshotCollection: 'VehicleData',
                                    snapshotDocumentPath: vehID,
                                    snapshotField: 'EngineCapacity',
                                    snapshotFrontText: 'Engine Capacity:',
                                    snapshotBackText: 'cc',
                                    imageData: 'assets/carEngineGrey.png',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProfileData(
                                    snapshotCollection: 'VehicleData',
                                    snapshotDocumentPath: vehID,
                                    snapshotField: 'Transimission',
                                    snapshotFrontText: 'Transimission:',
                                    imageData: 'assets/gearStickGrey.png',
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Periodic Services'),
                                ),
                              ],
                            );

                          default:
                            return const Text('Unhandle State');
                        }
                      }),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData(
      {Key? key,
      this.text,
      this.icon,
      this.imageData,
      this.textSize,
      this.alignment,
      this.snapshotField,
      this.snapshotCollection,
      this.snapshotDocumentPath,
      this.snapshotFrontText,
      this.snapshotBackText})
      : super(key: key);

  final String? text;
  final IconData? icon;
  final String? imageData;
  final double? textSize;
  final TextAlign? alignment;
  final String? snapshotField;
  final String? snapshotCollection;
  final String? snapshotDocumentPath;
  final String? snapshotFrontText;
  final String? snapshotBackText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: Colors.grey,
                )
              : imageData != null
                  ? Image(
                      height: 25,
                      image: AssetImage(imageData!),
                    )
                  : null,
        ),
        SizedBox(
          width: snapshotField != 'FullName' ? 25 : 0,
        ),
        Expanded(
          child: text != null
              ? SizedBox(
                  height: 40,
                  child: Marquee(
                    text: text!,
                    blankSpace: 20.0,
                    style: TextStyle(fontSize: textSize ?? 25),
                  ),
                )
              : StreamBuilder(
                  stream: _fireStore
                      .collection(snapshotCollection!)
                      .doc(snapshotDocumentPath)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        'Loading...',
                        style: TextStyle(fontSize: textSize ?? 25),
                      );
                    }
                    var docData = snapshot.data as DocumentSnapshot;
                    return snapshotField == 'FullName'
                        ? Text(
                            '${docData[snapshotField!]}',
                            style: const TextStyle(fontSize: 22),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            '${snapshotFrontText ?? ''} ${docData[snapshotField!]} ${snapshotBackText ?? ''}',
                            style: TextStyle(fontSize: textSize ?? 25),
                          );
                  },
                ),
        ),
      ],
    );
  }
}
