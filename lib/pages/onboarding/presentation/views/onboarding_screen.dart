


/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import '../../../../export.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        builder: (controller) => IntroductionScreen(
          key: controller.introKey,
          onDone: () {
            controller.onSkip();
          },
          onChange: (index) {
            controller.onSlide(index);
            log.i(index);
          },
          showDoneButton: false,
          showNextButton: false,
          showSkipButton: false,
          dotsFlex: 0,
          globalHeader: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 27,
                    width: 70,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.onSkip();
                      },
                      child: Text(
                        STRING_skip.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(COLOR_pinkM)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          globalBackgroundColor: Colors.white,
          dotsDecorator: DotsDecorator(
              color: Colors.transparent,
              activeColor: Colors.transparent,
              activeShape: StadiumBorder(),
              activeSize: Size(25, 10)),
          rawPages: controller.page,
        ),
      ),
    );
  }
}
