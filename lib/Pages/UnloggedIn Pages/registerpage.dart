import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/inputvehicledata.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

final _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  static const String id = 'RegisterPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  bool _isRegLoading = false;
  bool emptyFullName = false;
  bool emptyEmail = false;
  bool emptyPhoneNumber = false;
  bool emptyPassword = false;
  bool emptyConfirmationPassword = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      progressIndicator: const SpinKitFadingFour(
        color: fifthLayerColor,
      ),
      isLoading: _isRegLoading,
      color: fourthLayerColor,
      opacity: 0.2,
      child: Wrap(children: [
        RoundedContainer(
          boxColor: thirdLayerColor,
          boxChild: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(fontFamily: 'Kanit'),
                      text:
                          'Create an account here, if you\'re already registered ',
                      children: [
                        TextSpan(
                            text: 'click here ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, LoginPage.id);
                              },
                            style: const TextStyle(color: fourthLayerColor)),
                        const TextSpan(text: 'to login.')
                      ]),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RegularInput(
                    label: 'Full name',
                    hint: 'Enter your full name',
                    inputController: fullName,
                    goNext: true,
                    emptyErrorText: 'This field cannot be empty.',
                    emptyFieldError: emptyFullName,
                    capitalizationBehaviour: TextCapitalization.words,
                    onChanged: (value) {
                      setState(() {
                        emptyFullName = false;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInput(
                  inputController: email,
                  goNext: true,
                  emptyFieldError: emptyEmail,
                  onChanged: (value) {
                    setState(() {
                      emptyEmail = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneInput(
                  inputController: phoneNumber,
                  goNext: true,
                  emptyFieldError: emptyPhoneNumber,
                  onChanged: (value) {
                    setState(() {
                      emptyPhoneNumber = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordInput(
                  inputController: password,
                  goNext: true,
                  emptyFieldError: emptyPassword,
                  onChanged: (value) {
                    setState(() {
                      emptyPassword = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordInput(
                  inputController: passwordConfirmation,
                  confirmationPass: true,
                  emptyFieldError: emptyConfirmationPassword,
                  onChanged: (value) {
                    setState(() {
                      emptyConfirmationPassword = false;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (fullName.text.isNotEmpty &&
                        email.text.isNotEmpty &&
                        phoneNumber.text.isNotEmpty &&
                        password.text.isNotEmpty &&
                        passwordConfirmation.text.isNotEmpty) {
                      if (password.text == passwordConfirmation.text) {
                        setState(() {
                          _isRegLoading = true;
                        });
                        try {
                          //Registered
                          await _auth.createUserWithEmailAndPassword(
                              email: email.text, password: password.text);
                          DatabaseService newUser =
                              DatabaseService(uId: _auth.currentUser!.uid);
                          newUser.registerationData(
                              fullName.text, email.text, phoneNumber.text);
                          Navigator.pushNamedAndRemoveUntil(
                              context, InputVehicleData.id, (route) => false);
                        } on FirebaseAuthException catch (e) {
                          String errorFromCode() {
                            switch (e.code) {
                              case "ERROR_EMAIL_ALREADY_IN_USE":
                              case "account-exists-with-different-credential":
                              case "email-already-in-use":
                                return "Email already used. Go to login page.";

                              case "ERROR_TOO_MANY_REQUESTS":
                              case "operation-not-allowed":
                                return "Too many requests to log into this account.";

                              case "ERROR_OPERATION_NOT_ALLOWED":
                                return "Server error, please try again later.";

                              case "ERROR_INVALID_EMAIL":
                              case "invalid-email":
                                return "Email address is invalid.";

                              case "ERROR_WEAK_PASSWORD":
                              case "weak-password":
                                return "Password must be equal or more than 6 characters.";
                              case "network-request-failed":
                                return "Check your internet connection.";

                              default:
                                return e.code;
                            }
                          }

                          displaySnackbar(
                              context, errorFromCode(), fifthLayerColor);
                          setState(() {
                            _isRegLoading = false;
                          });
                        }
                      } else {
                        displaySnackbar(
                            context,
                            'The password your entered doesn\'s match',
                            fifthLayerColor);
                      }
                    } else {
                      displaySnackbar(context,
                          'Fill all the required data first.', fifthLayerColor);
                      setState(() {
                        if (fullName.text.isEmpty) {
                          emptyFullName = true;
                        }
                        if (email.text.isEmpty) {
                          emptyEmail = true;
                        }
                        if (phoneNumber.text.isEmpty) {
                          emptyPhoneNumber = true;
                        }
                        if (password.text.isEmpty) {
                          emptyPassword = true;
                        }
                        if (passwordConfirmation.text.isEmpty) {
                          emptyConfirmationPassword = true;
                        }
                      });
                    }
                  },
                  child: const Text('Create an account'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
