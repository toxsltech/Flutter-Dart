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

class TextFieldDropdown extends StatelessWidget {
  final String hint;
  final Function validate;
  final FocusNode focusNode;
  final String icon;
  final String suffixIcon;
  final double width;
  final double height;
  final double iconMargin;
  final items;
  final Function onChanged;
  final value;

  const TextFieldDropdown({
    this.hint,
    this.iconMargin = 10,
    this.icon,
    this.width,
    this.height,
    this.validate,
    this.focusNode,
    this.suffixIcon,
    this.items,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          hint: Text(
            hint,
            style: HelperUtility.textStyle(color: Colors.grey),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 30,
          ),
          focusNode: focusNode,
          style: HelperUtility.textStyle(
              color: Colors.black, fontsize: Dimens.font_14),
          validator: validate,
          decoration: new InputDecoration(
            hintText: hint,
            hintStyle: HelperUtility.textStyle(
                color: Colors.grey, fontsize: Dimens.font_14),
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
                ? Container(
                    padding: EdgeInsets.all(15.0),
                    height: 15.0,
                    width: 15.0,
                    child: Image(
                      image: AssetImage(suffixIcon),
                      height: 5.0,
                      width: 5.0,
                    ))
                : null,
            contentPadding: EdgeInsets.all(15),
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
          items: items,
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}
