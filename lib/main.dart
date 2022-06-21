import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Other%20Systems/Moderator%20System/modShop/addproduct.dart';
import 'package:flutter_course/Other%20Systems/Moderator%20System/moderatormain.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/PartnerProfile/partner_settings.dart';
import 'package:flutter_course/Other%20Systems/Partner%20System/partnermain.dart';
import 'package:flutter_course/Pages/AboutUsPage/aboutus_page.dart';
import 'package:flutter_course/Pages/BecomePartner/submittedrequest.dart';
import 'package:flutter_course/Pages/HelpPage/helppage.dart';
import 'package:flutter_course/Pages/BecomePartner/becomepartner.dart';
import 'package:flutter_course/Pages/MaintenancePage/maintenancepage.dart';
import 'package:flutter_course/Pages/ProfilePage/profilepage.dart';
import 'package:flutter_course/Pages/ReportBug/myreports.dart';
import 'package:flutter_course/Pages/RequestMechanicPage/requestmechanicpage.dart';
import 'package:flutter_course/Pages/ShopPage/favouriteitems.dart';
import 'package:flutter_course/Pages/ShopPage/orders.dart';
import 'package:flutter_course/Pages/ShopPage/shoppage.dart';
import 'package:flutter_course/Pages/ShopPage/shoppingcart.dart';
import 'package:flutter_course/Pages/TowTruckPage/towtruck_drivers.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/inputvehicledata.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginoptions.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/loginpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/moderatorlogin.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/partnerlogin.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/registerpage.dart';
import 'package:flutter_course/Pages/UnloggedIn%20Pages/welcomepage.dart';
import 'package:flutter_course/logout.dart';
import 'package:flutter_course/pagedrawer.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_course/Pages/HomePage/homepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Pages/AccountSettings/accountsettingspage.dart';
import 'Pages/ReportBug/reportbugpage.dart';
import 'Pages/TowTruckPage/towtruck_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/UnloggedIn Pages/resetpassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart';

final _firestore = FirebaseFirestore.instance;
final userCollections = _firestore.collection('Users');
final _auth = FirebaseAuth.instance;

List<Widget> shopAppBarActions(BuildContext context) {
  return [
    IconButton(
      onPressed: () {
        Navigator.pushNamed(context, FavouriteSparePartItems.id);
      },
      icon: const Icon(
        FontAwesomeIcons.solidHeart,
        size: 20,
      ),
    ),
    IconButton(
      onPressed: () {
        Navigator.pushNamed(context, ShoppingCart.id);
      },
      icon: Stack(children: [
        Badge(
          position: const BadgePosition(bottom: 1, start: 15),
          badgeColor: fourthLayerColor,
          badgeContent: StreamBuilder(
              stream: _firestore
                  .collection('shoppingCart')
                  .doc(_auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text('.');
                } else {
                  int cartListItemsLength = snapshot.data['Cart'].length;
                  return Positioned(
                    top: 3.0,
                    left: 4.0,
                    child: Text(
                      cartListItemsLength.toString(),
                    ),
                  );
                }
              }),
          child: const Icon(
            FontAwesomeIcons.shoppingCart,
            size: 20,
          ),
        ),
      ]),
    ),
  ];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        InitialPage.id: (context) => const InitialPage(),
        FavouriteSparePartItems.id: (context) => const NavigatingPage(
              title: 'My Favourites',
              page: FavouriteSparePartItems(),
            ),
        ShoppingCart.id: (context) => const NavigatingPage(
              title: 'Shopping Cart',
              page: ShoppingCart(),
            ),
        MyOrders.id: (context) => const NavigatingPage(
              title: 'My Orders',
              page: MyOrders(),
            ),
        RequestMechanicPage.id: (context) => const NavigatingPage(
              title: 'Request Mechanic',
              page: RequestMechanicPage(),
            ),
        TowTruckPage.id: (context) => const NavigatingPage(
              title: 'Tow Truck',
              page: TowTruckPage(),
            ),
        TowTruckDrivers.id: (context) => const NavigatingPage(
              title: 'Tow Truck Drivers',
              page: TowTruckDrivers(),
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
        MyReports.id: (context) => const NavigatingPage(
              title: 'My Reports',
              page: MyReports(),
            ),
        LoginPage.id: (context) => const NavigatingPage(
              title: 'Login',
              page: LoginPage(),
            ),
        LoginOptions.id: (context) => const NavigatingPage(
              title: 'Login Options',
              page: LoginOptions(),
            ),
        PartnerLogin.id: (context) => const NavigatingPage(
              title: 'Partner Login',
              page: PartnerLogin(),
            ),
        PartnerMain.id: (context) => const PartnerMain(),
        PartnerSettings.id: (context) => const NavigatingPage(
              title: 'Settings',
              page: PartnerSettings(),
            ),
        ModeratorLogin.id: (context) => const NavigatingPage(
              title: 'Moderator Login',
              page: ModeratorLogin(),
            ),
        AddProduct.id: (context) => const NavigatingPage(
              title: 'Add Product',
              page: AddProduct(),
            ),
        ModeratorMain.id: (context) => const ModeratorMain(),
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
        BecomePartner.id: (context) => const NavigatingPage(
              title: 'Become a partner',
              page: BecomePartner(
                joinAsPartner: false,
              ),
            ),
        SubmittedRequest.id: (context) => const NavigatingPage(
              title: 'Submitted Request',
              page: SubmittedRequest(),
            ),
      },
    );

    /*_auth.currentUser != null
        ? StreamBuilder(
            stream: _firestore
                .collection('Users')
                .doc(_auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const SplashScreenLoading();
              } else {
                return AppRoutes(
                    theInitialPage: (context) => _auth.currentUser != null
                        ? snapshot.data['userType'] == 'Customer'
                            ? snapshot.data['Vehicle.VehicleID'] != ' ' &&
                                    snapshot.data['Vehicle.VehicleName'] != ''
                                ? const InitialPage()
                                : const NavigatingPage(
                                    title: 'My vehicle',
                                    page: InputVehicleData(),
                                    canPop: false,
                                  )
                            : snapshot.data['userType'] == 'Partner'
                                ? const PartnerMain()
                                : const ModeratorMain()
                        : const WelcomePage());
              }
            })
        : AppRoutes(
            theInitialPage: (context) => _auth.currentUser != null
                ? const InitialPage()
                : const WelcomePage(),
          );*/
  }
}

class SplashScreenLoading extends StatelessWidget {
  const SplashScreenLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: splashScreenColor,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              width: 250,
              image: AssetImage('assets/PocketMechanicLogoLoading.png'),
            ),
            SizedBox(
              height: 30,
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

class InitialPage extends StatefulWidget {
  const InitialPage({
    Key? key,
  }) : super(key: key);
  static const String id = 'InitialPage';
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return _auth.currentUser != null
        ? StreamBuilder(
            stream: _firestore
                .collection('Users')
                .doc(_auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const SplashScreenLoading();
              } else {
                return _auth.currentUser != null
                    ? snapshot.data['userType'] == 'Customer'
                        ? snapshot.data['Vehicle.VehicleID'] != ' ' &&
                                snapshot.data['Vehicle.VehicleName'] != ''
                            ? const MainCustomerScreen()
                            : const NavigatingPage(
                                title: 'My vehicle',
                                page: InputVehicleData(),
                                canPop: false,
                              )
                        : snapshot.data['userType'] == 'Partner'
                            ? const PartnerMain()
                            : const ModeratorMain()
                    : const WelcomePage();
              }
            })
        : _auth.currentUser != null
            ? const MainCustomerScreen()
            : const WelcomePage();
  }
}

class MainCustomerScreen extends StatefulWidget {
  const MainCustomerScreen({Key? key}) : super(key: key);

  @override
  State<MainCustomerScreen> createState() => _MainCustomerScreenState();
}

class _MainCustomerScreenState extends State<MainCustomerScreen> {
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

  List<Widget> topActions() {
    if (currentPageIndex == 3) {
      return [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AccountSettingsPage.id);
          },
          icon: const Icon(
            Icons.settings,
            size: 20,
          ),
        ),
        const PopupMenu()
      ];
    } else if (currentPageIndex == 2) {
      return shopAppBarActions(context);
    } else {
      return const [PopupMenu()];
    }
  }

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
        actions: topActions(),
      ),
      drawer: const Drawer(
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
      iconSize: 30,
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
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    backgroundColor: fifthLayerColor,
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: textColor),
                    ),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            logout(context);
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: textColor),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: textColor),
                          )),
                    ],
                  ));
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
      this.canPop,
      this.actions,
      this.onPressedBack})
      : super(key: key);
  final String title;
  final Widget page;
  final FloatingActionButton? floatingButton;
  final bool? canPop;
  final List<Widget>? actions;
  final VoidCallback? onPressedBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: canPop == false
            ? null
            : IconButton(
                onPressed: onPressedBack ??
                    () {
                      Navigator.pop(context);
                    },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                )),
        title: Text(title),
        actions: actions,
      ),
      body: page,
      floatingActionButton: floatingButton,
    );
  }
}
