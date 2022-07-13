

/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import '../export.dart';

Widget customTextFormField(
    {required TextEditingController controller,
      required FocusNode focusNode,
      String? hintText,
      String? label,
      int maxLines = 1,
      bool obscureText = false,
      String? validator(String? value)?,
      TextInputAction textInputAction = TextInputAction.next,
      TextInputType textInputType = TextInputType.text,
      Widget? prefix,
      Widget? prefixIcon,
      Widget? suffix,
      Widget? suffixIcon,
    }) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        if (label != null) vGap(4),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines,
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
              color: Colors.grey),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight),
            helperStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            prefixStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            fillColor: COLOR_white,
            prefix: prefix,
            prefixIcon: prefixIcon,
            suffix: suffix,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );




