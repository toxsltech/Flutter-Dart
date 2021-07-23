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

class TextFieldRect extends StatelessWidget {
  final String hint;
  final Function validate;
  final TextInputType inputType;
  final TextEditingController textController;
  final FocusNode focusNode;
  final String icon;
  final String suffixIcon;
  final double width;
  final double height;
  final double iconMargin;
  final double hintMargin;
  final Function onFieldSubmitted;
  final TextInputAction inputAction;
  final bool isObsecure;
  final int minLines;
  final int maxLength;

  const TextFieldRect({
    this.hint,
    this.inputType,
    this.iconMargin,
    this.textController,
    this.icon,
    this.width,
    this.height,
    this.validate,
    this.isObsecure = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputAction,
    this.suffixIcon,
    this.minLines,
    this.hintMargin = 10,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: iconMargin),
      child: Row(
        children: [
          icon == null
              ? Container()
              : Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(icon),
                    width: width,
                    height: height,
                  ),
                ),
          Expanded(
            child: TextFormField(
              maxLength: maxLength,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              minLines: minLines ?? 1,
              maxLines: minLines ?? 1,
              controller: textController,
              focusNode: focusNode,
              style: HelperUtility.textStyle(
                  color: Colors.black, fontsize: Dimens.font_14),
              keyboardType: inputType,
              textInputAction: inputAction,
              obscureText: isObsecure,
              validator: validate,
              onFieldSubmitted: onFieldSubmitted,
              decoration: new InputDecoration(
                hintText: hint,
                hintStyle: HelperUtility.textStyle(
                    color: Colors.grey, fontsize: Dimens.font_14),
                // contentPadding: const EdgeInsets.only(
                //     left: Dimens.radius_10, right: Dimens.margin_15,),

                // border: InputBorder.none,
                // enabledBorder: InputBorder.none
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0),
                    borderRadius: BorderRadius.circular(Dimens.height_8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0),
                    borderRadius: BorderRadius.circular(Dimens.height_8)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0),
                    borderRadius: BorderRadius.circular(Dimens.height_8)),
              ),
            ),
          ),
          suffixIcon != null
              ? Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 8.0),
                    child: Image(
                      image: AssetImage(suffixIcon),
                      width: width,
                      height: height,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
