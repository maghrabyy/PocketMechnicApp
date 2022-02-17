import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/style.dart';

class RegisterPage extends StatelessWidget {
  static const String id = 'RegisterPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(fontFamily: 'Kanit'),
                text: 'Create an account here, if you\'re already registered ',
                children: [
                  TextSpan(
                      text: 'click here ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, LoginPage.id);
                        },
                      style: const TextStyle(color: fourthLayerColor)),
                  const TextSpan(text: 'to login')
                ]),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter your username'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter your email address'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Create an account'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
