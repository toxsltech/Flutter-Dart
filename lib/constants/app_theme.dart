/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Project imports:
import 'package:alanis/export.dart';

ThemeData themeData = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.white,
  accentColorBrightness: Brightness.light,
  appBarTheme: AppBarTheme(backgroundColor: primaryColorShades),
);

ThemeData themeDataDark = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  backgroundColor: Colors.black,
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.deepPurpleAccent,
  accentColorBrightness: Brightness.dark,
);
