import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/PartnerProfile/partner_settings.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/PartnerProfile/partnerprofile.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/Requests/requests.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/Reservations/addreservationdate.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/Reservations/reservations.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class PartnerMain extends StatefulWidget {
  static const String id = 'PartnerMain';
  const PartnerMain({Key? key}) : super(key: key);

  @override
  State<PartnerMain> createState() => _PartnerMainState();
}

class _PartnerMainState extends State<PartnerMain> {
  int currentMechanicPageIndex = 0;
  final _mechPageOptions = [
    const Reservations(),
    const MechanicRequests(),
    const PartnerProfile(),
  ];
  final _mechPageTitles = [
    'Reservations',
    'Requests',
    'Profile',
  ];
  List<Widget> profileAppbarActions() {
    return [
      StreamBuilder(
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
            return IconButton(
                onPressed: () {
                  if (snapshot.data['available'] == true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: fifthLayerColor,
                              title: const Text(
                                'Turn off duty',
                                style: TextStyle(color: textColor),
                              ),
                              content:
                                  const Text('Are you want to turn off-duty?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _firestore
                                          .collection('Partners')
                                          .doc(_auth.currentUser!.uid)
                                          .update({'available': false});
                                    },
                                    child: const Text(
                                      'Confirm',
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: fifthLayerColor,
                              title: const Text(
                                'Turn on duty',
                                style: TextStyle(color: textColor),
                              ),
                              content:
                                  const Text('Are you want to turn on-duty?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _firestore
                                          .collection('Partners')
                                          .doc(_auth.currentUser!.uid)
                                          .update({'available': true});
                                    },
                                    child: const Text(
                                      'Confirm',
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
                  }
                },
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 27,
                  color: snapshot.data['available'] == true
                      ? Colors.green
                      : Colors.red,
                ));
          }
        },
      ),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, PartnerSettings.id);
          },
          icon: const Icon(Icons.settings, size: 30)),
      const LogoutActionButton()
    ];
  }

  List<Widget> mechanicAppbarActions() {
    if (currentMechanicPageIndex == 0) {
      return [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                      backgroundColor: thirdLayerColor,
                      insetPadding: EdgeInsets.all(2.0),
                      title: Text(
                        'Add Reservation Date',
                        style: TextStyle(color: textColor),
                      ),
                      content: AddReservations()));
            },
            icon: const Icon(Icons.add, size: 30)),
        const LogoutActionButton()
      ];
    } else if (currentMechanicPageIndex == 2) {
      return profileAppbarActions();
    } else {
      return [const LogoutActionButton()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Partners')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot partnerSnapshot) {
        if (!partnerSnapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(color: fifthLayerColor),
          );
        } else {
          if (partnerSnapshot.data['partnerType'] == 'Mechanic') {
            return Scaffold(
              appBar: AppBar(
                title:
                    Text(_mechPageTitles.elementAt(currentMechanicPageIndex)),
                actions: mechanicAppbarActions(),
              ),
              body: _mechPageOptions.elementAt(currentMechanicPageIndex),
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (pageIndex) {
                    setState(() {
                      currentMechanicPageIndex = pageIndex;
                    });
                  },
                  currentIndex: currentMechanicPageIndex,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.book,
                        ),
                        label: 'Reservations'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.request_page,
                        ),
                        label: 'Requests'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                        ),
                        label: 'Profile'),
                  ]),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tow-Truck Driver'),
                actions: profileAppbarActions(),
              ),
              body: const PartnerProfile(),
            );
          }
        }
      },
    );
  }
}

class LogoutActionButton extends StatelessWidget {
  const LogoutActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    backgroundColor: fifthLayerColor,
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: textColor),
                    ),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            logout(context);
                          },
                          child: const Text(
                            'Logout',
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
        },
        icon: const Icon(
          Icons.logout,
          size: 30,
          color: Colors.red,
        ));
  }
}
