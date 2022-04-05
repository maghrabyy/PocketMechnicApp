import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AccountSettingsPage extends StatefulWidget {
  static const String id = 'AccountSettingsPage';
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  //User data input
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  //Enabled UseData
  bool enabledFullName = false;
  bool enabledPhoneNumber = false;
  //Vehicle data input
  String? selectedBrand;
  TextEditingController inputtedModel = TextEditingController();
  String? selectedModelYear;
  String? selectedBodyType;
  String? selectedColor;
  TextEditingController inputtedEngineCapacity = TextEditingController();
  String? selectedTransimission;
  //Enabled vehicle Data
  bool enabledVehicleBrand = false;
  bool enabledVehicleModel = false;
  bool enabledModelYear = false;
  bool enabledBodyType = false;
  bool enabledVehicleColor = false;
  bool enabledEngineCapacity = false;
  bool enabledVehicleTransmission = false;

  resetInputData() {
    setState(() {
      //Clear user input
      fullName.clear();
      phoneNumber.clear();
      //disable user input
      enabledFullName = false;
      enabledPhoneNumber = false;
      //clear Vehicle input
      selectedBrand = null;
      inputtedModel.clear();
      selectedModelYear = null;
      selectedBodyType = null;
      selectedColor = null;
      inputtedEngineCapacity.clear();
      selectedTransimission = null;
      //disable vehicle input
      enabledVehicleBrand = false;
      enabledVehicleModel = false;
      enabledModelYear = false;
      enabledBodyType = false;
      enabledVehicleColor = false;
      enabledEngineCapacity = false;
      enabledVehicleTransmission = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot usersSnapshot) {
          if (!usersSnapshot.hasData) {
            return const Center(
              child: SpinKitFadingFour(
                color: fifthLayerColor,
              ),
            );
          } else {
            String vehID = usersSnapshot.data['Vehicle.VehicleID'];
            String vehName = usersSnapshot.data['Vehicle.VehicleName'];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(children: [
                    RoundedContainer(
                      boxColor: thirdLayerColor,
                      boxChild: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RegularInput(
                                    label: 'Full Name',
                                    hint: '${_auth.currentUser!.displayName}',
                                    inputController: fullName,
                                    enabled: enabledFullName,
                                    floatingLabel: true,
                                    capitalizationBehaviour:
                                        TextCapitalization.words,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      enabledFullName = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: iconColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PhoneInput(
                                    hint:
                                        '${usersSnapshot.data['PhoneNumber']}',
                                    inputController: phoneNumber,
                                    enabled: enabledPhoneNumber,
                                    floatingLabel: true,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      enabledPhoneNumber = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: iconColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Wrap(
                    children: [
                      RoundedContainer(
                          boxColor: thirdLayerColor,
                          boxChild: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Vehicle\'s settings',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const Divider(
                                color: fifthLayerColor,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              StreamBuilder(
                                  stream: _firestore
                                      .collection('VehicleData')
                                      .doc(vehID)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot vehiclesSnapshot) {
                                    if (!vehiclesSnapshot.hasData) {
                                      return const Text(
                                        'Loading...',
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                18, 0, 8.0, 8.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    vehName,
                                                    style: const TextStyle(
                                                        color: textColor,
                                                        fontSize: 20,
                                                        fontFamily: 'Kanit',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          enabledVehicleBrand =
                                                              true;
                                                          enabledVehicleModel =
                                                              true;
                                                          enabledModelYear =
                                                              true;
                                                          enabledBodyType =
                                                              true;
                                                          enabledVehicleColor =
                                                              true;
                                                          enabledEngineCapacity =
                                                              true;
                                                          enabledVehicleTransmission =
                                                              true;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        size: 25,
                                                      ))
                                                ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomDropDownMenu(
                                              label: 'Vehicle Brand',
                                              hint:
                                                  '${vehiclesSnapshot.data['Brand']}',
                                              items: vehicleBrands,
                                              currentValue: selectedBrand,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedBrand = value;
                                                });
                                              },
                                              disable: enabledVehicleBrand
                                                  ? false
                                                  : true,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 255,
                                                  child: RegularInput(
                                                    label: 'Vehicle Model',
                                                    hint: vehiclesSnapshot
                                                        .data['Model'],
                                                    inputController:
                                                        inputtedModel,
                                                    floatingLabel: true,
                                                    maxLength: 30,
                                                    capitalizationBehaviour:
                                                        TextCapitalization
                                                            .words,
                                                    enabled:
                                                        enabledVehicleModel,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: NoBorderDropdownMenu(
                                                      hint:
                                                          '${vehiclesSnapshot.data['ModelYear']}',
                                                      items: modelYear,
                                                      currentValue:
                                                          selectedModelYear,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedModelYear =
                                                              value!;
                                                        });
                                                      },
                                                      hintColor:
                                                          enabledModelYear ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.grey,
                                                      enabled:
                                                          enabledModelYear),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomDropDownMenu(
                                              label: 'Body Type',
                                              hint:
                                                  '${vehiclesSnapshot.data['BodyType']}',
                                              items: bodyTypes,
                                              currentValue: selectedBodyType,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedBodyType = value;
                                                });
                                              },
                                              disable: enabledBodyType
                                                  ? false
                                                  : true,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomDropDownMenu(
                                              label: 'Vehicle Color',
                                              hint:
                                                  '${vehiclesSnapshot.data['Color']}',
                                              items: vehicleColors,
                                              currentValue: selectedColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedColor = value;
                                                });
                                              },
                                              disable: enabledVehicleColor
                                                  ? false
                                                  : true,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RegularInput(
                                              label: 'Engine Capacity',
                                              hint:
                                                  '${vehiclesSnapshot.data['EngineCapacity']} cc',
                                              inputController:
                                                  inputtedEngineCapacity,
                                              floatingLabel: true,
                                              maxLength: 5,
                                              keyboardType:
                                                  TextInputType.number,
                                              enabled: enabledEngineCapacity,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomDropDownMenu(
                                              label: 'Vehicle Transimission',
                                              hint:
                                                  '${vehiclesSnapshot.data['Transimission']}',
                                              items: transimissionTypes,
                                              currentValue:
                                                  selectedTransimission,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedTransimission = value;
                                                });
                                              },
                                              disable:
                                                  enabledVehicleTransmission
                                                      ? false
                                                      : true,
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size(150, 35)),
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              if (fullName.text.isNotEmpty ||
                                                  phoneNumber.text.isNotEmpty ||
                                                  selectedBrand != null ||
                                                  inputtedModel
                                                      .text.isNotEmpty ||
                                                  selectedModelYear != null ||
                                                  selectedBodyType != null ||
                                                  selectedColor != null ||
                                                  inputtedEngineCapacity
                                                      .text.isNotEmpty ||
                                                  selectedTransimission !=
                                                      null) {
                                                //update User data
                                                if (fullName.text.isNotEmpty) {
                                                  _firestore
                                                      .collection('Users')
                                                      .doc(_auth
                                                          .currentUser!.uid)
                                                      .update({
                                                    'FullName': fullName.text
                                                  });
                                                  await _auth.currentUser!
                                                      .updateDisplayName(
                                                          fullName.text);
                                                }
                                                if (phoneNumber
                                                    .text.isNotEmpty) {
                                                  _firestore
                                                      .collection('Users')
                                                      .doc(_auth
                                                          .currentUser!.uid)
                                                      .update({
                                                    'PhoneNumber':
                                                        phoneNumber.text
                                                  });
                                                }

                                                //update VehicleData Collection
                                                if (selectedBrand != null) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'Brand': selectedBrand
                                                  });
                                                }
                                                if (inputtedModel
                                                    .text.isNotEmpty) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'Model': inputtedModel.text
                                                  });
                                                }
                                                if (selectedModelYear != null) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'ModelYear':
                                                        selectedModelYear
                                                  });
                                                }
                                                if (selectedBodyType != null) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'BodyType': selectedBodyType
                                                  });
                                                }
                                                if (selectedColor != null) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'Color': selectedColor
                                                  });
                                                }
                                                if (inputtedEngineCapacity
                                                    .text.isNotEmpty) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'EngineCapacity':
                                                        inputtedEngineCapacity
                                                            .text
                                                  });
                                                }
                                                if (selectedTransimission !=
                                                    null) {
                                                  _firestore
                                                      .collection('VehicleData')
                                                      .doc(vehID)
                                                      .update({
                                                    'Transimission':
                                                        selectedTransimission
                                                  });
                                                }
                                                //Update Vehicle Field (Users Collection)
                                                await _firestore
                                                    .collection('Users')
                                                    .doc(_auth.currentUser!.uid)
                                                    .update({
                                                  'Vehicle.VehicleName':
                                                      '${selectedBrand ?? vehiclesSnapshot.data['Brand']} ${inputtedModel.text.isEmpty ? vehiclesSnapshot.data['Model'] : inputtedModel.text} ${selectedModelYear ?? vehiclesSnapshot.data['ModelYear']}'
                                                });
                                                resetInputData();
                                                displaySnackbar(
                                                    context,
                                                    'Changes saved.',
                                                    fifthLayerColor);
                                              } else {
                                                displaySnackbar(
                                                    context,
                                                    'Nothing has been modified.',
                                                    fifthLayerColor);
                                              }
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ],
                                      );
                                    }
                                  })
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
