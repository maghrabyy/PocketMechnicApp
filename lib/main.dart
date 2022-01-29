import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: pmTheme(),
      home: const MyHomePage(title: 'Pocket Mechanic'),
    );
  }
}
