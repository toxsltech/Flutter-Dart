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

Color grey = HexColor("#6F6969");
Color primaryColor = HexColor("#CD9AA7");
Color darkPrimaryColor = HexColor("#B8676E");
Color darkPink = HexColor("#82c9ff");
Color toastColor = HexColor("#FF0FB5");
Color shimmerBodyColor = HexColor("#f4f5f5");
Color cropBG = HexColor("#777777");
Color shimmerhighlightColor = Colors.grey[350];
Color shimmerbaseColor = Colors.grey[500];

Color bg15 = HexColor("#F9FCFF");
Color bg40 = HexColor("#F6F3FF");
Color bg70 = HexColor("#FFEAF9");
Color bg100 = HexColor("#F4E9EC");
Color bg125 = HexColor("#FFF1E2");

class HexColor extends Color {
  static int getcolorfromHex(String hexcolor) {
    hexcolor = hexcolor.toUpperCase().replaceAll("#", "");
    if (hexcolor.length == 6) {
      hexcolor = "FF" + hexcolor;
    }
    return int.parse(hexcolor, radix: 16);
  }

  HexColor(final String hexColor) : super(getcolorfromHex(hexColor));
}

const MaterialColor primaryColorShades = MaterialColor(
  0xFFCD9AA7,
  <int, Color>{
    50: Color(0xDCD9AA7),
    100: Color(0x1ACD9AA7),
    200: Color(0x33CD9AA7),
    300: Color(0x4DCD9AA7),
    400: Color(0x66CD9AA7),
    500: Color(0x80CD9AA7),
    600: Color(0x996F6969),
    700: Color(0xB3CD9AA7),
    800: Color(0xCCCD9AA7),
    900: Color(0xE6CD9AA7),
  },
);
