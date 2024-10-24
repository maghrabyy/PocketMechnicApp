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
                    Icons.favorite_outline_outlined,
                    size: 100,
                  ),
                  Text(
                    'No items found in your favourites.',
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
                            String categoryPageTitle() {
                              switch (productSnapshot.data['categoryName']) {
                                case 'EngineAndOil':
                                  return 'Engine And Oil shop';

                                case 'AirFilter':
                                  return 'Air Filter shop';

                                case 'CarBattery':
                                  return 'Car Battery shop';

                                case 'BrakePads':
                                  return 'Brake Pads shop';

                                case 'Tires':
                                  return 'Tires shop';

                                case 'Alternator':
                                  return 'Alternator shop';

                                case 'Radiator':
                                  return 'Radiator shop';

                                case 'Accessories':
                                  return 'Accessories shop';
                                default:
                                  return 'Unknown';
                              }
                            }

                            return MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => NavigatingPage(
                                            title: categoryPageTitle(),
                                            actions: shopAppBarActions(context),
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
                                    Expanded(
                                      child: Text(
                                        '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20, color: textColor),
                                      ),
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
