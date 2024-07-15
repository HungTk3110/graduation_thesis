import 'package:flutter/material.dart';

extension LocaleExtension on Locale {
  String get getLocaleName {
    switch (languageCode) {
      case 'vi':
        return 'Tiếng Việt';
      case 'en':
        return 'English';

      default:
        return 'English';
    }
  }

  String get logo {
    switch (languageCode) {
      case 'vi':
        return 'assets/image/ic_vi.png';
      case 'en':
        return 'assets/image/ic_en.png';

      default:
        return '';
    }
  }
}
