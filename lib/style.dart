import 'package:flutter/material.dart';

const fourthLayerColor = Color(0xFF82568a);
const thirdLayerColor = Color(0xFF1e151e);
const secondLayerColor = Color(0xFF0d060d);
const firstLayerColor = Color(0xFF120812);
const bodyTextColor = Colors.white;

ThemeData pmTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(primary: secondLayerColor, secondary: fourthLayerColor),
    cardTheme: const CardTheme(color: Color(0xFF533758)),
    listTileTheme: const ListTileThemeData(
        textColor: bodyTextColor, iconColor: bodyTextColor),
    scaffoldBackgroundColor: firstLayerColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: secondLayerColor,
      selectedItemColor: fourthLayerColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: fourthLayerColor),
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
    popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
    iconTheme: const IconThemeData(color: Colors.white, size: 50),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: bodyTextColor,
        fontFamily: 'Kanit',
      ),
    ),
  );
}
