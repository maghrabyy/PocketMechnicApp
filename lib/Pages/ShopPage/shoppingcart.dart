import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Pages/ShopPage/placeorder.dart';
import 'package:flutter_course/Pages/ShopPage/productPage.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ShoppingCart extends StatefulWidget {
  static const String id = 'ShoppingCartPage';
  const ShoppingCart({
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            int subTotalwithoutShipping() {
              if (cartList.isNotEmpty) {
                return cartList.map<int>((m) {
                  return int.parse(m['totalPrice'].toString());
                }).reduce((a, b) => a + b);
              } else {
                return 0;
              }
            }

            int shippingFees = 50;
            int subTotal = subTotalwithoutShipping() + shippingFees;
            if (cartList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      size: 100,
                    ),
                    Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
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
                                  String categoryPageTitle() {
                                    switch (
                                        productSnapshot.data['categoryName']) {
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

                                  return RoundedButtonContainer(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  NavigatingPage(
                                                      title:
                                                          categoryPageTitle(),
                                                      actions:
                                                          shopAppBarActions(
                                                              context),
                                                      page: ProductPage(
                                                          productID: value[
                                                              'productID'])))));
                                    },
                                    boxColor: thirdLayerColor,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                              image: AssetImage(productSnapshot
                                                  .data['productImage'])),
                                        )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    '${productSnapshot.data['productBrand']} ${productSnapshot.data['productName']}',
                                                    textAlign:
                                                        TextAlign.center),
                                                const Divider(
                                                  color: fifthLayerColor,
                                                  indent: 15,
                                                  endIndent: 15,
                                                ),
                                                Text(
                                                    'Price: ${productSnapshot.data['productPrice'].toString()}x${value['selectedQuantity'].toString()} EGP',
                                                    textAlign:
                                                        TextAlign.center),
                                                const Divider(
                                                  color: fifthLayerColor,
                                                  indent: 15,
                                                  endIndent: 15,
                                                ),
                                                Text(
                                                    'Total Price: ${value['totalPrice'].toString()} EGP',
                                                    textAlign:
                                                        TextAlign.center),
                                                const Divider(
                                                  color: fifthLayerColor,
                                                  indent: 15,
                                                  endIndent: 15,
                                                ),
                                                Text(
                                                  'Description: ${productSnapshot.data['productDescription']}',
                                                  textAlign: TextAlign.center,
                                                ),
                                                //   quantitySelection()
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              _firestore
                                                  .collection('shoppingCart')
                                                  .doc(_auth.currentUser!.uid)
                                                  .update({
                                                'Cart': FieldValue.arrayRemove([
                                                  {
                                                    'productID':
                                                        value['productID'],
                                                    'selectedQuantity': value[
                                                        'selectedQuantity'],
                                                    'totalPrice':
                                                        value['totalPrice'],
                                                  }
                                                ])
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 30,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ]);
                      }).toList()),
                    ),
                  ),
                  Container(
                    color: secondLayerColor,
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavigatingPage(
                                              title: 'Place Order',
                                              page: PlaceOrderPage(
                                                subTotal: subTotal,
                                                shippingFees: shippingFees,
                                              ))));
                                },
                                child: const Text('Check Out')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 10, top: 8, bottom: 8),
                          child: Column(
                            children: [
                              Text('Shipping Fees $shippingFees EGP'),
                              Text('Total ${subTotal.toString()} EGP'),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }
        });
  }
}
