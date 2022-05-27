import 'package:flutter/material.dart';
import 'package:flutter_course/main.dart';

class MechanicHomePage extends StatelessWidget {
  static const String id = 'MechanicHomePage';
  const MechanicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Text('Welcome Partner!'),
          ElevatedButton(
              onPressed: () {
                logout(context);
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
