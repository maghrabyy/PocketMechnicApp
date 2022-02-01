import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/extractedWidgets/rounded_container.dart';
import 'package:flutter_course/extractedWidgets/img_content.dart';

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
                  ? tappedButtonColor
                  : containerColor,
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
                  ? tappedButtonColor
                  : containerColor,
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
                  ? tappedButtonColor
                  : containerColor,
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
                  ? tappedButtonColor
                  : containerColor,
              boxChild: const ImgContent(
                  imgSrc: 'assets/brakePads.png', imgText: 'Breke Pads'),
            ),
          ),
        ],
      ),
    );
  }
}
