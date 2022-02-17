import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/img_content.dart';

enum sparePartCategories { engineOil, airFilter, carBattery, brakePads }

class SparePartSection extends StatefulWidget {
  const SparePartSection({Key? key}) : super(key: key);

  @override
  _SparePartSectionState createState() => _SparePartSectionState();
}

class _SparePartSectionState extends State<SparePartSection> {
  sparePartCategories? selectedSPCategory;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSPCategory = sparePartCategories.engineOil;
                });
              },
              boxColor: selectedSPCategory == sparePartCategories.engineOil
                  ? fourthLayerColor
                  : thirdLayerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/carEngine.png', imgText: 'Engine and Oil'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSPCategory = sparePartCategories.airFilter;
                });
              },
              boxColor: selectedSPCategory == sparePartCategories.airFilter
                  ? fourthLayerColor
                  : thirdLayerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/airFilter.png', imgText: 'Air Filter'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSPCategory = sparePartCategories.carBattery;
                });
              },
              boxColor: selectedSPCategory == sparePartCategories.carBattery
                  ? fourthLayerColor
                  : thirdLayerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/carBattery.png', imgText: 'Car Battery'),
            ),
          ),
          Expanded(
            child: RoundedContainer(
              onPressed: () {
                setState(() {
                  selectedSPCategory = sparePartCategories.brakePads;
                });
              },
              boxColor: selectedSPCategory == sparePartCategories.brakePads
                  ? fourthLayerColor
                  : thirdLayerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/brakePads.png', imgText: 'Breke Pads'),
            ),
          ),
        ],
      ),
    );
  }
}
