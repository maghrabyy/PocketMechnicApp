import 'package:flutter/material.dart';

const fifthLayerColor = Color(0xFF533758);
const fourthLayerColor = Color(0xFF82568a);
const thirdLayerColor = Color(0xFF1e151e);
const secondLayerColor = Color(0xFF0d060d);
const firstLayerColor = Color(0xFF120812);
const textColor = Colors.white;
const iconColor = Colors.white;

ThemeData pmTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(primary: secondLayerColor, secondary: fourthLayerColor),
    cardTheme: const CardTheme(color: fifthLayerColor),
    listTileTheme:
        const ListTileThemeData(textColor: textColor, iconColor: iconColor),
    scaffoldBackgroundColor: firstLayerColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: secondLayerColor,
      selectedItemColor: fourthLayerColor,
      unselectedItemColor: textColor,
      selectedIconTheme: IconThemeData(color: fourthLayerColor),
      unselectedIconTheme: IconThemeData(color: iconColor),
    ),
    popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(color: textColor, fontFamily: 'Kanit')),
    iconTheme: const IconThemeData(color: iconColor, size: 50),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: textColor,
        fontFamily: 'Kanit',
      ),
    ),
  );
}
