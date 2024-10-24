import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  // Custom colors


  // Text Theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: Color(0xFF868889),          // Text color
    ),
    displayMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: Color(0xFF868889),
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Color(0xFF868889),
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
    ),
    titleMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Color(0xFF868889),
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Color(0xFF868889),
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Color(0xFF868889),
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Color(0xFF868889),
    ),
  ),

  // Additional Theme settings
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),  // background (FFFFFF)
  primaryColor: const Color(0xFF6CC51D),             // primary
  cardColor: const Color(0xFFF5F5F5),                // background
  dividerColor: const Color(0xFFEBEBEB),             // border (EBEBEB)
  // You can add more UI element colors here if needed
);
