import 'package:farmapp/controller/app_controller.dart';
import 'package:farmapp/resources/en_us.dart';
import 'package:farmapp/resources/hi_in.dart';
import 'package:farmapp/resources/ml_In.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  // Default locale
  AppController appState = Get.find();
  static final locale = Locale('en', 'US');
// getLocal() {
//     if (appState.language == 'en') {
//       locale = Locale('en', 'Eg');
//     }
//     if (appState.language == 'ar') {
//       locale = Locale('mal', 'AR');
//     }
//   }
  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('mal', 'MAL');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Malayalam',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('mal', 'MAL'),
    Locale('mal', 'MAL'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/en_us.dart
        'mal_IN': mlIN, // lang/mal_kl.dart
        'hi_IN': hiIN,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
