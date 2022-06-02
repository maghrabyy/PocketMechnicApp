import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/circlebutton.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:flutter_course/Pages/nearbyMechanic/bookdate.dart';
import 'package:flutter_course/Pages/nearbyMechanic/partnerreviews.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Services/GoogleMaps/googlemapsservice.dart';
import 'package:flutter/services.dart';

final _firestore = FirebaseFirestore.instance;

class NearbyMechanic extends StatefulWidget {
  const NearbyMechanic({Key? key}) : super(key: key);

  @override
  State<NearbyMechanic> createState() => _NearbyMechanicState();
}

class _NearbyMechanicState extends State<NearbyMechanic> {
  bool mechanicPressed = false;
  String mechanicContactNum = '';
  List mechanicReviews = [];
  String partnerID = '';
  bool isPartnerAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              const GoogleMapAPI(),
              Visibility(
                visible: mechanicPressed,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MechanicAction(
                        text: 'Contact',
                        icon: Icons.contact_phone,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: fifthLayerColor,
                                    title: const Text(
                                      'Contact Number',
                                      style: TextStyle(color: textColor),
                                    ),
                                    content: Text('[+20] $mechanicContactNum'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            if (isPartnerAvailable == true) {
                                              final Uri _phoneURL = Uri.parse(
                                                  'tel:$mechanicContactNum');
                                              await launchUrl(_phoneURL);
                                            } else {
                                              displaySnackbar(
                                                  context,
                                                  'Mechanic is currently unavailable.',
                                                  fifthLayerColor);
                                            }
                                          },
                                          child: const Text(
                                            'Call',
                                            style: TextStyle(color: textColor),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            displaySnackbar(
                                                context,
                                                'Added to clipboard',
                                                fifthLayerColor);
                                            Clipboard.setData(ClipboardData(
                                                text: mechanicContactNum));
                                          },
                                          child: const Text(
                                            'Copy',
                                            style: TextStyle(color: textColor),
                                          )),
                                    ],
                                  ));
                        },
                      ),
                      MechanicAction(
                        text: 'Navigation',
                        icon: Icons.navigation,
                        onPressed: () {},
                      ),
                      MechanicAction(
                        text: 'Book a date',
                        icon: Icons.book,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigatingPage(
                                  title: 'Book a date',
                                  page: MechanicBookDate(
                                    reservationsPartnerID: partnerID,
                                  )),
                            ),
                          );
                        },
                      ),
                      MechanicAction(
                        text: 'Reviews (${mechanicReviews.length})',
                        icon: Icons.reviews,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NavigatingPage(
                                        title: 'Reviews',
                                        page: PartnerReview(
                                          reviewsPartnerID: partnerID,
                                        ),
                                      ))));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: _firestore
                .collection('Partners')
                .where('partnerType', isEqualTo: 'Mechanic')
                .snapshots(),
            builder: (context, AsyncSnapshot partnerSnapshot) {
              if (!partnerSnapshot.hasData) {
                return const Center(
                    child: SpinKitFadingFour(
                  color: fifthLayerColor,
                ));
              } else {
                List mechanicsList = partnerSnapshot.data.docs;
                mechanicsList.sort((a, b) {
                  if (b['available']) {
                    return 1;
                  }
                  return -1;
                });
                return IntrinsicHeight(
                  child: Row(
                      children: mechanicsList
                          .map<RoundedButtonContainer>((dynamic value) {
                    int avgRateToStars(double avgRate) {
                      if (avgRate <= 0.5) {
                        return 0;
                      } else if (avgRate <= 1.5) {
                        return 1;
                      } else if (avgRate <= 2.5) {
                        return 2;
                      } else if (avgRate <= 3.5) {
                        return 3;
                      } else if (avgRate <= 4.5) {
                        return 4;
                      } else {
                        return 5;
                      }
                    }

                    return RoundedButtonContainer(
                        boxColor: thirdLayerColor,
                        onPressed: () {
                          setState(() {
                            mechanicContactNum = value['contactNumber'];
                            mechanicReviews = value['reviews'];
                            partnerID = value['partnerID'];
                            mechanicPressed = !mechanicPressed;
                            isPartnerAvailable = value['available'];
                          });
                        },
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.car_repair_rounded,
                                color: value['available'] == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              Text(value['serviceName']),
                              value['ratingAverage'] > 0
                                  ? SizedBox(
                                      width: 100,
                                      height: 20,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: avgRateToStars(
                                              value['ratingAverage']
                                                  .toDouble()),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const Center(
                                              child: Icon(
                                                Icons.star,
                                                size: 20,
                                              ),
                                            );
                                          }),
                                    )
                                  : const Text('No rates'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value['serviceAddress.addressName'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const TextDivider(text: Text('Working hours')),
                              Text(value['workingHours.open'] == '' &&
                                      value['workingHours.close'] == ''
                                  ? 'Not specified'
                                  : value['workingHours.open'] !=
                                          value['workingHours.close']
                                      ? 'From: ${value['workingHours.open']} To: ${value['workingHours.close']}'
                                      : '24/7')
                            ],
                          ),
                        ));
                  }).toList()),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class MechanicAction extends StatefulWidget {
  const MechanicAction(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<MechanicAction> createState() => _MechanicActionState();
}

class _MechanicActionState extends State<MechanicAction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: fourthLayerColor,
          ),
        ),
        CircleButton(
          hint: widget.text,
          radius: 10,
          child: Icon(
            widget.icon,
            size: 25,
          ),
          onPressed: widget.onPressed,
          color: fifthLayerColor,
        ),
      ],
    );
  }
}
