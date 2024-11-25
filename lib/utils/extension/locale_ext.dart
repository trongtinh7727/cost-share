import 'package:flutter/material.dart';

extension LocaleName on Locale {
  String get nameByLocale {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      default:
        return 'Unknown';
    }
  }

  String get flagAsset {
    switch (languageCode) {
      case 'en':
        return '';
      case 'vi':
        return '';
      default:
        return '';
    }
  }

  String get countryName {
    switch (countryCode) {
      case 'UK':
        return 'United Kingdom';
      case 'VN':
        return 'Việt Nam';
      default:
        return 'Unknown';
    }
  }
}
