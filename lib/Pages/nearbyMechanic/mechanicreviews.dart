import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Components/rounded_container.dart';
import '../../Components/snackbar.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class MechanicReviews extends StatefulWidget {
  static const String id = 'MechanicReviews';
  const MechanicReviews({Key? key, required this.reviewsPartnerID})
      : super(key: key);
  final String reviewsPartnerID;

  @override
  State<MechanicReviews> createState() => _MechanicReviewsState();
}

class _MechanicReviewsState extends State<MechanicReviews> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Partners')
          .where('partnerID', isEqualTo: widget.reviewsPartnerID)
          .snapshots(),
      builder: (context, AsyncSnapshot partnerSnapshot) {
        if (!partnerSnapshot.hasData) {
          return const Center(
            child: SpinKitFadingFour(
              color: fifthLayerColor,
            ),
          );
        } else {
          var docs = partnerSnapshot.data.docs;
          final partner = docs[0].data()!;
          List feedbacksList = partner['reviews'];
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: feedbacksList.isEmpty
                        ? [
                            const Text(
                              'There\'s no feedbacks on this product yet.',
                              textAlign: TextAlign.center,
                            ),
                            const Text('Be the first one to submit a feedback.',
                                textAlign: TextAlign.center),
                          ]
                        : feedbacksList.map<Column>((dynamic value) {
                            return Column(
                              children: [
                                StreamBuilder(
                                    stream: _firestore
                                        .collection('Users')
                                        .where('UserID',
                                            isEqualTo: value['userID'])
                                        .snapshots(),
                                    builder:
                                        (context, AsyncSnapshot userSnapshot) {
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
                                                  fontWeight: FontWeight.bold)),
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
                  ),
                ),
              ),
              SendFeedback(partnerID: widget.reviewsPartnerID),
            ],
          );
        }
      },
    );
  }
}

class SendFeedback extends StatefulWidget {
  const SendFeedback({Key? key, required this.partnerID}) : super(key: key);
  final String partnerID;

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  int? selectedRate;
  TextEditingController feedbackController = TextEditingController();
  List rates = [0, 1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: RoundedContainer(
            boxChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextArea(
                inputController: feedbackController,
                label: 'Feedback',
                maxLength: 600,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: NoBorderDropdownMenu(
                  hint: 'Rate',
                  items: rates,
                  currentValue: selectedRate,
                  onChanged: (value) {
                    setState(() {
                      selectedRate = value!;
                    });
                  },
                  hintColor: Colors.white,
                  enabled: true),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (feedbackController.text.isNotEmpty &&
                      selectedRate != null) {
                    String partnerDocID = '';
                    await _firestore
                        .collection('Partners')
                        .where('partnerID', isEqualTo: widget.partnerID)
                        .get()
                        .then((value) {
                      // ignore: avoid_function_literals_in_foreach_calls
                      value.docs.forEach((element) {
                        partnerDocID = element.id;
                      });
                    });
                    List mechanicReviews = [];
                    _firestore
                        .collection('Partners')
                        .doc(partnerDocID)
                        .get()
                        .then((value) => mechanicReviews = value['reviews']);
                    int ratingSum() {
                      if (mechanicReviews.isNotEmpty) {
                        return mechanicReviews.map<int>((m) {
                          return int.parse(m['rate'].toString());
                        }).reduce((a, b) => a + b);
                      } else {
                        return 0;
                      }
                    }

                    await _firestore
                        .collection('Partners')
                        .doc(partnerDocID)
                        .update({
                      'reviews': FieldValue.arrayUnion([
                        {
                          'userID': await getUserID(_auth.currentUser!.uid),
                          'comment': feedbackController.text,
                          'rate': selectedRate
                        }
                      ])
                    });
                    int mechanicReviewsLength = mechanicReviews.length;
                    int mechanicRateAvg = ratingSum() ~/ mechanicReviewsLength;
                    await _firestore
                        .collection('Partners')
                        .doc(partnerDocID)
                        .update({'ratingAverage': mechanicRateAvg});
                    feedbackController.clear();
                    selectedRate = null;

                    FocusScope.of(context).unfocus();
                    displaySnackbar(
                        context, 'Feedback submitted.', fifthLayerColor);
                  } else {
                    if (feedbackController.text.isEmpty &&
                        selectedRate == null) {
                      displaySnackbar(
                          context,
                          'You\'ve to write a feedback and select a rate first.',
                          fifthLayerColor);
                    } else if (selectedRate == null) {
                      displaySnackbar(
                          context, 'Select the rate first', fifthLayerColor);
                    } else if (feedbackController.text.isEmpty) {
                      displaySnackbar(
                          context, 'Write something first', fifthLayerColor);
                    }
                  }
                },
                child: const Text('Submit Feedback')),
          ],
        )
      ],
    );
  }
}
