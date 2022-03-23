import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/img_content.dart';

enum sparePartCategories {
  engineOil,
  airFilter,
  carBattery,
  brakePads,
  tires,
  alternator,
  radiator,
  accessories
}

class SparePartSection extends StatefulWidget {
  const SparePartSection({Key? key}) : super(key: key);

  @override
  _SparePartSectionState createState() => _SparePartSectionState();
}

class _SparePartSectionState extends State<SparePartSection> {
  sparePartCategories? selectedSPCategory;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.engineOil;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.engineOil
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/carEngine.png',
                imgText: 'Engine and Oil'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.airFilter;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.airFilter
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/airFilter.png',
                imgText: 'Air Filter'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.carBattery;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.carBattery
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/carBattery.png',
                imgText: 'Car Battery'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.brakePads;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.brakePads
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/brakePads.png',
                imgText: 'Brake Pads'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.tires;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.tires
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50, imgSrc: 'assets/carTire.png', imgText: 'Tires'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.alternator;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.alternator
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/carAlternator.png',
                imgText: 'Alternator'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.radiator;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.radiator
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/carRadiator.png',
                imgText: 'Radiator'),
          ),
          RoundedContainer(
            onPressed: () {
              setState(() {
                selectedSPCategory = sparePartCategories.accessories;
              });
            },
            boxColor: selectedSPCategory == sparePartCategories.accessories
                ? fourthLayerColor
                : thirdLayerColor,
            boxChild: const ImgContent(
                imgHeight: 50,
                imgSrc: 'assets/carFrontSeats.png',
                imgText: 'Accessories'),
          ),
        ],
      ),
    );
  }
}
