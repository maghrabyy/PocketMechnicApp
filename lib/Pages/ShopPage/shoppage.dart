import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/ShopPage/categoryproducts.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/img_content.dart';
import '../../Components/rounded_buttoncontainer.dart';

navigateToCategory(
    BuildContext context, String pageTitle, String categoryName) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: ((context) => NavigatingPage(
              title: pageTitle,
              page: CategoryProducts(category: categoryName)))));
}

List<Widget> sparePartShop(
    BuildContext context, double imageHeight, double? textSize) {
  return [
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Engine And Oil', 'EngineAndOil');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carEngine.png',
            imgText: 'Engine and Oil')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Air Filter', 'AirFilter');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/airFilter.png',
            imgText: 'Air Filter')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Car Battery', 'CarBattery');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carBattery.png',
            imgText: 'Car Battery')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Brake Pads', 'BrakePads');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/brakePads.png',
            imgText: 'Brake Pads')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Tires', 'Tires');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carTire.png',
            imgText: 'Tires')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Alternator', 'Alternator');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carAlternator.png',
            imgText: 'Alternator')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Radiator', 'Radiator');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carRadiator.png',
            imgText: 'Radiator')),
    RoundedButtonContainer(
        onPressed: () {
          navigateToCategory(context, 'Accessories', 'Accessories');
        },
        boxColor: thirdLayerColor,
        child: ImgContent(
            imgHeight: imageHeight,
            textSize: textSize,
            imgSrc: 'assets/carFrontSeats.png',
            imgText: 'Accessories'))
  ];
}

class ShopPage extends StatefulWidget {
  static const String id = 'ShopPage';
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: sparePartShop(context, 100, 20),
    );
  }
}
