

/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import '../../../../export.dart';

class OnboardingController extends GetxController {
  var introKey = GlobalKey<IntroductionScreenState>();

  var page = pages;
  int currentIndex = 0;

  onSkip() {
    storage.write(LOCALKEY_onboarding, true);
    Get.off(() => LoginScreen());
  }

  onSlide(index) {
    currentIndex = index;
    update();
  }
}
