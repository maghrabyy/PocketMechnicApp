import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/circlebutton.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../main.dart';
import '../nearbyMechanic/partnerreviews.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

class TowTruckDrivers extends StatelessWidget {
  static const String id = 'TowTruckDrivers';
  const TowTruckDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('Partners')
            .where('partnerType', isEqualTo: 'Tow Truck')
            .snapshots(),
        builder: (context, AsyncSnapshot partnerSnapshot) {
          if (!partnerSnapshot.hasData) {
            return const Center(
                child: SpinKitFadingFour(
              color: fifthLayerColor,
            ));
          } else {
            List towTruckDriversList = partnerSnapshot.data.docs;
            towTruckDriversList.sort((a, b) {
              if (b['available']) {
                return 1;
              }
              return -1;
            });
            return SingleChildScrollView(
              child: Column(
                  children: towTruckDriversList.map<Card>((dynamic value) {
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

                return Card(
                  child: ExpansionTile(
                      backgroundColor: fifthLayerColor,
                      collapsedBackgroundColor: fifthLayerColor,
                      textColor: textColor,
                      collapsedIconColor: iconColor,
                      iconColor: iconColor,
                      children: [
                        ListTile(
                          title: Text(
                            '[+20] ${value['contactNumber']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: CircleButton(
                            color: value['available'] == true
                                ? Colors.green
                                : Colors.red,
                            radius: 8,
                            onPressed: () async {
                              final Uri _phoneURL =
                                  Uri.parse('tel: ${value['contactNumber']}');
                              if (value['available'] == true) {
                                await launchUrl(_phoneURL);
                              } else {
                                displaySnackbar(
                                    context,
                                    'Tow-Truck driver is currently unavailable.',
                                    fifthLayerColor);
                              }
                            },
                            child: const Icon(Icons.call, size: 20),
                            hint: 'Call',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Reviews:',
                              style: TextStyle(fontSize: 18),
                            ),
                            value['ratingAverage'] > 0
                                ? SizedBox(
                                    width: 100,
                                    height: 20,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: avgRateToStars(
                                            value['ratingAverage'].toDouble()),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const Center(
                                            child: Icon(
                                              Icons.star,
                                              size: 20,
                                            ),
                                          );
                                        }),
                                  )
                                : const Text(
                                    'No rates',
                                    style: TextStyle(fontSize: 18),
                                  ),
                            Text(' (${value['reviews'].length})'),
                            CircleButton(
                              color: Colors.blueGrey,
                              radius: 8,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => NavigatingPage(
                                              title: 'Reviews',
                                              page: PartnerReview(
                                                reviewsPartnerID:
                                                    value['partnerID'],
                                              ),
                                            ))));
                              },
                              child: const Icon(Icons.reviews, size: 20),
                              hint: 'Reviews',
                            )
                          ],
                        )
                      ],
                      title: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                          child: CircleAvatar(
                            backgroundColor: value['available'] == true
                                ? Colors.green
                                : Colors.red,
                            foregroundColor: iconColor,
                            radius: 35,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(
                                FontAwesomeIcons.truckPickup,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                        title: Text(value['serviceName']),
                        subtitle: Text(value['workingHours.open'] == '' &&
                                value['workingHours.close'] == '' &&
                                value['workingHours.open'] == ''
                            ? 'Working hours not specified'
                            : value['workingHours.open'] !=
                                    value['workingHours.close']
                                ? 'From ${value['workingHours.open']} to ${value['workingHours.close']}'
                                : '24/7'),
                      )),
                );
              }).toList()),
            );
          }
        });
  }
}
