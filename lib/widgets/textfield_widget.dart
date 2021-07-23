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

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final Function validate;
  final Function onTapSufix;
  final TextInputType inputType;
  final TextEditingController textController;
  final FocusNode focusNode;
  final String icon;
  final String suffixIcon;
  final Function onFieldSubmitted;
  final TextInputAction inputAction;
  final bool isObsecure;
  final int maxline;
  final bool readonly;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;
  final Function onTap;

  const TextFieldWidget({
    this.hint,
    this.inputType,
    this.onTapSufix,
    this.textController,
    this.icon,
    this.validate,
    this.isObsecure = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputAction,
    this.suffixIcon,
    this.maxline = 1,
    this.readonly = false,
    this.inputFormatters,
    this.maxLength,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readonly,
        controller: textController,
        focusNode: focusNode,
        style: HelperUtility.textStyle(
            color: Colors.black, fontsize: Dimens.font_14),
        keyboardType: inputType,
        textInputAction: inputAction,
        obscureText: isObsecure,
        validator: validate,
        maxLines: maxline,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
        decoration: new InputDecoration(
          counterText: "",
          prefixIcon: icon != null
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  height: 15.0,
                  width: 15.0,
                  child: Image(
                    image: AssetImage(icon),
                    height: 5.0,
                    width: 5.0,
                  ))
              : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onTapSufix,
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      height: 15.0,
                      width: 15.0,
                      child: Image(
                        image: AssetImage(suffixIcon),
                        height: 5.0,
                        width: 5.0,
                      )),
                )
              : null,
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
          hintStyle:
              HelperUtility.textStyle(color: Colors.grey, fontsize: 14.0),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),
              borderRadius: BorderRadius.circular(Dimens.height_30)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),
              borderRadius: BorderRadius.circular(Dimens.height_30)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),
              borderRadius: BorderRadius.circular(Dimens.height_30)),
        ),
      ),
    );
  }
}
