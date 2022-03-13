import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/img_content.dart';
import '../../Components/rounded_buttoncontainer.dart';

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
      children: [
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carEngine.png', 'Engine and Oil'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/airFilter.png', 'Air Filter'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carBattery.png', 'Car Battery'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/brakePads.png', 'Brake Pads'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carTire.png', 'Tires'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carAlternator.png', 'Alternator'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carRadiator.png', 'Radiator'),
        ),
        RoundedButtonContainer(
          onPressed: () {
            setState(() {});
          },
          boxColor: thirdLayerColor,
          child: shopCategory('assets/carFrontSeats.png', 'Accessories'),
        ),
      ],
    );
  }

  ImgContent shopCategory(String image, String text) {
    return ImgContent(
        imgHeight: 100, textSize: 20, imgSrc: image, imgText: text);
  }
}
