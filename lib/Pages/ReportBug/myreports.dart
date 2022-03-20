import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class MyReports extends StatefulWidget {
  static const String id = 'MyReportsPage';
  const MyReports({Key? key}) : super(key: key);

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfDocExists('BugsReports', _auth.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: SpinKitFadingFour(color: fifthLayerColor),
            );
          default:
            if (snapshot.data == false) {
              return const Center(
                child: IconContent(
                  iconText: 'You haven\'t reported for any bugs yet.',
                  iconC: FontAwesomeIcons.stickyNote,
                  iconSize: 80,
                  textSize: 25,
                ),
              );
            } else {
              return const ReportBugsList();
            }
        }
      },
    );
  }
}

class ReportBugsList extends StatelessWidget {
  const ReportBugsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: _fireStore
              .collection('BugsReports')
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
              DateTime.now();
              List bugsList = snapshot.data!['Reports'];

              return Column(
                children: bugsList.map<Card>((dynamic value) {
                  Timestamp timestamp = value['Date'];
                  return Card(
                    color: fourthLayerColor,
                    child: ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      iconColor: iconColor,
                      collapsedIconColor: iconColor,
                      title: Text(
                        value['reportTitle'],
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontFamily: 'Kanit'),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Report ID: ${value['reportID']}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Email: ${value['userEmail']}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Date: ${timeago.format(timestamp.toDate())}',
                          ),
                        ),
                        const Divider(
                          color: fifthLayerColor,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value['reportDescription'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}
