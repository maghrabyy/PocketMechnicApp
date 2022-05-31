import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/partnermain.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/resetpassword.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../Components/rounded_container.dart';
import '../../Components/snackbar.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class PartnerLogin extends StatefulWidget {
  static const String id = 'PartnetLogn';
  const PartnerLogin({Key? key}) : super(key: key);

  @override
  State<PartnerLogin> createState() => _PartnerLoginState();
}

class _PartnerLoginState extends State<PartnerLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  bool _emptyEmail = false;
  bool _emptyPassword = false;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Login here if you\'re a mechanic or a tow-truck driver'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInput(
                  inputController: email,
                  goNext: true,
                  emptyFieldError: _emptyEmail,
                  onChanged: (value) {
                    setState(() {
                      _emptyEmail = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordInput(
                  inputController: password,
                  emptyFieldError: _emptyPassword,
                  onChanged: (value) {
                    setState(() {
                      _emptyPassword = false;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                            String userType = '';
                            await _firestore
                                .collection('Users')
                                .doc(_auth.currentUser!.uid)
                                .get()
                                .then((value) => userType = value['userType']);
                            if (userType == 'Partner') {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PartnerMain.id, (route) => false);
                            } else {
                              await _auth.signOut();
                              displaySnackbar(context, 'Unauthorized login',
                                  fifthLayerColor);
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            String errorFromCode() {
                              switch (e.code) {
                                case "ERROR_WRONG_PASSWORD":
                                case "wrong-password":
                                  return "Wrong email/password combination.";

                                case "ERROR_USER_NOT_FOUND":
                                case "user-not-found":
                                  return "No user found with this email.";

                                case "ERROR_USER_DISABLED":
                                case "user-disabled":
                                  return "User disabled.";

                                case "ERROR_TOO_MANY_REQUESTS":
                                case "operation-not-allowed":
                                  return "Too many requests to log into this account.";

                                case "ERROR_OPERATION_NOT_ALLOWED":
                                  return "Server error, please try again later.";

                                case "ERROR_INVALID_EMAIL":
                                case "invalid-email":
                                  return "Email address is invalid.";

                                case "network-request-failed":
                                  return "Check your internet connection.";

                                default:
                                  return "Login failed. Please try again.";
                              }
                            }

                            displaySnackbar(
                                context, errorFromCode(), fifthLayerColor);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        } else {
                          displaySnackbar(
                              context,
                              'Fill all the required data first.',
                              fifthLayerColor);
                          setState(() {
                            if (email.text.isEmpty) {
                              _emptyEmail = true;
                            }
                            if (password.text.isEmpty) {
                              _emptyPassword = true;
                            }
                          });
                        }
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 35),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ResetPassword.id);
                      },
                      child: const Text('Forgot password'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
