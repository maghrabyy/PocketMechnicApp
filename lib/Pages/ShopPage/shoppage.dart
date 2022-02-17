import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  static const String id = 'ShopPage';
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Shop'));
  }
}
