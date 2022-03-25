import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/lists.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class InputVehicleData extends StatefulWidget {
  static const String id = 'InputVehicleData';
  static const String idCanPop = 'InputVehicleDataCanPop';

  const InputVehicleData({Key? key}) : super(key: key);

  @override
  State<InputVehicleData> createState() => _InputVehicleDataState();
}

class _InputVehicleDataState extends State<InputVehicleData> {
  String? selectedBrand;
  String? selectedBodyType;
  TextEditingController inputtedModel = TextEditingController();
  String? selectedModelYear;
  String? selectedColor;
  TextEditingController inputtedEngineCapacity = TextEditingController();
  String? selectedTransimission;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        progressIndicator: const SpinKitFadingFour(
          color: fifthLayerColor,
        ),
        isLoading: _isLoading,
        color: fourthLayerColor,
        opacity: 0.2,
        child: Wrap(children: [
          RoundedContainer(
            boxColor: thirdLayerColor,
            boxChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropDownMenu(
                    label: 'Vehicle\'s brand',
                    hint: 'Select your vehicle\'s brand',
                    items: vehicleBrands,
                    currentValue: selectedBrand,
                    onChanged: (value) {
                      setState(() {
                        selectedBrand = value;
                      });
                    },
                    disable: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropDownMenu(
                    label: 'Body Type',
                    hint: 'Select your vehicle\'s body type',
                    items: bodyTypes,
                    currentValue: selectedBodyType,
                    onChanged: (value) {
                      setState(() {
                        selectedBodyType = value;
                      });
                    },
                    disable: selectedBrand == null ? true : false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: RegularInput(
                          label: 'Vehicle\'s model',
                          labelStyle: TextStyle(
                              color: selectedBodyType == null
                                  ? Colors.grey
                                  : fifthLayerColor),
                          hint: 'Type your vehicle\'s model',
                          inputController: inputtedModel,
                          maxLength: 30,
                          enabled: selectedBodyType == null ? false : true,
                          capitalizationBehaviour: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NoBorderDropdownMenu(
                              hint: 'Model year',
                              items: modelYear,
                              currentValue: selectedModelYear,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedModelYear = value!;
                                });
                              },
                              hintColor: selectedBodyType != null
                                  ? Colors.white
                                  : Colors.grey,
                              disable: selectedBodyType == null ? false : true))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropDownMenu(
                    label: 'Vehicle\'s color',
                    hint: 'Select your vehicle\'s color',
                    items: vehicleColors,
                    currentValue: selectedColor,
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value;
                      });
                    },
                    disable: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RegularInput(
                          label: 'Engine Capacity',
                          hint: 'Type your vehicle\'s Engine capcity',
                          inputController: inputtedEngineCapacity,
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('CC'),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropDownMenu(
                    label: 'Transimission',
                    hint: 'Select your vehicle\'s transimission',
                    items: transimissionTypes,
                    currentValue: selectedTransimission,
                    onChanged: (value) {
                      setState(() {
                        selectedTransimission = value;
                      });
                    },
                    disable: false,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (selectedBrand != null &&
                        selectedBodyType != null &&
                        inputtedModel.text.isNotEmpty &&
                        selectedModelYear != null &&
                        selectedColor != null &&
                        inputtedEngineCapacity.text.isNotEmpty &&
                        selectedTransimission != null) {
                      try {
                        final result =
                            await InternetAddress.lookup('example.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          //Update Vehicle Field (Users collection)
                          var rng = Random();
                          var randNum = rng.nextInt(900000) + 100000;
                          String vehicleID = 'V$randNum';
                          _firestore
                              .collection('Users')
                              .doc(_auth.currentUser!.uid)
                              .update({
                            'Vehicle.VehicleID': vehicleID,
                            'Vehicle.VehicleName':
                                '$selectedBrand ${inputtedModel.text} $selectedModelYear'
                          });
                          //VehicleData Collection set Data
                          await _firestore
                              .collection('VehicleData')
                              .doc(vehicleID)
                              .set({
                            'VehicleID': vehicleID,
                            'Brand': selectedBrand,
                            'Model': inputtedModel.text,
                            'ModelYear': selectedModelYear,
                            'BodyType': selectedBodyType,
                            'Color': selectedColor,
                            'EngineCapacity': inputtedEngineCapacity.text,
                            'Transimission': selectedTransimission,
                            'UserID': await getUserID(_auth.currentUser!.uid),
                          });
                          Navigator.pushNamedAndRemoveUntil(
                              context, InitialPage.id, (route) => false);
                        }
                      } on SocketException catch (_) {
                        displaySnackbar(context,
                            'Check your internet connection.', fifthLayerColor);
                      }
                    } else {
                      displaySnackbar(context,
                          'Fill all the required data first.', fifthLayerColor);
                    }
                  },
                  child: const Text('Add vehicle'),
                )
              ],
            ),
          ),
        ]));
  }
}
