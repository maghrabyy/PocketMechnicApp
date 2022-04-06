import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/Pages/ShopPage/productPage.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class FavouriteSparePartItems extends StatelessWidget {
  const FavouriteSparePartItems({Key? key}) : super(key: key);
  static const String id = 'FavouriteItemsPage';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('sparePartFavourites')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot favProdsSnapshot) {
        if (!favProdsSnapshot.hasData) {
          return const Center(
              child: SpinKitFadingFour(
            color: fifthLayerColor,
          ));
        } else {
          List favProducts = favProdsSnapshot.data['favouriteProducts'];
          if (favProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.pageview,
                    size: 100,
                  ),
                  Text(
                    'There\'s no items found here.',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: favProducts.reversed.map<Padding>((dynamic value) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                        stream: _firestore
                            .collection('sparePartProducts')
                            .doc(value)
                            .snapshots(),
                        builder: (context, AsyncSnapshot productSnapshot) {
                          if (!productSnapshot.hasData) {
                            return const Center(
                                child: SpinKitFadingFour(
                              color: fifthLayerColor,
                            ));
                          } else {
                            return MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => NavigatingPage(
                                            title:
                                                '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']}',
                                            page: ProductPage(
                                                productID: productSnapshot
                                                    .data['productID'])))));
                              },
                              color: fourthLayerColor,
                              splashColor: fifthLayerColor,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                        image: AssetImage(
                                          productSnapshot.data['productImage'],
                                        ),
                                        height: 50,
                                      ),
                                    ),
                                    Text(
                                      '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']}',
                                      style: const TextStyle(
                                          fontSize: 20, color: textColor),
                                    ),
                                    Column(children: [
                                      Text(
                                          '${productSnapshot.data['productPrice'].toString()} EGP',
                                          style: const TextStyle(
                                              fontSize: 20, color: textColor)),
                                      Text(
                                          productSnapshot.data[
                                                      'productAvailability'] ==
                                                  true
                                              ? 'In Stock'
                                              : 'Out Stock',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: productSnapshot.data[
                                                          'productAvailability'] ==
                                                      true
                                                  ? Colors.green
                                                  : Colors.redAccent)),
                                    ])
                                  ]),
                            );
                          }
                        }),
                  );
                }).toList(),
              ),
            );
          }
        }
      },
    );
  }
}
