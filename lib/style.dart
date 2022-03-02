import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const fifthLayerColor = Color(0xFF82568a);
const fourthLayerColor = Color(0xFF533758);
const thirdLayerColor = Color(0xFF1e151e);
const secondLayerColor = Color(0xFF0d060d);
const firstLayerColor = Color(0xFF120812);
const textColor = Colors.white;
const iconColor = Colors.white;
const loginButtonColor = Colors.grey;
Color registerButtonColor = Colors.grey.shade600;

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
    popupMenuTheme: PopupMenuThemeData(
      textStyle: GoogleFonts.kanit(
        color: textColor,
      ),
    ),
    iconTheme: const IconThemeData(color: iconColor, size: 50),
    textTheme: TextTheme(
      subtitle1: const TextStyle(color: textColor),
      bodyText2: GoogleFonts.kanit(
        color: textColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: firstLayerColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: fourthLayerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: fifthLayerColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(fifthLayerColor),
      ),
    ),
  );
}
