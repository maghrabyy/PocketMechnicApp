import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Components/textdivider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Pages/ShopPage/orderdetails.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

enum PaymentMethods { cashOnDelivery, debitCreditCard, pos }

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage(
      {Key? key, required this.subTotal, required this.shippingFees})
      : super(key: key);
  final int subTotal;
  final int shippingFees;

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  TextEditingController cityInput = TextEditingController();
  bool emptyCity = false;
  TextEditingController address1Input = TextEditingController();
  bool emptyyAddress1 = false;
  TextEditingController address2Input = TextEditingController();
  PaymentMethods? paymentMethodController = PaymentMethods.cashOnDelivery;
  bool saveAddress = false;
  bool modifySavedAddress = false;
  placeOrder(String city, String address1, String address2) async {
    if (paymentMethodController == PaymentMethods.cashOnDelivery) {
      List myCart = [];
      await _firestore
          .collection('shoppingCart')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => myCart = value['Cart']);
      var rng = Random();
      var randNum = rng.nextInt(900000) + 100000;
      String orderID = 'Ord$randNum';
      String paymentMethodToString() {
        if (paymentMethodController == PaymentMethods.cashOnDelivery) {
          return 'Cash on Delivery';
        } else if (paymentMethodController == PaymentMethods.debitCreditCard) {
          return 'Debit/Credit Card';
        } else {
          return 'Machine on delivery (POS)';
        }
      }

      _firestore.collection('Orders').doc(_auth.currentUser!.uid).update({
        'ordersList': FieldValue.arrayUnion([
          {
            'Date': DateTime.now(),
            'Items': myCart,
            'addressDetails': {
              'address1': address1,
              'address2': address2,
              'city': city,
            },
            'orderID': orderID,
            'orderStatus': 'In-Progress',
            'paymentMethod': paymentMethodToString(),
            'shippingFees': widget.shippingFees,
            'totalPrice': widget.subTotal
          }
        ])
      });
      _firestore
          .collection('shoppingCart')
          .doc(_auth.currentUser!.uid)
          .update({'Cart': []});
      if (saveAddress == true) {
        await _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .update({
          'address': {
            'address1': address1Input.text,
            'address2': address2Input.text,
            'city': cityInput.text,
          }
        });
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NavigatingPage(
                  title: 'Order Details',
                  page: OrderDetails(
                    orderID: orderID,
                  ))));
      displaySnackbar(context, 'Order placed successfully.', fifthLayerColor);
    } else {
      displaySnackbar(
          context, 'This payment isn\'t available yet.', fifthLayerColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> modifyAddress = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RegularInput(
          label: 'City',
          inputController: cityInput,
          maxLength: 30,
          emptyFieldError: emptyCity,
          onChanged: (value) {
            setState(() {
              emptyCity = false;
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RegularInput(
          label: 'Address 1',
          inputController: address1Input,
          maxLength: 80,
          emptyFieldError: emptyyAddress1,
          onChanged: (value) {
            setState(() {
              emptyyAddress1 = false;
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RegularInput(
          label: 'Address 2',
          inputController: address2Input,
          maxLength: 80,
        ),
      ),
      CheckboxListTile(
          title: const Text('Save Address'),
          value: saveAddress,
          onChanged: (value) {
            setState(() {
              saveAddress = value!;
            });
          }),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TextDivider(text: Text('Address Details')),
                StreamBuilder(
                    stream: _firestore
                        .collection('Users')
                        .doc(_auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot userSnapshot) {
                      if (!userSnapshot.hasData) {
                        return const Center(
                            child: SpinKitFadingFour(
                          color: fifthLayerColor,
                        ));
                      } else {
                        if (userSnapshot.data['address'] == '') {
                          return Column(children: modifyAddress);
                        } else {
                          String address1 =
                              userSnapshot.data['address']['address1'];
                          String address2 =
                              userSnapshot.data['address']['address2'];
                          String city = userSnapshot.data['address']['city'];
                          return ExpansionTile(
                            iconColor: iconColor,
                            textColor: textColor,
                            collapsedIconColor: iconColor,
                            onExpansionChanged: (exp) {
                              modifySavedAddress = exp;
                            },
                            trailing: const Icon(
                              Icons.edit,
                              size: 30,
                            ),
                            title: Text(address2 == ''
                                ? 'Deliver To: $address1, $city'
                                : 'Deliver To: $address1, $address2, $city'),
                            children: modifyAddress,
                          );
                        }
                      }
                    }),
                const TextDivider(text: Text('Payment Method')),
                ListTile(
                  title: const Text('Cash on delivery'),
                  trailing: Radio<PaymentMethods>(
                    value: PaymentMethods.cashOnDelivery,
                    groupValue: paymentMethodController,
                    onChanged: (PaymentMethods? value) {
                      setState(() {
                        paymentMethodController = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Debit/Credit Card'),
                  trailing: Radio<PaymentMethods>(
                    value: PaymentMethods.debitCreditCard,
                    groupValue: paymentMethodController,
                    onChanged: (PaymentMethods? value) {
                      setState(() {
                        paymentMethodController = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Machine on delivery (POS)'),
                  trailing: Radio<PaymentMethods>(
                    value: PaymentMethods.pos,
                    groupValue: paymentMethodController,
                    onChanged: (PaymentMethods? value) {
                      setState(() {
                        paymentMethodController = value;
                      });
                    },
                  ),
                ),
                const TextDivider(text: Text('Order Summary')),
                StreamBuilder(
                    stream: _firestore
                        .collection('shoppingCart')
                        .doc(_auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot cartSnapshot) {
                      if (!cartSnapshot.hasData) {
                        return const Center(
                            child: SpinKitFadingFour(
                          color: fifthLayerColor,
                        ));
                      } else {
                        List cartList = cartSnapshot.data['Cart'];
                        return Column(
                            children:
                                cartList.reversed.map<Wrap>((dynamic value) {
                          return Wrap(children: [
                            StreamBuilder(
                                stream: _firestore
                                    .collection('sparePartProducts')
                                    .doc(value['productID'])
                                    .snapshots(),
                                builder:
                                    (context, AsyncSnapshot productSnapshot) {
                                  if (!productSnapshot.hasData) {
                                    return const Center(
                                        child: SpinKitFadingFour(
                                      color: fifthLayerColor,
                                    ));
                                  } else {
                                    return ListTile(
                                        leading: Image(
                                            width: 50,
                                            image: AssetImage(productSnapshot
                                                .data['productImage'])),
                                        trailing: Text(
                                          productSnapshot.data['productPrice']
                                              .toString(),
                                        ),
                                        title: Text(
                                            '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']} x ${value['selectedQuantity'].toString()}'));
                                  }
                                }),
                          ]);
                        }).toList());
                      }
                    }),
                const Divider(
                  color: fifthLayerColor,
                  indent: 100,
                  endIndent: 100,
                ),
                ListTile(
                    trailing: Text(
                      widget.shippingFees.toString(),
                    ),
                    title: const Text("Shipping Fees")),
                ListTile(
                    trailing: Text(
                      widget.subTotal.toString(),
                    ),
                    title: const Text("Total")),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              // ignore: prefer_typing_uninitialized_variables
              var myAddress;
              await _firestore
                  .collection('Users')
                  .doc(_auth.currentUser!.uid)
                  .get()
                  .then((value) => myAddress = value['address']);
              if (myAddress == '') {
                if (cityInput.text.isNotEmpty &&
                    address1Input.text.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              backgroundColor: fifthLayerColor,
                              title: const Text(
                                'Place order',
                                style: TextStyle(color: textColor),
                              ),
                              content: Text(
                                  'Are you sure you want to place order with a total of ${widget.subTotal}EGP?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      placeOrder(
                                          cityInput.text,
                                          address1Input.text,
                                          address2Input.text);
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
                                    ))
                              ]));
                } else {
                  displaySnackbar(context, 'Complete the following fields.',
                      fifthLayerColor);
                  if (cityInput.text.isEmpty) {
                    setState(() {
                      emptyCity = true;
                    });
                  }
                  if (address1Input.text.isEmpty) {
                    setState(() {
                      emptyyAddress1 = true;
                    });
                  }
                }
              } else {
                if (modifySavedAddress == true) {
                  if (cityInput.text.isNotEmpty &&
                      address1Input.text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                backgroundColor: fifthLayerColor,
                                title: const Text(
                                  'Place order',
                                  style: TextStyle(color: textColor),
                                ),
                                content: Text(
                                    'Are you sure you want to place order with a total of ${widget.subTotal}EGP?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        placeOrder(
                                            cityInput.text,
                                            address1Input.text,
                                            address2Input.text);
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
                                      ))
                                ]));
                  } else {
                    displaySnackbar(context, 'Complete the following fields.',
                        fifthLayerColor);
                    if (cityInput.text.isEmpty) {
                      setState(() {
                        emptyCity = true;
                      });
                    }
                    if (address1Input.text.isEmpty) {
                      setState(() {
                        emptyyAddress1 = true;
                      });
                    }
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              backgroundColor: fifthLayerColor,
                              title: const Text(
                                'Place order',
                                style: TextStyle(color: textColor),
                              ),
                              content: Text(
                                  'Are you sure you want to place order with a total of ${widget.subTotal}EGP?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      placeOrder(
                                          myAddress['city'],
                                          myAddress['address1'],
                                          myAddress['address2']);
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
                                    ))
                              ]));
                }
              }
            },
            child: const Text('Place Order'))
      ],
    );
  }
}
