

/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import '../export.dart';

backAppBar(context, {String? title, onPress, }) => PreferredSize(
  preferredSize: Size.fromHeight(60),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        InkWell(
            child: SizedBox(
              height: 24,
              width: 24,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: imageAsset(
                  ICON_back,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
            onTap: () {
              Get.focusScope!.unfocus();
              onPress??Navigator.pop(context);
            }),
        hGap(16),
        text(title ?? "",
            fontSize: 24, color: COLOR_russianViolet, isBold: true),
      ],
    ),
  ),
);

