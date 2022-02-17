import 'package:flutter/material.dart';

Color containerColor = const Color(0xFF1e151e);
Color tappedButtonColor = const Color(0xFF82568a);
Color topContainerColor1 = containerColor;
Color topContainerColor2 = containerColor;
Color topContainerColor3 = containerColor;
Color appBarColor = const Color(0xFF0d060d);
Color appBackgroundColor = const Color(0xFF120812);
Color bodyTextColor = Colors.white;

ThemeData pmTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: appBarColor,
    ),
    sliderTheme: SliderThemeData(
      thumbColor: tappedButtonColor,
      overlayColor: const Color(0x6082568a),
      activeTrackColor: tappedButtonColor,
      inactiveTrackColor: const Color(0x2082568a),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 25),
    ),
    cardTheme: const CardTheme(color: Color(0xFF533758)),
    listTileTheme:
        ListTileThemeData(textColor: bodyTextColor, iconColor: bodyTextColor),
    scaffoldBackgroundColor: appBarColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: appBarColor,
      selectedItemColor: tappedButtonColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: tappedButtonColor),
      unselectedIconTheme: const IconThemeData(color: Colors.white),
    ),
    popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(color: Colors.white, fontFamily: 'Kanit')),
    iconTheme: const IconThemeData(color: Colors.white, size: 50),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: bodyTextColor,
        fontFamily: 'Kanit',
      ),
    ),
  );
}
