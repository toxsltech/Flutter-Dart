/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Project imports:
import 'package:alanis/export.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';


String sentenceCase(String s) => s[0].toUpperCase() + s.substring(1);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: "Password can't be empty."),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Password must have at least one special character')
]);

String whatTime(testIndex, {lessThanAMinute = false}) {
  var time =
      TimeAgo.timeAgoSinceDate(testIndex, lessThanAMinute: lessThanAMinute);
  return time;
}

hideKeyBoard({BuildContext context}) => FocusScope.of(context).unfocus();

// Connectivity
Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  switch (result) {
    case ConnectivityResult.wifi:
      HelperWidget.flashBar(
          message: Strings.online,
          color: Colors.green,
          context: GlobalVariable.navState.currentContext);
      break;
    case ConnectivityResult.mobile:
      HelperWidget.flashBar(
          message: Strings.online,
          color: Colors.green,
          context: GlobalVariable.navState.currentContext);
      break;
    case ConnectivityResult.none:
      HelperWidget.flashBar(
          message: Strings.offline,
          color: Colors.red,
          context: GlobalVariable.navState.currentContext);
      break;
    default:
      break;
  }
}

class HelperUtility {
  /* ===================================================== Text Style light ===================================================*/

  static textStyle({Color color, double fontsize, double height}) {
    return TextStyle(
        fontSize: fontsize,
        color: color,
        height: height,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.productSans);
  }

  /* ===================================================== Text Style Bold ===================================================*/

  static textStyleBold(
      {Color color, double fontsize, FontWeight fontWeight, double height}) {
    return TextStyle(
        fontSize: fontsize,
        color: color,
        height: height,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontFamily: FontFamily.productSans);
  }

  /*================================================== On Back Press Screen ============================================*/

  static onBackPress({context}) {
    Navigator.pop(context, true);
  }

  static pushNamed({context, String route, arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static pushReplacementNamed({context, String route, arguments}) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  }

  static pushNameRemoveUntil({context, String route, arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static void pushReplacement({context, route}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  /*================================================== push Screens  ====================================================*/

  static void push({context, route}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  /*================================================= push screen with name ============================================*/

  static pushAndRemoveUntil({context, route}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => route),
        (Route<dynamic> route) => false);
  }

  /* ================================================= full width ===========================================================*/

  static fullWidthScreen({context}) {
    return MediaQuery.of(context).size.width;
  }

  /*====================================================== full height ======================================================*/

  static fullheightcreen({context}) {
    return MediaQuery.of(context).size.height;
  }

//  Testing Chat
  static imageContainer(
      {double height,
      double width,
      Color color,
      double radius,
      Widget widget}) {
    return Container(
      height: height,
      width: width,
      child: widget,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
    );
  }

//===========================================chat container ==========================================//

  static chatDesign(
      {double height,
      double width,
      Color color,
      Widget widget,
      double topleft,
      double topright,
      double bottomleft,
      double bottomright}) {
    return Container(
      height: height,
      width: width,
      child: widget,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topleft),
            topRight: Radius.circular(topright),
            bottomRight: Radius.circular(bottomright),
            bottomLeft: Radius.circular(bottomleft),
          )),
    );
  }

  static profileCircleImage(url,
      {double height, double width, BoxFit boxFit = profileContain}) {
    return FadeInImage(
      placeholder: AssetImage(Assets.profile),
      image: NetworkImage(url ?? ""),
      fit: boxFit,
      height: height,
      width: width,
      imageErrorBuilder: (_, __, ___) {
        return Image.asset(
          Assets.profile,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );
      },
    );
  }

  static cachedImage(url,
      {double height,
      double width,
      BoxFit boxFit = profileContain,
      String hash = "LEHV6nWB2yk8pyoJadR*.7kCMdnj",
      bool isPost = false}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: boxFit,
      imageUrl: url ?? "",
      // placeholder: (context, url)=>Image.asset(Assets.profile,height: height,width: width,fit: BoxFit.cover,),
      placeholder: (context, url) => BlurHash(hash: hash),
      errorWidget: (context, url, error) => isPost
          ? Icon(
              Icons.error_rounded,
              color: Colors.grey,
            )
          : Image.asset(
              Assets.profile,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
    );
  }
}
