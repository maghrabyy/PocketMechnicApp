import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const splashScreenColor = Color(0xFF322034);
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
      splashColor: fourthLayerColor,
      highlightColor: fourthLayerColor,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: secondLayerColor, secondary: fourthLayerColor),
      cardTheme: const CardTheme(color: fifthLayerColor),
      listTileTheme: const ListTileThemeData(
        textColor: textColor,
        iconColor: iconColor,
      ),
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
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.grey),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: fifthLayerColor),
        alignLabelWithHint: true,
        filled: true,
        fillColor: firstLayerColor,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fifthLayerColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fifthLayerColor, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fourthLayerColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all(fifthLayerColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(fifthLayerColor),
        checkColor: MaterialStateProperty.all(thirdLayerColor),
        overlayColor: MaterialStateProperty.all(fourthLayerColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(fifthLayerColor),
      ));
}
