                                                    import 'package:flutter/material.dart';

import '../resource/color_manager.dart';
import '../resource/font_manager.dart';
import '../resource/size_manager.dart';


//!App Text Theme
TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs28,
    fontWeight: FontWeight.w400,
    color: AppColorManager.white,
  ),
  displayMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs16,
    fontWeight: FontWeight.w400,
    color: AppColorManager.white,
  ),
  displaySmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    color: AppColorManager.black,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs20,
    fontWeight: FontWeight.w600,
    color: AppColorManager.textAppColor,
  ),
  headlineMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs16,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  headlineSmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  titleLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs22,
    fontWeight: FontWeight.w600,
    color: AppColorManager.white,
  ),
  bodyLarge: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.normal,
    color: AppColorManager.textAppColor,
  ),
  bodyMedium: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs14,
    fontWeight: FontWeight.w400,
    color: AppColorManager.textAppColor,
  ),
  bodySmall: TextStyle(
    fontFamily: FontFamilyManager.cairo,
    fontSize: FontSizeManager.fs11,
    fontWeight: FontWeight.w400,
    color: AppColorManager.grey,
  ),
);

//!App Light Theme
ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorManager.background,
    ),
    brightness: Brightness.light,
    primaryColorLight: AppColorManager.blue,
    scaffoldBackgroundColor: AppColorManager.background,
    splashColor: AppColorManager.transparent,
    fontFamily: FontFamilyManager.cairo,
    primaryColor: AppColorManager.blue,
    textTheme: appTextTheme,

    progressIndicatorTheme:
    const ProgressIndicatorThemeData(color: AppColorManager.blue),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorManager.blue,
        foregroundColor: AppColorManager.blue),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorManager.white,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.blue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.blue,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w16, vertical: AppHeightManager.h1point5),
      hintStyle: TextStyle(
        color: AppColorManager.lightGreyOpacity6,
        fontSize: FontSizeManager.fs16,
        fontWeight: FontWeight.normal,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColorManager.blue,
      ),
      iconColor: AppColorManager.blue,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorManager.blue),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
    ),
    // tabBarTheme: TabBarTheme(
    //   indicator: BoxDecoration(
    //     color: AppColorManager.blue,
    //     borderRadius: BorderRadius.circular(AppRadiusManager.r5),
    //   ),
    // ),
    colorScheme: const ColorScheme.light(primary: AppColorManager.blue)
        .copyWith(
        secondary:
        AppColorManager.blue), // Define the default button theme
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColorManager.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColorManager.white,
      headerBackgroundColor: AppColorManager.white,
      headerForegroundColor: AppColorManager.white
    ),



  );
}
