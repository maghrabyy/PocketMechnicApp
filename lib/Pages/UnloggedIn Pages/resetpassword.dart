import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/inputs.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:flutter_course/Components/snackbar.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'ResetPasswordPage';
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      progressIndicator: const SpinKitFadingFour(
        color: fifthLayerColor,
      ),
      isLoading: _isLoading,
      color: fourthLayerColor,
      opacity: 0.2,
      child: Center(
        child: RoundedContainer(
          boxColor: thirdLayerColor,
          cHeight: 220,
          boxChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Type your email address below, to send you an email to reset your password.',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInput(inputController: email),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (email.text.isNotEmpty) {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await _auth.sendPasswordResetEmail(email: email.text);
                        setState(() {
                          _isLoading = false;
                        });
                        displaySnackbar(
                            context,
                            'a reset password email sent to you.',
                            fifthLayerColor);
                      } catch (e) {
                        displaySnackbar(context, '$e', fifthLayerColor);
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    } else {
                      displaySnackbar(
                          context,
                          'You can\'t leave this field empty!',
                          fifthLayerColor);
                    }
                  },
                  child: const Text('Reset Password'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
