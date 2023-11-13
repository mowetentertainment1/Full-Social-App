import 'package:flutter/material.dart';

import 'color.dart';

ThemeData lightTheme = ThemeData(
    //colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
    //useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.mainColor),

      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: AppColor.mainColor),
    textButtonTheme:  TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:  MaterialStateProperty.all(AppColor.mainColor),
      )
    )   ,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.mainColor
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        color: AppColor.textColor,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: AppColor.textColor,
      ),

      labelMedium: TextStyle(
        fontSize: 12,
        color: AppColor.textColor,
        height: 1.3,
      ),
    ),
    fontFamily: 'Jannah');

ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.mainColor),
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(color: AppColor.mainColor),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        color: AppColor.textColor,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: AppColor.textColor,
      ),
    ),
    fontFamily: 'Robot');
