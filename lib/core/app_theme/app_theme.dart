import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // primarySwatch: Colors.brown,
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Montserrat Bold',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat Bold'),
        backgroundColor: const Color(0xFFB55C50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      shadowColor: Colors.black26,
    ),
  );
}
