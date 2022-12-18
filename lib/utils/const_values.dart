// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Globals {
  static Color backgroundColor = Color.fromARGB(255, 20, 18, 23);
  static Color primary = const Color(0xFFE42F45);
  static Color text_color = Colors.white;
  static Color accentColor = const Color(0xFFB42B3F);
  static Color primary_2 = const Color(0xFF7CA0E5);

  static ThemeData themeData = ThemeData.dark().copyWith(
      textTheme: GoogleFonts.robotoTextTheme()
          .apply(bodyColor: text_color, displayColor: text_color),
      primaryColor: primary,
      backgroundColor: backgroundColor,
      inputDecorationTheme: inputDecorationTheme,
      textButtonTheme: buttonTheme,
      colorScheme: const ColorScheme.dark().copyWith(primary: backgroundColor));

  static InputDecorationTheme inputDecorationTheme =
      const InputDecorationTheme().copyWith(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(18),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        )),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    focusColor: backgroundColor,
  );

  static TextButtonThemeData buttonTheme = TextButtonThemeData(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(primary)));

  static TextStyle headerText = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static BoxDecoration backgroundGradient = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Globals.backgroundColor]));
}
