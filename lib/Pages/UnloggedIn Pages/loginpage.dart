import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/registerpage.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(text: 'Welcome back to Pocket Mechanic!'),
                const TextSpan(text: 'If you don\'t have an account '),
                TextSpan(
                    text: 'click here ',
                    style: const TextStyle(color: fourthLayerColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(
                            context, RegisterPage.id);
                      }),
                const TextSpan(text: 'to create one'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter your username or email address'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    loggedIn = true;
                    Navigator.pushNamedAndRemoveUntil(
                        context, InitialPage.id, (route) => false);
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Forgot password'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
