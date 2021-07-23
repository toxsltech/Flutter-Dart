/*
 *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:

// Project imports:
import 'package:alanis/export.dart';
import 'package:flash/flash.dart';

class HelperWidget {
  /*================================================= Toasƒt Message ====================================================*/

  static toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: toastColor,
        fontSize: Dimens.font_16);
  }

  static flashBar({String message, BuildContext context, Color color}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          margin: EdgeInsets.only(top: Dimens.radius_3),
          controller: controller,
          backgroundColor: color,
          brightness: Brightness.light,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          child: FlashBar(
            content: null,
            padding: EdgeInsets.only(
                top: Dimens.margin_3,
                bottom: Dimens.margin_0,
                left: Dimens.margin_0,
                right: Dimens.margin_0),
            title: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: HelperUtility.textStyle(
                    fontsize: Dimens.font_14, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  /*========================================================= container ========================================================*/

  static container({double height, double width, decoration, widget}) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: widget,
    );
  }

  /*============================================== decoration box for container ==============================================*/

  static decorationBox({outlineColor, roundCorner}) {
    return BoxDecoration(
      color: outlineColor,
      border: Border.all(color: outlineColor),
      borderRadius: BorderRadius.all(Radius.circular(roundCorner) //
          ),
    );
  }

  static decorationBoxx(
      {backgroundColor, cornerRaduis, borderColor, borderWidth}) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor, width: borderWidth),
      borderRadius: BorderRadius.all(Radius.circular(cornerRaduis)
          //
          ),
    );
  }

  /*============================================== decoration box for container ==============================================*/

  static decorationBoxColor({outlineColor, roundCorner, fillColor}) {
    return BoxDecoration(
        border: Border.all(color: outlineColor),
        borderRadius: BorderRadius.all(
          Radius.circular(roundCorner), //
        ),
        color: fillColor);
  }

  /*================================================== Inkwell Click =========================================================*/

  static getInkwell({Function onTap, Widget widget}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: widget,
    );
  }

  /* =====================================================Image Icon Set from Assets ===========================================*/

  static imageSet({icon, height, width}) {
    return Image(
      image: AssetImage(icon),
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }

  static setFileImage(
      {String url, double height, double width, double raduis}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis ?? 100),
      child: Image.file(new File(url),
          height: height, width: width, fit: BoxFit.contain),
    );
  }

  static circleImageNetWork({imageurl, height, width, radius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
          fit: BoxFit.contain,
          width: width,
          height: height,
          placeholder: Assets.profile,
          image: imageurl != null ? imageurl : ""),
    );
  }

  static sizeBox({double height, double width}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  static appBar(
      {@required String title,
      Widget leading,
      bool noBack = false,
      @required BuildContext context,
      List<Widget> actions}) {
    return AppBar(
      title: Text(
        title,
        style: HelperUtility.textStyleBold(color: Colors.white, fontsize: 16),
      ),
      centerTitle: true,
      elevation: 1,
      leading: leading == null
          ? noBack
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
          : Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: leading,
            ),
      actions: actions == null ? [Container()] : actions,
    );
  }
}
