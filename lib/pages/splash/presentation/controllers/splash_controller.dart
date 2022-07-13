/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'dart:async';

import 'package:flutter_code_base/export.dart';
import 'package:flutter_code_base/pages/onboarding/presentation/views/onboarding_screen.dart';
import 'package:flutter_code_base/service/local_service/local_keys.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    update();
    _navigateToNextScreen();
    super.onInit();
  }

  _navigateToNextScreen() => Timer(Duration(milliseconds: 3500), () async {
        if (storage.read(LOCALKEY_onboarding) ?? false) {
          if (storage.read(LOCALKEY_token) != null) {
            Get.offAll(() => OnboardingScreen());
          }
          else
            Get.offAll(() => LoginScreen());
        }else
          Get.offAll(() => OnboardingScreen());
      });
}
