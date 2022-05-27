import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/style.dart';

final _firestore = FirebaseFirestore.instance;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static const String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> categories = [
    'EngineAndOil',
    'AirFilter',
    'CarBattery',
    'BrakePads',
    'Tires',
    'Alternator',
    'Radiator',
    'Accessories'
  ];

  String? selectedCategory;
  TextEditingController productBrand = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController manufacturingCountry = TextEditingController();
  TextEditingController productCost = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  bool emptyBrand = false;
  bool emptyName = false;
  bool emptyCountry = false;
  bool emptyCost = false;
  bool emptyDescription = false;
  bool emptyQuantity = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomDropDownMenu(
                label: 'Category',
                hint: 'Select category',
                items: categories,
                currentValue: selectedCategory,
                disable: false,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Brand',
              hint: 'Type product\'s brand here',
              goNext: true,
              inputController: productBrand,
              emptyFieldError: emptyBrand,
              onChanged: (value) {
                setState(() {
                  emptyBrand = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Name',
              hint: 'Type product\'s name here',
              goNext: true,
              inputController: productName,
              emptyFieldError: emptyName,
              onChanged: (value) {
                setState(() {
                  emptyName = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Manufacturing Country',
              hint: 'Type product\'s manufacturing country here',
              goNext: true,
              inputController: manufacturingCountry,
              emptyFieldError: emptyCountry,
              onChanged: (value) {
                setState(() {
                  emptyCountry = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Cost',
              hint: 'Type product\'s cost here',
              keyboardType: TextInputType.number,
              goNext: true,
              inputController: productCost,
              emptyFieldError: emptyCost,
              onChanged: (value) {
                setState(() {
                  emptyCost = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Description',
              hint: 'Type product\'s description here',
              goNext: true,
              inputController: productDescription,
              emptyFieldError: emptyDescription,
              onChanged: (value) {
                setState(() {
                  emptyDescription = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegularInput(
              label: 'Quantity',
              hint: 'Type product\'s quantity here',
              keyboardType: TextInputType.number,
              inputController: productQuantity,
              emptyFieldError: emptyQuantity,
              onChanged: (value) {
                setState(() {
                  emptyQuantity = false;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (selectedCategory != null &&
                    productBrand.text.isNotEmpty &&
                    productName.text.isNotEmpty &&
                    manufacturingCountry.text.isNotEmpty &&
                    productCost.text.isNotEmpty &&
                    productDescription.text.isNotEmpty &&
                    productQuantity.text.isNotEmpty) {
                  var rng = Random();
                  var randNum = rng.nextInt(900000) + 100000;
                  String productID = 'PR$randNum';
                  String defaultProductImage() {
                    if (selectedCategory == 'EngineAndOil') {
                      return 'assets/carEngine.png';
                    } else if (selectedCategory == 'AirFilter') {
                      return 'assets/airFilter.png';
                    } else if (selectedCategory == 'AirFilter') {
                      return 'assets/airFilter.png';
                    } else if (selectedCategory == 'CarBattery') {
                      return 'assets/carBattery.png';
                    } else if (selectedCategory == 'BrakePads') {
                      return 'assets/brakePads.png';
                    } else if (selectedCategory == 'Tires') {
                      return 'assets/carTire.png';
                    } else if (selectedCategory == 'Alternator') {
                      return 'assets/carAlternator.png';
                    } else if (selectedCategory == 'Radiator') {
                      return 'assets/carRadiator.png';
                    } else if (selectedCategory == 'Accessories') {
                      return 'assets/carFrontSeats.png';
                    } else {
                      return 'assets/uknown.png';
                    }
                  }

                  await _firestore
                      .collection('sparePartProducts')
                      .doc(productID)
                      .set({
                    'Feedbacks': [],
                    'categoryName': selectedCategory,
                    'manufacturingCountry': manufacturingCountry.text,
                    'productAvailability': true,
                    'productBrand': productBrand.text,
                    'productDescription': productDescription.text,
                    'productID': productID,
                    'productName': productName.text,
                    'productPrice': int.parse(productCost.text),
                    'productQuantity': int.parse(productQuantity.text),
                    'productImage': defaultProductImage(),
                  });
                  displaySnackbar(context, 'Product added', fifthLayerColor);
                  Navigator.pop(context);
                } else {
                  displaySnackbar(context, 'Complete the following fields',
                      fifthLayerColor);
                  if (productBrand.text.isEmpty) {
                    setState(() {
                      emptyBrand = true;
                    });
                  }
                  if (productName.text.isEmpty) {
                    setState(() {
                      emptyName = true;
                    });
                  }
                  if (manufacturingCountry.text.isEmpty) {
                    setState(() {
                      emptyCountry = true;
                    });
                  }
                  if (productCost.text.isEmpty) {
                    setState(() {
                      emptyCost = true;
                    });
                  }
                  if (productDescription.text.isEmpty) {
                    setState(() {
                      emptyDescription = true;
                    });
                  }
                  if (productQuantity.text.isEmpty) {
                    setState(() {
                      emptyQuantity = true;
                    });
                  }
                }
              },
              child: const Text('Add product'))
        ],
      ),
    );
  }
}
