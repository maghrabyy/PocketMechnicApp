import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
  final _auth = FirebaseAuth.instance;

  bool _isRegLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      progressIndicator: const CircularProgressIndicator(
        color: fifthLayerColor,
      ),
      isLoading: _isRegLoading,
      color: fourthLayerColor,
      opacity: 0.2,
      child: Center(
        child: RoundedContainer(
          boxColor: thirdLayerColor,
          cHeight: 430,
          boxChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
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
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RegularInput(
                    label: 'Full name',
                    hint: 'Enter your full name',
                    inputController: fullName,
                    goNext: true,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInput(
                  inputController: email,
                  goNext: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneInput(
                  inputController: phoneNumber,
                  goNext: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordInput(inputController: password),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isRegLoading = true;
                    });
                    if (fullName.text.isNotEmpty &&
                        email.text.isNotEmpty &&
                        phoneNumber.text.isNotEmpty &&
                        password.text.isNotEmpty) {
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: email.text, password: password.text);
                        loggedIn = true;
                        Navigator.pushNamedAndRemoveUntil(
                            context, InitialPage.id, (route) => false);
                      } catch (e) {
                        displaySnackbar(context, '$e', fifthLayerColor);
                        setState(() {
                          _isRegLoading = false;
                        });
                      }
                    } else {
                      displaySnackbar(context, 'Complete the following fields!',
                          fifthLayerColor);
                      setState(() {
                        _isRegLoading = false;
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
      ),
    );
  }
}
