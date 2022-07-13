

/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import 'package:flutter_code_base/pages/authentication/presentation/controllers/loginController.dart';

import '../../../../export.dart';

class LoginScreen extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: Get.height,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    vGap(DIMENS_50),
                    imageAsset(ICON_smallLogo, height: DIMENS_100),
                    vGap(DIMENS_50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                            STRING_loginHeader.tr,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                          vGap(16),
                          Form(
                              key: formGlobalKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  customTextFormField(
                                      controller: controller.emailController,
                                      prefixIcon: Icon(Icons.mail),
                                      label: STRING_email.tr,
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return STRING_enterEmailValidation;
                                        else if (value.length > 0 &&
                                            !GetUtils.isEmail(value))
                                          return STRING_enterValidEmail;
                                        else
                                          return null;
                                      },
                                      focusNode: controller.emailFocusNode),
                                  vGap(16),
                                  customTextFormField(
                                      controller: controller.passwordController,
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                          onPressed: (){
                                            controller.togglePasswordVisibility();
                                          },
                                          icon: Icon(controller.hidePswd.value
                                              ?Icons.visibility:Icons.visibility_off)),
                                      label: STRING_password.tr,
                                      obscureText: controller.hidePswd.value,
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return STRING_enterPassword;
                                        else
                                          return null;
                                      },
                                      focusNode: controller.passwordFocusNode),
                                ],
                              )),
                          vGap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              cbtnTextButton(
                                  onPressed: () {
                                    controller.onForget();
                                  },
                                  label: STRING_forgotPswd.tr,
                                  textColor: COLOR_russianViolet,
                                  backgroundColor: Colors.transparent),
                            ],
                          ),
                          vGap(16),
                          cbtnElevatedButton(
                            onPressed: () {
                              if (formGlobalKey.currentState!.validate()) {

                              }
                            },
                            label: STRING_login.tr,
                            height: DIMENS_40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(DIMENS_8)
                            )
                          ),
                          vGap(64),
                          GestureDetector(
                            onTap: () {
                              controller.gotoSingup();
                            },
                            child: Text.rich(
                              TextSpan(
                                  text:
                                  STRING_dontHaveAcc
                                          .tr,
                                  children: [
                                    TextSpan(
                                        text: STRING_signUp,
                                        style: TextStyle(
                                            color: COLOR_violetM.shade50,
                                            fontWeight: FontWeight.w800,
                                            fontSize: FONT_16),
                                        children: [
                                          TextSpan(
                                            text: STRING_website.tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: FONT_16),
                                          )
                                        ])
                                  ]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: FONT_16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
