import 'package:flutter/material.dart';
import '../ShopPage/shoppage.dart';

class SparePartSection extends StatefulWidget {
  const SparePartSection({Key? key}) : super(key: key);

  @override
  _SparePartSectionState createState() => _SparePartSectionState();
}

class _SparePartSectionState extends State<SparePartSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sparePartShop(context, 50, null),
      ),
    );
  }
}
