import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/AboutUsPage/aboutus_page.dart';
import 'package:flutter_course/Pages/HelpPage/helppage.dart';
import 'package:flutter_course/Pages/JoinAsPartner/joinaspartner.dart';
import 'package:flutter_course/Pages/MaintenancePage/maintenancepage.dart';
import 'package:flutter_course/Pages/ProfilePage/profilepage.dart';
import 'package:flutter_course/Pages/RequestMechanicPage/requestmechanicpage.dart';
import 'package:flutter_course/Pages/ShopPage/shoppage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/inputvehicledata.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/registerpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/welcomepage.dart';
import 'package:flutter_course/pagedrawer.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Pages/HomePage/homepage.dart';
import 'Pages/AccountSettings/accountsettingspage.dart';
import 'Pages/NearbyMechanic Page/nearbymechanic_page.dart';
import 'Pages/NearbyMechanic Page/nearbymechanicloading.dart';
import 'Pages/ReportBug/reportbugpage.dart';
import 'Pages/TowTruckPage/towtruck_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/UnloggedIn Pages/resetpassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final userCollections = _firestore.collection('Users');
final _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/welcomePage.jpg'), context);
    return FirebaseAuth.instance.currentUser != null
        ? StreamBuilder(
            stream: _firestore
                .collection('Users')
                .doc(_auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: fourthLayerColor,
                  child: const Center(
                    child: Text(
                      'Pocket Mechanic',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lobster'),
                    ),
                  ),
                );
              } else {
                return AppRoutes(
                  theInitialPage: (context) => _auth.currentUser != null
                      ? snapshot.data['Vehicle.VehicleID'] != '' &&
                              snapshot.data['Vehicle.VehicleName'] != ''
                          ? const InitialPage()
                          : const NavigatingPage(
                              title: 'My vehicle',
                              page: InputVehicleData(),
                              canPop: false,
                            )
                      : const WelcomePage(),
                );
              }
            })
        : AppRoutes(
            theInitialPage: (context) => _auth.currentUser != null
                ? const InitialPage()
                : const WelcomePage(),
          );
  }
}

class AppRoutes extends StatelessWidget {
  const AppRoutes({Key? key, required this.theInitialPage}) : super(key: key);
  final Widget Function(BuildContext) theInitialPage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: pmTheme(),
      initialRoute: InitialPage.id,
      routes: {
        InitialPage.id: theInitialPage,
        NearbyMechanicLoading.id: (context) => const NearbyMechanicLoading(),
        NearbyMechanicPage.id: (context) => const NavigatingPage(
              title: 'Nearby Mechanics',
              page: NearbyMechanicPage(),
            ),
        RequestMechanicPage.id: (context) => const NavigatingPage(
              title: 'Request Mechanic',
              page: RequestMechanicPage(),
            ),
        TowTruckPage.id: (context) => const NavigatingPage(
              title: 'Tow Truck',
              page: TowTruckPage(),
            ),
        AboutUsPage.id: (context) => const NavigatingPage(
              title: 'About us',
              page: AboutUsPage(),
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
        ResetPassword.id: (context) => const NavigatingPage(
              title: 'Reset Password',
              page: ResetPassword(),
            ),
        InputVehicleData.id: (context) => const NavigatingPage(
              title: 'My vehicle',
              page: InputVehicleData(),
              canPop: false,
            ),
        InputVehicleData.idCanPop: (context) => const NavigatingPage(
              title: 'My vehicle',
              page: InputVehicleData(),
            ),
        JoinAsPartner.id: (context) => const NavigatingPage(
              title: 'Join as Partner',
              page: JoinAsPartner(),
            ),
      },
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({
    Key? key,
  }) : super(key: key);
  static const String id = 'InitialPage';
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int currentPageIndex = 0;
  PageController initialPageController = PageController();

  final _pageOptions = [
    const MyHomePage(),
    const MaintenancePage(),
    const ShopPage(),
    const ProfilePage()
  ];

  final _pageTitles = [
    'Pocket Mechanic',
    'Maintenance Services',
    'Spare-parts Shop',
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => RawMaterialButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            splashColor: firstLayerColor,
            highlightColor: firstLayerColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/pmLogo3.png'),
                ),
              ),
            ),
          ),
        ),
        title: Text(_pageTitles[currentPageIndex]),
        actions: [
          currentPageIndex != 3
              ? const PopupMenu()
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AccountSettingsPage.id);
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 20,
                  ),
                ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: secondLayerColor,
        child: PageDrawer(),
      ),
      body: PageView(
        controller: initialPageController,
        children: _pageOptions,
        onPageChanged: (page) {
          setState(() {
            currentPageIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.car_repair),
            label: 'Maintenance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_sharp),
            label: 'Shop',
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

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
      onSelected: (value) async {
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
          await _auth.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, InitialPage.id, (route) => false);
        }
      },
    );
  }
}

class NavigatingPage extends StatelessWidget {
  const NavigatingPage(
      {Key? key,
      required this.title,
      required this.page,
      this.floatingButton,
      this.canPop})
      : super(key: key);
  final String title;
  final Widget page;
  final FloatingActionButton? floatingButton;
  final bool? canPop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: canPop == false
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                )),
        title: Text(title),
      ),
      body: page,
      floatingActionButton: floatingButton,
    );
  }
}
