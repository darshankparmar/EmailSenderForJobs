import 'package:flutter/material.dart';
import 'app_color.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: AppColor.white,
        fontFamily: "Inter",
        cardColor: AppColor.white,
        hintColor: AppColor.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColor.black, // Your accent color
          brightness: Brightness.light,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle:
              TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
          floatingLabelStyle: TextStyle(color: AppColor.black),
          errorStyle:
              TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          hintStyle: TextStyle(color: AppColor.black),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.7, color: AppColor.red)),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.7, color: AppColor.red)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColor.primary)),
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80.0,
          backgroundColor: AppColor.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppColor.black),
          titleTextStyle: TextStyle(color: AppColor.black),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: AppColor.black,
        fontFamily: "Inter",
        cardColor: Colors.grey[700],
        hintColor: Colors.white.withOpacity(0.5),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColor.white, // Your accent color
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle:
              TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
          floatingLabelStyle: TextStyle(color: AppColor.white),
          errorStyle:
              TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          hintStyle: TextStyle(color: AppColor.white),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.7, color: AppColor.red)),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.7, color: AppColor.red)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColor.white)),
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80.0,
          backgroundColor: AppColor.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppColor.white),
          titleTextStyle: TextStyle(color: AppColor.white),
        ),
      );
}
