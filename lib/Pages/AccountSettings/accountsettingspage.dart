import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_buttoncontainer.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/inputvehicledata.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/lists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AccountSettingsPage extends StatefulWidget {
  static const String id = 'AccountSettingsPage';
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool enabledFullName = false;
  bool enabledPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text(
              'Loading...',
            );
          } else {
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
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PhoneInput(
                                    hint: '${snapshot.data['PhoneNumber']}',
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 35)),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (fullName.text.isNotEmpty ||
                                  phoneNumber.text.isNotEmpty) {
                                if (fullName.text.isNotEmpty) {
                                  _firestore
                                      .collection('Users')
                                      .doc(_auth.currentUser!.uid)
                                      .update({'FullName': fullName.text});
                                  await _auth.currentUser!
                                      .updateDisplayName(fullName.text);
                                }
                                if (phoneNumber.text.isNotEmpty) {
                                  _firestore
                                      .collection('Users')
                                      .doc(_auth.currentUser!.uid)
                                      .update(
                                          {'PhoneNumber': phoneNumber.text});
                                }
                                setState(() {
                                  fullName.clear();
                                  phoneNumber.clear();
                                });

                                displaySnackbar(
                                    context, 'Changes saved.', fifthLayerColor);
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
                      ),
                    ),
                  ]),
                  Wrap(
                    children: [
                      RoundedContainer(
                          boxColor: thirdLayerColor,
                          boxChild: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Vehicle\'s settings',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SlidableVehiclesView(),
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

class ModifyProfileData extends StatefulWidget {
  const ModifyProfileData({
    Key? key,
    this.inputController,
    this.snapshotField,
    this.snapshotCollection,
    this.snapshotDocumentPath,
    this.snapshotFrontText,
    this.snapshotBackText,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  final String? snapshotField;
  final String? snapshotCollection;
  final String? snapshotDocumentPath;
  final String? snapshotFrontText;
  final String? snapshotBackText;
  final TextEditingController? inputController;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  State<ModifyProfileData> createState() => _ModifyProfileDataState();
}

class _ModifyProfileDataState extends State<ModifyProfileData> {
  bool toggleInput = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firestore
          .collection(widget.snapshotCollection!)
          .doc(widget.snapshotDocumentPath)
          .get(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: Text('Loading...'));
          case ConnectionState.done:
            var docData = snapshot.data as DocumentSnapshot;
            return Row(
              children: [
                Expanded(
                  child: RegularInput(
                    label: widget.snapshotFrontText!,
                    hint:
                        '${docData[widget.snapshotField!]} ${widget.snapshotBackText ?? ''}',
                    inputController: widget.inputController!,
                    enabled: toggleInput,
                    floatingLabel: true,
                    keyboardType: widget.keyboardType,
                    maxLength: widget.maxLength,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      toggleInput = true;
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: iconColor,
                    size: 25,
                  ),
                ),
              ],
            );

          default:
            return const Text('Unhandle State');
        }
      },
    );
  }
}

class SlidableVehiclesView extends StatefulWidget {
  const SlidableVehiclesView({
    Key? key,
  }) : super(key: key);

  @override
  State<SlidableVehiclesView> createState() => _SlidableVehiclesViewState();
}

class _SlidableVehiclesViewState extends State<SlidableVehiclesView> {
  String? selectedBrand;
  TextEditingController inputtedModel = TextEditingController();
  String? selectedModelYear;
  String? selectedBodyType;
  String? selectedColor;
  TextEditingController inputtedEngineCapacity = TextEditingController();
  String? selectedTransimission;

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
            List vList = usersSnapshot.data!['UserVehicles'] as List<dynamic>;
            if (vList.isEmpty) {
              _firestore
                  .collection('Users')
                  .doc(_auth.currentUser!.uid)
                  .update({'Cars': 0});
              return RoundedButtonContainer(
                  width: double.infinity,
                  child: const IconContent(
                      iconText: 'Add Vehicle', iconC: Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, InputVehicleData.idCanPop);
                  });
            } else {
              List vList = usersSnapshot.data!['UserVehicles'] as List<dynamic>;
              return Column(
                children: vList.map<Card>((dynamic value) {
                  return Card(
                    color: thirdLayerColor,
                    child: Slidable(
                        endActionPane: usersSnapshot.data['Cars'] < 2
                            ? ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                    SlidableAction(
                                      icon: FontAwesomeIcons.plus,
                                      onPressed: (context) {
                                        Navigator.pushNamed(
                                            context, InputVehicleData.idCanPop);
                                      },
                                      backgroundColor: fifthLayerColor,
                                      foregroundColor: iconColor,
                                    ),
                                  ])
                            : ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                    SlidableAction(
                                      icon: FontAwesomeIcons.trash,
                                      onPressed: (context) async {
                                        for (int index = 0;
                                            index < value.length - 1;
                                            index++) {
                                          List vehList = await getVehiclesList(
                                              _auth.currentUser!.uid);
                                          String vName =
                                              vehList[index]['VehicleName'];
                                          //Remove #1
                                          _firestore
                                              .collection('Users')
                                              .doc(_auth.currentUser!.uid)
                                              .update({
                                            'UserVehicles':
                                                FieldValue.arrayRemove([
                                              {
                                                'VehicleID': value['VehicleID'],
                                                'VehicleName': vName
                                              }
                                            ])
                                          });
                                        }

                                        _firestore
                                            .collection('Users')
                                            .doc(_auth.currentUser!.uid)
                                            .update({'Cars': 0});
                                      },
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: iconColor,
                                    ),
                                  ]),
                        child: StreamBuilder(
                            stream: _firestore
                                .collection('VehicleData')
                                .doc(value['VehicleID'])
                                .snapshots(),
                            builder: (context, AsyncSnapshot vehiclesSnapshot) {
                              if (!vehiclesSnapshot.hasData) {
                                return const Text(
                                  'Loading...',
                                );
                              } else {
                                return ExpansionTile(
                                  initiallyExpanded:
                                      usersSnapshot.data['Cars'] == 1
                                          ? true
                                          : false,
                                  iconColor: iconColor,
                                  collapsedIconColor: iconColor,
                                  title: Text(
                                    value['VehicleName'],
                                    style: const TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontFamily: 'Kanit'),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: customDropmenu(
                                          'Vehicle Brand',
                                          '${vehiclesSnapshot.data['Brand']}',
                                          vehicleBrands,
                                          selectedBrand, (value) {
                                        setState(() {
                                          selectedBrand = value;
                                        });
                                      }, false),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8.0, 8.0, 0),
                                      child: RegularInput(
                                        label: 'Vehicle Model',
                                        hint: vehiclesSnapshot.data['Model'],
                                        inputController: inputtedModel,
                                        floatingLabel: true,
                                        maxLength: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0, 8.0, 8.0),
                                      child: customDropmenu(
                                          'Model Year',
                                          '${vehiclesSnapshot.data['ModelYear']}',
                                          modelYear,
                                          selectedModelYear, (value) {
                                        setState(() {
                                          selectedModelYear = value;
                                        });
                                      }, false),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: customDropmenu(
                                          'Body Type',
                                          '${vehiclesSnapshot.data['BodyType']}',
                                          bodyTypes,
                                          selectedBodyType, (value) {
                                        setState(() {
                                          selectedBodyType = value;
                                        });
                                      }, false),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: customDropmenu(
                                          'Vehicle Color',
                                          '${vehiclesSnapshot.data['Color']}',
                                          vehicleColors,
                                          selectedColor, (value) {
                                        setState(() {
                                          selectedColor = value;
                                        });
                                      }, false),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8.0, 8.0, 0),
                                      child: RegularInput(
                                        label: 'Engine Capacity',
                                        hint:
                                            '${vehiclesSnapshot.data['EngineCapacity']} cc',
                                        inputController: inputtedEngineCapacity,
                                        floatingLabel: true,
                                        maxLength: 5,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0, 8.0, 8.0),
                                      child: customDropmenu(
                                          'Vehicle Transimission',
                                          '${vehiclesSnapshot.data['Transimission']}',
                                          transimissionTypes,
                                          selectedTransimission, (value) {
                                        setState(() {
                                          selectedTransimission = value;
                                        });
                                      }, false),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(150, 35)),
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        if (selectedBrand != null ||
                                            inputtedModel.text.isNotEmpty ||
                                            selectedModelYear != null ||
                                            selectedBodyType != null ||
                                            selectedColor != null ||
                                            inputtedEngineCapacity
                                                .text.isNotEmpty ||
                                            selectedTransimission != null) {
                                          //update VehicleData Collection
                                          if (selectedBrand != null) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update(
                                                    {'Brand': selectedBrand});
                                          }
                                          if (inputtedModel.text.isNotEmpty) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update({
                                              'Model': inputtedModel.text
                                            });
                                          }
                                          if (selectedModelYear != null) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update({
                                              'ModelYear': selectedModelYear
                                            });
                                          }
                                          if (selectedBodyType != null) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update({
                                              'BodyType': selectedBodyType
                                            });
                                          }
                                          if (selectedColor != null) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update(
                                                    {'Color': selectedColor});
                                          }
                                          if (inputtedEngineCapacity
                                              .text.isNotEmpty) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update({
                                              'EngineCapacity':
                                                  inputtedEngineCapacity.text
                                            });
                                          }
                                          if (selectedTransimission != null) {
                                            _firestore
                                                .collection('VehicleData')
                                                .doc(value['VehicleID'])
                                                .update({
                                              'Transimission':
                                                  selectedTransimission
                                            });
                                          }
                                          //Update UserVehicles Array
                                          for (int index = 0;
                                              index < value.length - 1;
                                              index++) {
                                            List vehList =
                                                await getVehiclesList(
                                                    _auth.currentUser!.uid);
                                            String vName =
                                                vehList[index]['VehicleName'];
                                            //Remove #1
                                            _firestore
                                                .collection('Users')
                                                .doc(_auth.currentUser!.uid)
                                                .update({
                                              'UserVehicles':
                                                  FieldValue.arrayRemove([
                                                {
                                                  'VehicleID':
                                                      value['VehicleID'],
                                                  'VehicleName': vName
                                                }
                                              ])
                                            });
                                          }
                                          //Add #2
                                          _firestore
                                              .collection('Users')
                                              .doc(_auth.currentUser!.uid)
                                              .update({
                                            'UserVehicles':
                                                FieldValue.arrayUnion([
                                              {
                                                'VehicleID': value['VehicleID'],
                                                'VehicleName':
                                                    '${selectedBrand ?? vehiclesSnapshot.data['Brand']} ${inputtedModel.text.isEmpty ? vehiclesSnapshot.data['Model'] : inputtedModel.text} ${selectedModelYear ?? vehiclesSnapshot.data['ModelYear']}'
                                              }
                                            ])
                                          });

                                          selectedBrand = null;
                                          inputtedModel.clear();
                                          selectedModelYear = null;
                                          selectedBodyType = null;
                                          selectedColor = null;
                                          inputtedEngineCapacity.clear();
                                          selectedTransimission = null;
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
                            })),
                  );
                }).toList(),
              );
            }
          }
        });
  }
}
