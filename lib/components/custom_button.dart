
/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'package:flutter/material.dart';
import 'package:flutter_code_base/constants/dimens.dart';

Widget cbtnTextButton(
        {required void Function() onPressed,
        required String label,
        OutlinedBorder? shape,
        Color? backgroundColor,
        Color? foregroundColor,
        Color? shadowColor,
        double? height,
        EdgeInsetsGeometry? padding,
        Color textColor = Colors.black,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: TextButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  ),
            ),
          ),
          style: TextButton.styleFrom(
              shape: shape,
              backgroundColor: backgroundColor,
              padding: padding,
              onSurface: foregroundColor,
              shadowColor: shadowColor,
              textStyle: textStyle),
        ),
      ),
    );

Widget cbtnElevatedButton(
        {required void Function() onPressed,
        required String label,
        Color textColor = Colors.white,
        OutlinedBorder? shape,
        Color? backgroundColor,
        double? height ,
        Color? foregroundColor,
        Color? shadowColor,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: shape,
            primary: backgroundColor,
            onSurface: foregroundColor,
            shadowColor: shadowColor,
            textStyle: textStyle,
          ),
        ),
      ),
    );


