// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.productID}) : super(key: key);
  final String productID;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('sparePartProducts')
          .doc(widget.productID)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: SpinKitFadingFour(
            color: fifthLayerColor,
          ));
        } else {
          final List feedbacksList = snapshot.data['Feedbacks'];
          return SingleChildScrollView(
            child: Column(
              children: [
                RoundedContainer(
                  boxColor: thirdLayerColor,
                  boxChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: fifthLayerColor,
                            radius: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage(
                                      snapshot.data['productImage'])),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['productName'],
                              style: const TextStyle(fontSize: 25),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 15,
                                color:
                                    snapshot.data['productAvailability'] == true
                                        ? Colors.green
                                        : Colors.redAccent,
                              ),
                            )
                          ],
                        ),
                        Text(
                          '${snapshot.data['productPrice'].toString()} EGP',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const TextDivider(text: Text('Description')),
                        Text(
                          snapshot.data['productDescription'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Divider(
                          endIndent: 15,
                          indent: 15,
                          color: fifthLayerColor,
                        ),
                        Text(
                          'Made in: ${snapshot.data['manufacturingCountry']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Quantity: ${snapshot.data['productQuantity']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 60,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Add to cart'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40)),
                            ),
                            StreamBuilder(
                                stream: _firestore
                                    .collection('sparePartFavourites')
                                    .doc(_auth.currentUser!.uid)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot favProductsSnapshot) {
                                  if (!favProductsSnapshot.hasData) {
                                    return const SpinKitFadingFour(
                                      color: fifthLayerColor,
                                    );
                                  } else {
                                    List favouriteProducts = favProductsSnapshot
                                        .data['favouriteProducts'];
                                    var toCheck = {
                                      'productAvailability':
                                          snapshot.data['productAvailability'],
                                      'productID': snapshot.data['productID'],
                                      'productName':
                                          snapshot.data['productName'],
                                      'productPrice':
                                          snapshot.data['productPrice'],
                                    };
                                    return IconButton(
                                        onPressed: () async {
                                          //to favourite
                                          if (!favouriteProducts.any(
                                              (e) => mapEquals(e, toCheck))) {
                                            _firestore
                                                .collection(
                                                    'sparePartFavourites')
                                                .doc(_auth.currentUser!.uid)
                                                .update({
                                              'favouriteProducts':
                                                  FieldValue.arrayUnion([
                                                {
                                                  'productName': snapshot
                                                      .data['productName'],
                                                  'productID': snapshot
                                                      .data['productID'],
                                                  'productPrice': snapshot
                                                      .data['productPrice'],
                                                  'productAvailability':
                                                      snapshot.data[
                                                          'productAvailability']
                                                }
                                              ])
                                            });
                                          }
                                          //to unfavourite
                                          else {
                                            _firestore
                                                .collection(
                                                    'sparePartFavourites')
                                                .doc(_auth.currentUser!.uid)
                                                .update({
                                              'favouriteProducts':
                                                  FieldValue.arrayRemove([
                                                {
                                                  'productName': snapshot
                                                      .data['productName'],
                                                  'productID': snapshot
                                                      .data['productID'],
                                                  'productPrice': snapshot
                                                      .data['productPrice'],
                                                  'productAvailability':
                                                      snapshot.data[
                                                          'productAvailability']
                                                }
                                              ])
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          favouriteProducts.any(
                                                  (e) => mapEquals(e, toCheck))
                                              ? FontAwesomeIcons.solidHeart
                                              : FontAwesomeIcons.heart,
                                          color: favouriteProducts.any(
                                                  (e) => mapEquals(e, toCheck))
                                              ? Colors.redAccent
                                              : iconColor,
                                          size: 35,
                                        ));
                                  }
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                RoundedContainer(
                  boxColor: thirdLayerColor,
                  boxChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const TextDivider(text: Text('Reviews')),
                        Column(
                          children: feedbacksList.isEmpty
                              ? [
                                  const Text(
                                      'There\'s no feedbacks on this product yet.'),
                                  const Text(
                                      'Be the first one to submit a feedback.'),
                                ]
                              : feedbacksList.map<Column>((dynamic value) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Text(
                                            '(${value['Rating'].toString()}/5)'),
                                        title: Text(value['FullName'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                            )),
                                        subtitle: Text(value['Comment'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const Divider(
                                        color: fifthLayerColor,
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                    ],
                                  );
                                }).toList(),
                        ),
                        SendFeedback(
                          prodID: widget.productID,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class SendFeedback extends StatefulWidget {
  const SendFeedback({Key? key, required this.prodID}) : super(key: key);
  final String prodID;

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
                    _firestore
                        .collection('sparePartProducts')
                        .doc(widget.prodID)
                        .update({
                      'Feedbacks': FieldValue.arrayUnion([
                        {
                          'FullName': _auth.currentUser!.displayName,
                          'userID': await getUserID(_auth.currentUser!.uid),
                          'Comment': feedbackController.text,
                          'Rating': selectedRate
                        }
                      ])
                    });
                    feedbackController.clear();
                    selectedRate = null;
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
