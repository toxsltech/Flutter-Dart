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

/*==================================================== Email Validator =====================================================*/

class EmailFormValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return Strings.emailEmpty;
    } else if (!validateEmail(value.trim())) {
      return Strings.vaildEmail;
    }
    return null;
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}

/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return Strings.passwordEmpty;
    } else if (value.length < 6) {
      return Strings.vaildPassword;
    }
    return null;
  }
}

class FieldChecker {
  static String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,15}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length < 5) {
      return 'Please enter valid mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
