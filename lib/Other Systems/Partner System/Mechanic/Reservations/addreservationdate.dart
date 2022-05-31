import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import '../../../../Components/rounded_buttoncontainer.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

enum ReservationDates { today, tomorrow, twoDaysLater, other }

class AddReservations extends StatefulWidget {
  const AddReservations({Key? key}) : super(key: key);

  @override
  State<AddReservations> createState() => _AddReservationsState();
}

class _AddReservationsState extends State<AddReservations> {
  ReservationDates? selectedDate;
  DateTime? pickedDate;
  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');
  bool selectedOtherDate = false;

  Future pickOtherDate(context) async {
    final initialDate = _currentDate;
    final newDate = await showDatePicker(
        context: context,
        initialDate: pickedDate ?? initialDate,
        firstDate: DateTime(_currentDate.day + 2),
        lastDate: DateTime(_currentDate.year + 5));
    if (newDate == null) return;
    setState(() {
      pickedDate = newDate;
    });
  }

  Future pickStartTime(context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
        context: context, initialTime: pickedStartTime ?? initialTime);
    if (newTime == null) return;
    setState(() {
      pickedStartTime = newTime;
    });
  }

  Future pickEndTime(context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
        context: context, initialTime: pickedEndTime ?? initialTime);
    if (newTime == null) return;
    setState(() {
      pickedEndTime = newTime;
    });
  }

  String timeTextFormat(TimeOfDay pickedTime) {
    final hours = pickedTime.hour.toString().padLeft(2, '0');
    final minutes = pickedTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    final twoDaysDate = _currentDate.add(const Duration(days: 2));
    String twoDaysLateDate =
        '${_dayFormatter.format(twoDaysDate)} ${_monthFormatter.format(twoDaysDate)}';
    if (selectedDate == ReservationDates.other) {
      setState(() {
        selectedOtherDate = true;
      });
    } else {
      setState(() {
        selectedOtherDate = false;
      });
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = ReservationDates.today;
                    });
                  },
                  child: const Text('Today'),
                  style: ElevatedButton.styleFrom(
                      primary: selectedDate == ReservationDates.today
                          ? thirdLayerColor
                          : fifthLayerColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = ReservationDates.tomorrow;
                    });
                  },
                  child: const Text('Tomorrow'),
                  style: ElevatedButton.styleFrom(
                      primary: selectedDate == ReservationDates.tomorrow
                          ? thirdLayerColor
                          : fifthLayerColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = ReservationDates.twoDaysLater;
                    });
                  },
                  child: Text(twoDaysLateDate),
                  style: ElevatedButton.styleFrom(
                      primary: selectedDate == ReservationDates.twoDaysLater
                          ? thirdLayerColor
                          : fifthLayerColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = ReservationDates.other;
                    });
                  },
                  child: const Text('Other'),
                  style: ElevatedButton.styleFrom(
                      primary: selectedDate == ReservationDates.other
                          ? thirdLayerColor
                          : fifthLayerColor),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: RoundedButtonContainer(
            onPressed: () {
              pickStartTime(context);
            },
            boxColor: fifthLayerColor,
            height: 35,
            child: Center(
              child: Text(
                pickedStartTime == null
                    ? 'Click here to set starting time'
                    : timeTextFormat(pickedStartTime!),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: RoundedButtonContainer(
            onPressed: () {
              pickEndTime(context);
            },
            boxColor: fifthLayerColor,
            height: 35,
            child: Center(
              child: Text(
                pickedEndTime == null
                    ? 'Click here to set ending time'
                    : timeTextFormat(pickedEndTime!),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedOtherDate,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: RoundedButtonContainer(
              onPressed: () {
                pickOtherDate(context);
              },
              boxColor: fifthLayerColor,
              height: 35,
              child: Center(
                child: Text(
                  pickedDate == null
                      ? 'Click here to set specific date'
                      : '${_dayFormatter.format(pickedDate!)} ${_monthFormatter.format(pickedDate!)}, ${pickedDate!.year}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: ElevatedButton(
            onPressed: () async {
              var rng = Random();
              var randNum = rng.nextInt(9000000) + 1000000;
              String resID = 'RES$randNum';
              if (selectedDate != null) {
                if (selectedDate == ReservationDates.other) {
                  if (pickedStartTime != null &&
                      pickedEndTime != null &&
                      pickedDate != null) {
                    _firestore.collection('reservationDates').doc(resID).set({
                      'bookedBy': '',
                      'booked': false,
                      'reservationID': resID,
                      'partnerID': await getPartnerID(_auth.currentUser!.uid),
                      'from': timeTextFormat(pickedStartTime!),
                      'until': timeTextFormat(pickedEndTime!),
                      'date': pickedDate
                    });
                    Navigator.pop(context);
                    displaySnackbar(
                        context, 'Reservation date added.', fifthLayerColor);
                  } else {
                    if (pickedStartTime == null) {
                      displaySnackbar(context, 'Pick a starting time first.',
                          fifthLayerColor);
                    }
                    if (pickedEndTime == null) {
                      displaySnackbar(context, 'Pick an ending time first.',
                          fifthLayerColor);
                    }
                    if (pickedDate == null) {
                      displaySnackbar(
                          context, 'Pick a date first.', fifthLayerColor);
                    }
                  }
                } else {
                  if (pickedStartTime != null && pickedEndTime != null) {
                    if (selectedDate == ReservationDates.today) {
                      _firestore.collection('reservationDates').doc(resID).set({
                        'bookedBy': '',
                        'booked': false,
                        'reservationID': resID,
                        'partnerID': await getPartnerID(_auth.currentUser!.uid),
                        'from': timeTextFormat(pickedStartTime!),
                        'until': timeTextFormat(pickedEndTime!),
                        'date': DateTime.now()
                      });
                      Navigator.pop(context);
                      displaySnackbar(
                          context, 'Reservation date added.', fifthLayerColor);
                    } else if (selectedDate == ReservationDates.tomorrow) {
                      _firestore.collection('reservationDates').doc(resID).set({
                        'bookedBy': '',
                        'booked': false,
                        'reservationID': resID,
                        'partnerID': await getPartnerID(_auth.currentUser!.uid),
                        'from': timeTextFormat(pickedStartTime!),
                        'until': timeTextFormat(pickedEndTime!),
                        'date': DateTime.now().add(const Duration(days: 1))
                      });
                      Navigator.pop(context);
                      displaySnackbar(
                          context, 'Reservation date added.', fifthLayerColor);
                    } else if (selectedDate == ReservationDates.twoDaysLater) {
                      _firestore.collection('reservationDates').doc(resID).set({
                        'bookedBy': '',
                        'booked': false,
                        'reservationID': resID,
                        'partnerID': await getPartnerID(_auth.currentUser!.uid),
                        'from': timeTextFormat(pickedStartTime!),
                        'until': timeTextFormat(pickedEndTime!),
                        'date': DateTime.now().add(const Duration(days: 2))
                      });
                      Navigator.pop(context);
                      displaySnackbar(
                          context, 'Reservation date added.', fifthLayerColor);
                    }
                  } else {
                    if (pickedStartTime == null) {
                      displaySnackbar(context, 'Pick a starting time first.',
                          fifthLayerColor);
                    }
                    if (pickedEndTime == null) {
                      displaySnackbar(context, 'Pick an ending time first.',
                          fifthLayerColor);
                    }
                  }
                }
              } else {
                displaySnackbar(context, 'Pick a date first.', fifthLayerColor);
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40)),
            child: const Text(
              'Add date',
            ),
          ),
        ),
      ],
    );
  }
}
