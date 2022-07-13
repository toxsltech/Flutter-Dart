

/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'package:get/get.dart';

import '../export.dart';

Text text(String label,
        {Color? color,
        double? fontSize,
        FontWeight? fontWeight,
        int? maxLines,
        TextOverflow? textOverflow = TextOverflow.ellipsis,
        TextAlign? textAlign,
        bool isBold = false}) =>
    Text(
      label,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? Theme.of(Get.context!).textTheme.bodyText1?.color,
        fontWeight: isBold
            ? FontWeight.w800
            : fontWeight ??
                Theme.of(Get.context!).textTheme.bodyText1?.fontWeight,
        fontSize:
            fontSize ?? Theme.of(Get.context!).textTheme.bodyText1?.fontSize,
      ),
    );
