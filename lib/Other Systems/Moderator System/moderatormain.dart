import 'package:flutter/material.dart';
import 'package:flutter_course/Other%20Systems/Moderator%20System/modShop/addproduct.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'modShop/modshoppage.dart';
import 'submissionsPage/submissionspage.dart';

class ModeratorMain extends StatefulWidget {
  static const String id = 'ModeratorMain';
  const ModeratorMain({Key? key}) : super(key: key);

  @override
  State<ModeratorMain> createState() => _ModeratorMainState();
}

class _ModeratorMainState extends State<ModeratorMain> {
  int currentModPageIndex = 0;
  final _modPageOptions = [
    const Submissions(),
    const ModShop(),
  ];
  final _modPageTitles = [
    'Partnership submissions',
    'Shop Modification',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modPageTitles.elementAt(currentModPageIndex)),
        actions: [
          currentModPageIndex == 0
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: fifthLayerColor,
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: textColor),
                              ),
                              content: const Text(
                                  'Are you sure you want to logout?'),
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
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.red,
                  ))
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddProduct.id);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  )),
        ],
      ),
      body: _modPageOptions.elementAt(currentModPageIndex),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (pageIndex) {
            setState(() {
              currentModPageIndex = pageIndex;
            });
          },
          currentIndex: currentModPageIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.userPlus,
                ),
                label: 'Submissions'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shop,
                ),
                label: 'Shop Modification'),
          ]),
    );
  }
}
