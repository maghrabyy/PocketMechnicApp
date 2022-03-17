import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/registerpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/resetpassword.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool emptyEmail = false;
  bool emptyPassword = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      progressIndicator: const CircularProgressIndicator(
        color: fifthLayerColor,
      ),
      isLoading: _isLoading,
      color: fourthLayerColor,
      opacity: 0.2,
      child: Center(
        child: RoundedContainer(
          boxColor: thirdLayerColor,
          cHeight: 330,
          boxChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'Welcome back! '),
                    const TextSpan(text: 'If you don\'t have an account '),
                    TextSpan(
                        text: 'click here ',
                        style: const TextStyle(color: fourthLayerColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, RegisterPage.id);
                          }),
                    const TextSpan(text: 'to create one.'),
                  ],
                ),
              ),
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
                child: PasswordInput(
                  inputController: password,
                  emptyFieldError: emptyPassword,
                  onChanged: (value) {
                    setState(() {
                      emptyPassword = false;
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

                            Navigator.pushNamedAndRemoveUntil(
                                context, InitialPage.id, (route) => false);
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
                              emptyEmail = true;
                            }
                            if (password.text.isEmpty) {
                              emptyPassword = true;
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
