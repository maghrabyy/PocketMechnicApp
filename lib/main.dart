import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/HomePage/homepage.dart';

import 'NearbyMechanic Page/nearbymechanic_page.dart';
import 'TowTruckPage/towtruck_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: pmTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialPage(),
        'NearbyMechanicPage': (context) => const NavigatingPage(
              title: 'Nearby Mechanics',
              page: NearbyMechanicPage(),
            ),
        'TowTruckPage': (context) => const NavigatingPage(
              title: 'Tow Truck',
              page: TowTruckPage(),
            ),
      },
    );
  }
}

class Page extends StatelessWidget {
  const Page(
      {Key? key,
      required this.body,
      required this.title,
      this.actions,
      this.leading,
      this.floatingButton})
      : super(key: key);
  final Widget body;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? floatingButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: leading, title: Text(title), actions: actions),
      body: body,
      floatingActionButton: floatingButton,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_sharp),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Repair',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Page(
      leading: Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image(
            image: AssetImage('assets/pmLogo3.png'),
          ),
        ),
      ),
      title: 'Pocket Mechanic',
      actions: [
        IconButton(
          onPressed: null,
          icon: Icon(Icons.more_vert),
        ),
      ],
      body: MyHomePage(),
    );
  }
}

class NavigatingPage extends StatelessWidget {
  const NavigatingPage({Key? key, required this.title, required this.page})
      : super(key: key);
  final String title;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return Page(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: title,
        body: page);
  }
}
