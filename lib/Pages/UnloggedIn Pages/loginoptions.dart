import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/moderatorlogin.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/partnerlogin.dart';

class LoginOptions extends StatelessWidget {
  static const String id = 'LoginOptions';
  const LoginOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'If you\'re a mechanic/tow-truck driver partner with us you can click down below to login.',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PartnerLogin.id);
            },
            child: const Text('Login as a partner'),
            style: ElevatedButton.styleFrom(fixedSize: const Size(1, 60)),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'For moderation credentials only.',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ModeratorLogin.id);
            },
            child: const Text('Login as moderator'),
            style: ElevatedButton.styleFrom(fixedSize: const Size(1, 60)),
          ),
        ),
      ],
    );
  }
}
