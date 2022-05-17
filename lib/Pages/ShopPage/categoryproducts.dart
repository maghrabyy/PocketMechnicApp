import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/Components/img_content.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Pages/ShopPage/productPage.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _firestore = FirebaseFirestore.instance;

class CategoryProducts extends StatelessWidget {
  const CategoryProducts(
      {Key? key, required this.category, required this.pageTitle})
      : super(key: key);
  final String category;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('sparePartProducts')
          .where('categoryName', isEqualTo: category)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: SpinKitFadingFour(
            color: fifthLayerColor,
          ));
        } else {
          List productList = snapshot.data.docs;
          if (productList.isEmpty) {
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
            return GridView.count(
              crossAxisCount: 2,
              children: productList.map<Wrap>((dynamic value) {
                return Wrap(children: [
                  RoundedButtonContainer(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => NavigatingPage(
                                    title: pageTitle,
                                    actions: shopAppBarActions(context),
                                    page: ProductPage(
                                        productID: value['productID'])))));
                      },
                      boxColor: thirdLayerColor,
                      child: ImgContent(
                        imgSrc: value['productImage'],
                        imgHeight: 80,
                        textSize: 25,
                        content: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${value['productBrand']} ${value['productName']}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20, color: textColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.circle,
                                    size: 15,
                                    color: value['productAvailability'] == true
                                        ? Colors.green
                                        : Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            Text('${value['productPrice'].toString()} EGP',
                                style: const TextStyle(
                                    fontSize: 20, color: textColor)),
                            Text(
                                value['productAvailability'] == true
                                    ? 'In Stock'
                                    : 'Out Stock',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: value['productAvailability'] == true
                                        ? Colors.green
                                        : Colors.redAccent)),
                          ],
                        ),
                      )),
                ]);
              }).toList(),
            );
          }
        }
      },
    );
  }
}
