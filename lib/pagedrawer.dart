import 'package:flutter/material.dart';
import 'package:flutter_course/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/AccountSettings/accountsettingspage.dart';
import 'Pages/HelpPage/helppage.dart';
import 'Pages/ReportBug/reportbugpage.dart';

class PageDrawer extends StatelessWidget {
  const PageDrawer({
    Key? key,
  }) : super(key: key);

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
            HelpPage.id),
        buildListTile(
            context, 'Report bug', Icons.bug_report, ReportBugPage.id),
        Expanded(
            child: Align(
                alignment: Alignment.bottomLeft, child: logoutTile(context))),
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
      onTap: () {
        loggedIn = false;
        Navigator.pushNamedAndRemoveUntil(
            context, InitialPage.id, (route) => false);
      },
    );
  }

  ListTile buildListTile(
      BuildContext context, String text, IconData drawerIcon, String pageId) {
    return ListTile(
      leading: Icon(
        drawerIcon,
        size: 40,
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
