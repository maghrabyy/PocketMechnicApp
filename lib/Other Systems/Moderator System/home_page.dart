import 'package:flutter/material.dart';
import 'package:flutter_course/main.dart';

class ModeratorHomePage extends StatelessWidget {
  static const String id = 'ModeratorHomePage';
  const ModeratorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const Text('Welcome Moderator!'),
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
