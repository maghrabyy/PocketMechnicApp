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
                  child: CustomDropDownMenu(
                    label: 'Service Type',
                    hint: 'Choose your service type.',
                    items: serviceTypes,
                    currentValue: serviceType,
                    onChanged: (value) {
                      setState(() {
                        serviceType = value;
                      });
                    },
                    disable: false,
                  )),
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
                child: PhoneInput(
                  label: 'Service contact number',
                  hint: 'Enter your service contact number.',
                  inputController: serviceNumber,
                  emptyFieldError: emptyserviceNumber,
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
                    userNameController: fullName,
                    emptyUserName: emptyFullName,
                    userNameOnChanged: (value) {
                      setState(() {
                        emptyFullName = false;
                      });
                    },
                    userPhoneNumController: phoneNum,
                    emptyUserNum: emptyPhoneNum,
                    userNumOnChanged: (value) {
                      setState(() {
                        emptyPhoneNum = false;
                      });
                    },
                    userEmailController: emailAdress,
                    emptyUserEmail: emptyEmail,
                    userEmailOnChanged: (value) {
                      setState(() {
                        emptyEmail = false;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropDownMenu(
                  label: 'Contact Role',
                  hint: 'Choose your contact role.',
                  items: contactRoles,
                  currentValue: contactRole,
                  onChanged: (value) {
                    setState(() {
                      contactRole = value;
                    });
                  },
                  disable: false,
                ),
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
                            var randNum = rng.nextInt(9000000) + 1000000;
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
  const UserInfoInput({
    Key? key,
    required this.userNameController,
    required this.emptyUserName,
    required this.userNameOnChanged,
    required this.userPhoneNumController,
    required this.emptyUserNum,
    required this.userNumOnChanged,
    required this.userEmailController,
    required this.emptyUserEmail,
    required this.userEmailOnChanged,
  }) : super(key: key);
  final TextEditingController userNameController;
  final bool emptyUserName;
  final ValueChanged<String?> userNameOnChanged;
  final TextEditingController userPhoneNumController;
  final bool emptyUserNum;
  final ValueChanged<String?> userNumOnChanged;
  final TextEditingController userEmailController;
  final bool emptyUserEmail;
  final ValueChanged<String?> userEmailOnChanged;

  @override
  State<UserInfoInput> createState() => _UserInfoInputState();
}

class _UserInfoInputState extends State<UserInfoInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Your personal information',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RegularInput(
            label: 'Full Name',
            hint: 'Enter your full name.',
            maxLength: 30,
            inputController: widget.userNameController,
            emptyFieldError: widget.emptyUserName,
            floatingLabel: true,
            capitalizationBehaviour: TextCapitalization.words,
            goNext: true,
            onChanged: widget.userNameOnChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhoneInput(
            inputController: widget.userPhoneNumController,
            emptyFieldError: widget.emptyUserNum,
            floatingLabel: true,
            goNext: true,
            onChanged: widget.userNumOnChanged,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: EmailInput(
              inputController: widget.userEmailController,
              floatingLabel: true,
              emptyFieldError: widget.emptyUserEmail,
              onChanged: widget.userEmailOnChanged,
            )),
      ],
    );
  }
}
