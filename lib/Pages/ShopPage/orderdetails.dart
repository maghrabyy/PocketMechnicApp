import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.orderID}) : super(key: key);
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('Orders')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot ordersSnapshot) {
          if (!ordersSnapshot.hasData) {
            return const Center(
                child: SpinKitFadingFour(
              color: fifthLayerColor,
            ));
          } else {
            List ordersList = ordersSnapshot.data['ordersList'];
            List orderItems = [];
            Timestamp orderDate = Timestamp(0, 0);
            String orderStatus = '';
            String paymentMethod = '';
            int totalPrice = 0;
            int shippingFees = 0;
            String city = '';
            String address1 = '';
            String address2 = '';
            for (var map in ordersList) {
              if (map?.containsKey('orderID') ?? false) {
                if (map!['orderID'] == orderID) {
                  orderItems = map['Items'];
                  orderDate = map['Date'];
                  orderStatus = map['orderStatus'];
                  paymentMethod = map['paymentMethod'];
                  totalPrice = map['totalPrice'];
                  shippingFees = map['shippingFees'];
                  city = map['addressDetails']['city'];
                  address1 = map['addressDetails']['address1'];
                  address2 = map['addressDetails']['address2'];
                }
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: orderItems.reversed.map<Wrap>((dynamic value) {
                    return Wrap(children: [
                      StreamBuilder(
                          stream: _firestore
                              .collection('sparePartProducts')
                              .doc(value['productID'])
                              .snapshots(),
                          builder: (context, AsyncSnapshot productSnapshot) {
                            if (!productSnapshot.hasData) {
                              return const Center(
                                  child: SpinKitFadingFour(
                                color: fifthLayerColor,
                              ));
                            } else {
                              int priceMultiedByQauntity =
                                  productSnapshot.data['productPrice'] *
                                      value['selectedQuantity'];
                              return ListTile(
                                  leading: Image(
                                      width: 50,
                                      image: AssetImage(productSnapshot
                                          .data['productImage'])),
                                  trailing: Text(
                                    '${priceMultiedByQauntity.toString()} EGP',
                                  ),
                                  title: Text(
                                      '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']} x ${value['selectedQuantity'].toString()}'));
                            }
                          }),
                    ]);
                  }).toList()),
                ),
                const Divider(
                  color: fifthLayerColor,
                  indent: 15,
                  endIndent: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Shipping Fees: $shippingFees EGP'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Total Price: $totalPrice EGP'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Order Status: $orderStatus'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Payment Method: $paymentMethod'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                      'Date: ${DateTime.parse(orderDate.toDate().toString())}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(address2 == ''
                      ? 'Deliver To: $address1, $city'
                      : 'Deliver To: $address1, $address2, $city'),
                ),
              ],
            );
          }
        });
  }
}
