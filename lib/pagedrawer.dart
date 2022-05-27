import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/AboutUsPage/aboutus_page.dart';
import 'package:flutter_course/Pages/BecomePartner/becomepartner.dart';
import 'package:flutter_course/Pages/BecomePartner/submittedrequest.dart';
import 'package:flutter_course/Pages/ShopPage/orders.dart';
import 'package:flutter_course/Services/database.dart';
import 'package:flutter_course/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/AccountSettings/accountsettingspage.dart';
import 'Pages/HelpPage/helppage.dart';
import 'Pages/ReportBug/reportbugpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageDrawer extends StatelessWidget {
  PageDrawer({
    Key? key,
  }) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/welcomePage.jpg'),
                  fit: BoxFit.cover)),
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: const Text(
            'Pocket Mechanic',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile(context, 'Account Settings', Icons.settings,
            AccountSettingsPage.id),
        buildListTile(context, 'Help', Icons.help, HelpPage.id),
        buildListTile(context, 'About us', FontAwesomeIcons.exclamationCircle,
            AboutUsPage.id),
        buildListTile(
            context, 'Report bug', Icons.bug_report, ReportBugPage.id),
        becomePartnerTile(context),
        buildListTile(context, 'Orders', Icons.shopping_bag, MyOrders.id),
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: logoutTile(context),
          ),
        ),
      ],
    );
  }

  ListTile logoutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        size: 40,
      ),
      title: Text(
        'Logout',
        style: GoogleFonts.patuaOne(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      onTap: () async {
        logout(context);
      },
    );
  }

  ListTile becomePartnerTile(BuildContext context) {
    return ListTile(
      leading: const Icon(
        FontAwesomeIcons.userPlus,
        size: 30,
      ),
      title: Text(
        'Become a partner',
        style: GoogleFonts.patuaOne(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      onTap: () async {
        if (await checkIfDocExists('PartnershipSubmission',
                await getUserID(_auth.currentUser!.uid)) ==
            false) {
          Navigator.pushNamed(context, BecomePartner.id);
        } else {
          Navigator.pushNamed(context, SubmittedRequest.id);
        }
      },
    );
  }

  ListTile buildListTile(
      BuildContext context, String text, IconData drawerIcon, String pageId) {
    return ListTile(
      leading: Icon(
        drawerIcon,
        size: 30,
      ),
      title: Text(
        text,
        style: GoogleFonts.patuaOne(fontSize: 25, fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.pushNamed(context, pageId);
      },
    );
  }
}
