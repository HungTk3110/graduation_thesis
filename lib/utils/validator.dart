import 'package:flutter/cupertino.dart';
import 'package:untitled1/generated/l10n.dart';

class Common {
  static bool isStringEmpty(String? value) {
    return value == null ? true : value.trim().isEmpty;
  }
}

class Validator {

  static validEmpty(String? value, BuildContext context){
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }
  }

  static String? validEmail(String? value, BuildContext context) {
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }

    final bool isValidEmail =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value ?? "");

    if (!isValidEmail) {
      return S.of(context).text_input_email_valid;
    }

    return null;
  }

  static String? validPhoneNumber(String? value, BuildContext context) {
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }

    final bool isValidPhone =
    RegExp(r'^\+[0-9]{1,4}[0-9]{10}$')
        .hasMatch(value ?? "");

    if (!isValidPhone) {
      return S.of(context).text_input_phone_number_valid;
    }

    return null;
  }

  static String? validUrl(String? value, BuildContext context) {
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }

    final bool isValidUrl =
    RegExp(r'^(https?|ftp):\/\/[^\s\/$.?#].[^\s]*$')
        .hasMatch(value ?? "");

    if (!isValidUrl) {
      return S.of(context).text_input_url_valid;
    }

    return null;
  }

  static String? validPassWord(String value, BuildContext context) {
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }

    if (value.length < 6) {
      return S.of(context).valitae_pasword;
    }

    return null;
  }

  static String? validConfirmPassWord(String value,String yourPassword , BuildContext context) {
    if (Common.isStringEmpty(value)) {
      return S.of(context).text_field_can_empty;
    }

    if (value != yourPassword) {
      return 'Please check your password confirmation.';
    }

    return null;
  }
}
