import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/HelpPage/helppage.dart';
import 'package:flutter_course/Pages/MaintenancePage/maintenancepage.dart';
import 'package:flutter_course/Pages/ProfilePage/profilepage.dart';
import 'package:flutter_course/Pages/ShopPage/shoppage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/registerpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/welcomepage.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Pages/HomePage/homepage.dart';
import 'Pages/AccountSettings/accountsettingspage.dart';
import 'Pages/NearbyMechanic Page/nearbymechanic_page.dart';
import 'Pages/NearbyMechanic Page/nearbymechanicloading.dart';
import 'Pages/ReportBug/reportbugpage.dart';
import 'Pages/TowTruckPage/towtruck_page.dart';

bool loggedIn = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: pmTheme(),
      initialRoute: InitialPage.id,
      routes: {
        InitialPage.id: (context) =>
            loggedIn ? const InitialPage() : const WelcomePage(),
        NearbyMechanicLoading.id: (context) => const NavigatingPage(
              title: 'Nearby Mechanics',
              page: NearbyMechanicLoading(),
            ),
        NearbyMechanicPage.id: (context) => const NavigatingPage(
              title: 'Nearby Mechanics',
              page: NearbyMechanicPage(),
            ),
        TowTruckPage.id: (context) => const NavigatingPage(
              title: 'Tow Truck',
              page: TowTruckPage(),
            ),
        AccountSettingsPage.id: (context) => const NavigatingPage(
              title: 'Account Settings',
              page: AccountSettingsPage(),
            ),
        HelpPage.id: (context) => const NavigatingPage(
              title: 'Help',
              page: HelpPage(),
            ),
        ReportBugPage.id: (context) => const NavigatingPage(
              title: 'Report bug',
              page: ReportBugPage(),
            ),
        LoginPage.id: (context) => const NavigatingPage(
              title: 'Login',
              page: LoginPage(),
            ),
        RegisterPage.id: (context) => const NavigatingPage(
              title: 'Registeration',
              page: RegisterPage(),
            ),
        WelcomePage.id: (context) => const WelcomePage()
      },
    );
  }
}

class RawPage extends StatefulWidget {
  const RawPage(
      {Key? key,
      required this.body,
      required this.title,
      this.actions,
      this.leading,
      this.floatingButton,
      this.navigatingBar})
      : super(key: key);
  final Widget body;
  final Text title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? floatingButton;
  final Widget? navigatingBar;

  @override
  State<RawPage> createState() => _RawPageState();
}

class _RawPageState extends State<RawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: widget.leading,
          title: widget.title,
          actions: widget.actions),
      body: widget.body,
      floatingActionButton: widget.floatingButton,
      bottomNavigationBar: widget.navigatingBar,
    );
  }
}

class InitialPage extends StatefulWidget {
  static const String id = 'InitialPage';
  const InitialPage({
    Key? key,
  }) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int currentPageIndex = 0;
  PageController initialPageController = PageController();

  final _pageOptions = [
    const MyHomePage(),
    const ShopPage(),
    const MaintenancePage(),
    const ProfilePage()
  ];

  final _pageTitles = [
    'Pocket Mechanic',
    'Spare-parts Shop',
    'Maintenance Services',
    'My Profile'
  ];

  onTapped(int selectedIndex) {
    setState(() {
      currentPageIndex = selectedIndex;
    });
    initialPageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return RawPage(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image(
            image: AssetImage('assets/pmLogo3.png'),
          ),
        ),
      ),
      title: Text(_pageTitles[currentPageIndex]),
      actions: [
        PopupMenuButton(
          color: firstLayerColor,
          itemBuilder: (BuildContext context) => const <PopupMenuItem<String>>[
            PopupMenuItem(
              child: Text('Account settings'),
              value: 'Account settings',
            ),
            PopupMenuItem(
              child: Text('Help'),
              value: 'Help',
            ),
            PopupMenuItem(
              child: Text('Report bug'),
              value: 'Report bug',
            ),
            PopupMenuItem(
              child: Text('Logout'),
              value: 'Logout',
            ),
          ],
          onSelected: (value) {
            if (value == 'Account settings') {
              Navigator.pushNamed(context, AccountSettingsPage.id);
            }
            if (value == 'Help') {
              Navigator.pushNamed(context, HelpPage.id);
            }
            if (value == 'Report bug') {
              Navigator.pushNamed(context, ReportBugPage.id);
            }
            if (value == 'Logout') {
              loggedIn = false;
              Navigator.pushNamedAndRemoveUntil(
                  context, InitialPage.id, (route) => false);
            }
          },
        ),
      ],
      body: PageView(
        controller: initialPageController,
        children: _pageOptions,
        onPageChanged: (page) {
          setState(() {
            currentPageIndex = page;
          });
        },
      ),
      navigatingBar: BottomNavigationBar(
        onTap: (index) {
          onTapped(index);
        },
        currentIndex: currentPageIndex,
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

class NavigatingPage extends StatelessWidget {
  const NavigatingPage(
      {Key? key, required this.title, required this.page, this.floatingButton})
      : super(key: key);
  final String title;
  final Widget page;
  final FloatingActionButton? floatingButton;
  @override
  Widget build(BuildContext context) {
    return RawPage(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: Text(title),
      body: page,
      floatingButton: floatingButton,
    );
  }
}
