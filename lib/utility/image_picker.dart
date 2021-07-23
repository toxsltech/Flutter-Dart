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

class ImagePick {
  /*=================================================================== Image Pick Using camera ===================================================*/

  static imgFromCamera() async {
    return await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
  }

  /*=================================================================== Image Pick Using Gallery ===================================================*/

  static imgFromGallery() async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
  }
}
