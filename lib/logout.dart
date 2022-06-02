import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/welcomepage.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _auth = FirebaseAuth.instance;

logout(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LogoutLoading()));
}

class LogoutLoading extends StatefulWidget {
  const LogoutLoading({Key? key}) : super(key: key);

  @override
  State<LogoutLoading> createState() => _LogoutLoadingState();
}

class _LogoutLoadingState extends State<LogoutLoading> {
  signout() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => signout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Logging out',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SpinKitFadingFour(
              color: fifthLayerColor,
            )
          ],
        ),
      ),
    );
  }
}
