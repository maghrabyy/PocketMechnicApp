import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/customdropdownmenu.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/BecomePartner/submittedrequest.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class BecomePartner extends StatefulWidget {
  static const String id = 'BecomePartner';
  const BecomePartner({Key? key, this.joinAsPartner}) : super(key: key);
  final bool? joinAsPartner;

  @override
  State<BecomePartner> createState() => _BecomePartnerState();
}

class _BecomePartnerState extends State<BecomePartner> {
  String? serviceType;
  TextEditingController serviceName = TextEditingController();
  bool emptyserviceName = false;
  TextEditingController serviceNumber = TextEditingController();
  bool emptyserviceNumber = false;
  TextEditingController serviceAddress = TextEditingController();
  bool emptyserviceAdress = false;
  TextEditingController fullName = TextEditingController();
  bool emptyFullName = false;
  TextEditingController phoneNum = TextEditingController();
  bool emptyPhoneNum = false;
  TextEditingController emailAdress = TextEditingController();
  bool emptyEmail = false;
  bool diffUserInfo = false;
  String? contactRole;
  List<String> serviceTypes = ['Mechanic', 'Tow Truck'];
  List<String> contactRoles = ['Owner', 'Co-Owner', 'Manager', 'Employee'];

  @override
  void initState() {
    if (widget.joinAsPartner == true) {
      diffUserInfo = true;
    } else {
      diffUserInfo = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(children: [
        RoundedContainer(
          boxColor: thirdLayerColor,
          boxChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customDropmenu(
                    'Service Type',
                    'Choose your service type.',
                    serviceTypes,
                    serviceType, (value) {
                  setState(() {
                    serviceType = value;
                  });
                }, false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RegularInput(
                  label: 'Service name',
                  hint: 'Enter your service name.',
                  inputController: serviceName,
                  emptyFieldError: emptyserviceName,
                  maxLength: 30,
                  floatingLabel: true,
                  capitalizationBehaviour: TextCapitalization.words,
                  goNext: true,
                  onChanged: (value) {
                    setState(() {
                      emptyserviceName = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RegularInput(
                  label: 'Service contact number',
                  hint: 'Enter your service contact number.',
                  inputController: serviceNumber,
                  maxLength: 11,
                  emptyFieldError: emptyserviceNumber,
                  keyboardType: TextInputType.phone,
                  floatingLabel: true,
                  goNext: true,
                  onChanged: (value) {
                    setState(() {
                      emptyserviceNumber = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RegularInput(
                  label: 'Service Address',
                  hint: 'Enter your service adress.',
                  inputController: serviceAddress,
                  emptyFieldError: emptyserviceAdress,
                  floatingLabel: true,
                  capitalizationBehaviour: TextCapitalization.sentences,
                  onChanged: (value) {
                    setState(() {
                      emptyserviceAdress = false;
                    });
                  },
                ),
              ),
              Visibility(
                visible: widget.joinAsPartner == true ? false : true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                      title: const Text(
                        'Use different user information.',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      value: diffUserInfo,
                      onChanged: (value) {
                        setState(() {
                          diffUserInfo = value!;
                        });
                      }),
                ),
              ),
              Visibility(
                  visible: diffUserInfo,
                  child: UserInfoInput(
                      userName: fullName,
                      emptyUserName: emptyFullName,
                      userPhoneNum: phoneNum,
                      emptyUserNum: emptyPhoneNum,
                      userEmail: emailAdress,
                      emptyUserEmail: emptyEmail)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customDropmenu(
                    'Contact Role',
                    'Choose your contact role.',
                    contactRoles,
                    contactRole, (value) {
                  setState(() {
                    contactRole = value;
                  });
                }, false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      //Unchecked box
                      if (diffUserInfo == false) {
                        if (serviceType != null &&
                            serviceName.text.isNotEmpty &&
                            serviceNumber.text.isNotEmpty &&
                            serviceAddress.text.isNotEmpty &&
                            contactRole != null) {
                          //Submit request
                          String? userName = _auth.currentUser!.displayName;
                          String? userEmail = _auth.currentUser!.email;
                          DocumentSnapshot<Map<String, dynamic>>? userData =
                              await getUserData(_auth.currentUser!.uid);
                          _firestore
                              .collection('PartnershipSubmission')
                              .doc(_auth.currentUser!.uid)
                              .set({
                            'Date': DateTime.now(),
                            'ServiceType': serviceType,
                            'ServiceName': serviceName.text,
                            'ServiceContactNum': serviceNumber.text,
                            'ServiceAddress': serviceAddress.text,
                            'UserID': userData!['UserID'],
                            'FullName': userName,
                            'PhoneNumber': userData['PhoneNumber'],
                            'EmaillAddress': userEmail,
                            'ContactRole': contactRole
                          });
                          Navigator.pushReplacementNamed(
                              context, SubmittedRequest.id);
                        } else {
                          displaySnackbar(
                              context,
                              'Fill all the required data first.',
                              fifthLayerColor);
                          setState(() {
                            if (serviceName.text.isEmpty) {
                              emptyserviceName = true;
                            }
                            if (serviceNumber.text.isEmpty) {
                              emptyserviceNumber = true;
                            }
                            if (serviceAddress.text.isEmpty) {
                              emptyserviceAdress = true;
                            }
                          });
                        }
                        //Checked box
                      } else {
                        if (serviceType != null &&
                            serviceName.text.isNotEmpty &&
                            serviceNumber.text.isNotEmpty &&
                            serviceAddress.text.isNotEmpty &&
                            fullName.text.isNotEmpty &&
                            phoneNum.text.isNotEmpty &&
                            emailAdress.text.isNotEmpty &&
                            contactRole != null) {
                          //Become Partner (logged in user)
                          if (widget.joinAsPartner == false) {
                            //Submit request
                            String userID =
                                await getUserID(_auth.currentUser!.uid);
                            _firestore
                                .collection('PartnershipSubmission')
                                .doc(_auth.currentUser!.uid)
                                .set({
                              'Date': DateTime.now(),
                              'ServiceType': serviceType,
                              'ServiceName': serviceName.text,
                              'ServiceContactNum': serviceNumber.text,
                              'ServiceAddress': serviceAddress.text,
                              'UserID': userID,
                              'FullName': fullName.text,
                              'PhoneNumber': phoneNum.text,
                              'EmaillAddress': emailAdress.text,
                              'ContactRole': contactRole
                            });
                            Navigator.pushReplacementNamed(
                                context, SubmittedRequest.id);
                          }
                          //Join as a partner (Unregistered user)
                          else {
                            //Submit request
                            var rng = Random();
                            var randNum = rng.nextInt(900000) + 100000;
                            String unregisteredID = 'Unregistered#$randNum';
                            _firestore
                                .collection('PartnershipSubmission')
                                .doc(unregisteredID)
                                .set({
                              'Date': DateTime.now(),
                              'ServiceType': serviceType,
                              'ServiceName': serviceName.text,
                              'ServiceContactNum': serviceNumber.text,
                              'ServiceAddress': serviceAddress.text,
                              'UserID': unregisteredID,
                              'FullName': fullName.text,
                              'PhoneNumber': phoneNum.text,
                              'EmaillAddress': emailAdress.text,
                              'ContactRole': contactRole
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => NavigatingPage(
                                          title: 'Submitted Request',
                                          page: SubmittedRequest(
                                            unregisteredID: unregisteredID,
                                          ),
                                        ))));
                          }
                        } else {
                          displaySnackbar(
                              context,
                              'Fill all the required data first.',
                              fifthLayerColor);
                          setState(() {
                            if (serviceName.text.isEmpty) {
                              emptyserviceName = true;
                            }
                            if (serviceNumber.text.isEmpty) {
                              emptyserviceNumber = true;
                            }
                            if (serviceAddress.text.isEmpty) {
                              emptyserviceAdress = true;
                            }
                            if (fullName.text.isEmpty) {
                              emptyFullName = true;
                            }
                            if (phoneNum.text.isEmpty) {
                              emptyPhoneNum = true;
                            }
                            if (emailAdress.text.isEmpty) {
                              emptyEmail = true;
                            }
                          });
                        }
                      }
                    },
                    child: const Text('Submit request')),
              )
            ],
          ),
        )
      ]),
    );
  }
}

// ignore: must_be_immutable
class UserInfoInput extends StatefulWidget {
  UserInfoInput(
      {Key? key,
      required this.userName,
      required this.emptyUserName,
      required this.userPhoneNum,
      required this.emptyUserNum,
      required this.userEmail,
      required this.emptyUserEmail})
      : super(key: key);
  final TextEditingController userName;
  bool emptyUserName;
  final TextEditingController userPhoneNum;
  bool emptyUserNum;
  final TextEditingController userEmail;
  bool emptyUserEmail;

  @override
  State<UserInfoInput> createState() => _UserInfoInputState();
}

class _UserInfoInputState extends State<UserInfoInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RegularInput(
            label: 'Full Name',
            hint: 'Enter your full name.',
            maxLength: 30,
            inputController: widget.userName,
            emptyFieldError: widget.emptyUserName,
            floatingLabel: true,
            capitalizationBehaviour: TextCapitalization.words,
            goNext: true,
            onChanged: (value) {
              setState(() {
                widget.emptyUserName = false;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RegularInput(
            label: 'Phonr number',
            hint: 'Enter your phone number.',
            inputController: widget.userPhoneNum,
            emptyFieldError: widget.emptyUserNum,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            floatingLabel: true,
            goNext: true,
            onChanged: (value) {
              setState(() {
                widget.emptyUserNum = false;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RegularInput(
            label: 'Email Address',
            hint: 'Enter your email adress.',
            inputController: widget.userEmail,
            emptyFieldError: widget.emptyUserEmail,
            floatingLabel: true,
            capitalizationBehaviour: TextCapitalization.sentences,
            onChanged: (value) {
              setState(() {
                widget.emptyUserEmail = false;
              });
            },
          ),
        ),
      ],
    );
  }
}
