/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

ThemeData themeData = new ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.white,
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: COLOR_white,
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 14,
        fontWeight: FontWeight.w400),
    bodyText1: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
    button: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    caption: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    headline4: TextStyle(
        color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w900),
    headline3: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    headline5: TextStyle(
        color: COLOR_middleBlue, fontSize: 17, fontWeight: FontWeight.w800),
    headline1: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
    headline2: TextStyle(
        color: COLOR_pinkM, fontSize: 20, fontWeight: FontWeight.w600),
    overline: TextStyle(color: Colors.black),
    subtitle1: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    subtitle2: TextStyle(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: COLOR_middleBlueM),
  accentTextTheme: TextTheme(
    bodyText2: TextStyle(
        color: COLOR_pinkM.withOpacity(0.8),
        fontSize: 14,
        fontWeight: FontWeight.w800),
    bodyText1: TextStyle(
        color: COLOR_pinkM, fontSize: 14, fontWeight: FontWeight.w400),
    button: TextStyle(color: COLOR_pinkM, fontWeight: FontWeight.w600),
    caption: TextStyle(color: COLOR_pinkM, fontWeight: FontWeight.w300),
    headline4: TextStyle(
        color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w900),
    headline3: TextStyle(color: COLOR_pinkM),
    headline6: TextStyle(color: COLOR_pinkM),
    headline5: TextStyle(
        color: COLOR_middleBlue, fontSize: 17, fontWeight: FontWeight.w800),
    headline1: TextStyle(
        color: COLOR_pinkM, fontSize: 24, fontWeight: FontWeight.w600),
    headline2: TextStyle(
        color: COLOR_pinkM, fontSize: 20, fontWeight: FontWeight.w600),
    overline: TextStyle(color: COLOR_pinkM),
    subtitle1: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    subtitle2: TextStyle(color: COLOR_pinkM),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: outlineBorder(),
      enabledBorder: outlineBorder(),
      focusedBorder: outlineBorder(),
      errorBorder: outlineBorder(),
      disabledBorder: outlineBorder(),
      focusedErrorBorder: outlineBorder(),
      labelStyle: TextStyle(
          color: COLOR_lightGray, fontSize: 16.0, fontWeight: FontWeight.w400)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: FONT_14, fontWeight: FontWeight.w600)),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_white),
      foregroundColor: MaterialStateProperty.all<Color>(COLOR_violetM),
      overlayColor: MaterialStateProperty.all<Color>(COLOR_violetM.shade50),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: FONT_14, fontWeight: FontWeight.w600)),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_violetM),
      foregroundColor: MaterialStateProperty.all<Color>(COLOR_white),
      overlayColor: MaterialStateProperty.all<Color>(COLOR_violetM.shade50),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: FONT_14, fontWeight: FontWeight.w600)),
      foregroundColor: MaterialStateProperty.all<Color>(COLOR_violetM.shade50),
      overlayColor: MaterialStateProperty.all<Color>(COLOR_violetM),
    ),
  ),
);

OutlineInputBorder outlineBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        width: 1,
        color: COLOR_lightGray.withOpacity(0.5),
      ),
    );
