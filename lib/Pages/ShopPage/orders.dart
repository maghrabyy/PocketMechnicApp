import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Pages/ShopPage/orderdetails.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';
import '../../style.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class MyOrders extends StatelessWidget {
  static const String id = 'myOrders';
  const MyOrders({Key? key}) : super(key: key);

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
            if (ordersList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.shopping_basket,
                      size: 100,
                    ),
                    Text(
                      'You haven\'t placed any orders yet.',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              );
            } else {
              return Column(
                children: ordersList.reversed
                    .map<RoundedButtonContainer>((dynamic ordersvalue) {
                  List orderItems = ordersvalue['Items'];
                  return RoundedButtonContainer(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigatingPage(
                                  title: 'Order Details',
                                  page: OrderDetails(
                                    orderID: ordersvalue['orderID'],
                                  ))));
                    },
                    boxColor: fifthLayerColor,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orderItems.reversed
                            .map<Wrap>((dynamic productsValue) {
                          return Wrap(children: [
                            StreamBuilder(
                                stream: _firestore
                                    .collection('sparePartProducts')
                                    .doc(productsValue['productID'])
                                    .snapshots(),
                                builder:
                                    (context, AsyncSnapshot productSnapshot) {
                                  if (!productSnapshot.hasData) {
                                    return const Center(
                                        child: SpinKitFadingFour(
                                      color: fifthLayerColor,
                                    ));
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']} x ${productsValue['selectedQuantity'].toString()}'),
                                        Text(productsValue['totalPrice']
                                            .toString())
                                      ],
                                    );
                                  }
                                }),
                          ]);
                        }).toList(),
                      ),
                      subtitle: Text(
                          'Date: ${DateTime.parse(ordersvalue['Date'].toDate().toString())}'),
                      trailing: Column(
                        children: [
                          Text('Status: ${ordersvalue['orderStatus']}'),
                          Text('Total: ${ordersvalue['totalPrice']}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }
        });
  }
}
