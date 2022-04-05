import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Pages/ReportBug/myreports.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import '../../Components/snackbar.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ReportBugPage extends StatefulWidget {
  static const String id = 'ReportBugPage';
  const ReportBugPage({Key? key}) : super(key: key);

  @override
  _ReportBugPageState createState() => _ReportBugPageState();
}

class _ReportBugPageState extends State<ReportBugPage> {
  bool emptyTitle = false;
  bool emptyReportField = false;
  TextEditingController reportTitle = TextEditingController();
  TextEditingController reportField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedContainer(
          boxChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Title',
              hint: 'Write the report\'s title here.',
              maxLength: 60,
              emptyFieldError: emptyTitle,
              onChanged: (value) {
                setState(() {
                  emptyTitle = false;
                });
              },
              inputController: reportTitle,
              capitalizationBehaviour: TextCapitalization.sentences,
              floatingLabel: true,
            ),
          ),
        ),
        Expanded(
          child: RoundedContainer(
            boxChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextArea(
                inputController: reportField,
                label: 'Report',
                maxLength: 1200,
                emptyFieldError: emptyReportField,
                onChanged: (value) {
                  setState(() {
                    emptyReportField = false;
                  });
                },
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (reportTitle.text.isNotEmpty &&
                    reportField.text.isNotEmpty) {
                  var rng = Random();
                  var randNum = rng.nextInt(900000) + 100000;
                  String reportID = 'RP$randNum';

                  _firestore
                      .collection('BugsReports')
                      .doc(_auth.currentUser!.uid)
                      .update({
                    'Reports': FieldValue.arrayUnion([
                      {
                        'userID': await getUserID(_auth.currentUser!.uid),
                        'userEmail': _auth.currentUser!.email,
                        'reportTitle': reportTitle.text,
                        'reportDescription': reportField.text,
                        'Date': DateTime.now(),
                        'reportID': reportID,
                      }
                    ])
                  });

                  reportTitle.clear();
                  reportField.clear();
                  displaySnackbar(context, 'Report sent.', fifthLayerColor);
                } else {
                  displaySnackbar(context,
                      'Fill all the following fields first.', fifthLayerColor);
                  setState(() {
                    if (reportTitle.text.isEmpty) {
                      emptyTitle = true;
                    }
                    if (reportField.text.isEmpty) {
                      emptyReportField = true;
                    }
                  });
                }
              },
              child: const Text('Send Report'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await InternetAddress.lookup('example.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      Navigator.pushNamed(context, MyReports.id);
                    }
                  } on SocketException catch (_) {
                    displaySnackbar(context, 'Check your internet connection.',
                        fifthLayerColor);
                  }
                },
                child: const Text('My Reports'))
          ],
        )
      ],
    );
  }
}
