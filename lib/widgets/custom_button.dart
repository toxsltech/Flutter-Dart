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

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String buttonIcon;
  final Color textColor;
  final Function onPressed;
  final double fontsize;
  final Color buttonColor;
  final bool isIcon;
  final double height;
  final double width;
  final bool isbold;

  const CustomButton(
      {this.buttonText,
      this.textColor = Colors.white,
      this.onPressed,
      this.fontsize,
      this.buttonIcon,
      this.height,
      this.isbold,
      this.width,
      this.buttonColor,
      this.isIcon});

  @override
  Widget build(BuildContext context) {
    return HelperWidget.getInkwell(
        onTap: onPressed,
        widget: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.height_30),
          child: Container(
            height: height,
            width: width,
            child: ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      buttonColor ?? primaryColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isIcon == true
                        ? Row(
                            children: [
                              Image.asset(
                                buttonIcon,
                                width: Dimens.height_25,
                                height: Dimens.height_25,
                              ),
                              HelperWidget.sizeBox(width: Dimens.width_10),
                            ],
                          )
                        : Container(),
                    Text(
                      buttonText,
                      style: isbold == true
                          ? HelperUtility.textStyleBold(
                              color: textColor, fontsize: fontsize)
                          : HelperUtility.textStyle(
                              color: textColor, fontsize: fontsize),
                    )
                  ],
                )),
          ),
        ));
  }
}
