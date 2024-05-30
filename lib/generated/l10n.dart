// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Username or E-mail`
  String get usernameOrEmail {
    return Intl.message(
      'Username or E-mail',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty`
  String get text_field_can_empty {
    return Intl.message(
      'This field cannot be empty',
      name: 'text_field_can_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please input email valid`
  String get text_input_email_valid {
    return Intl.message(
      'Please input email valid',
      name: 'text_input_email_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please input phone number valid`
  String get text_input_phone_number_valid {
    return Intl.message(
      'Please input phone number valid',
      name: 'text_input_phone_number_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please input url valid`
  String get text_input_url_valid {
    return Intl.message(
      'Please input url valid',
      name: 'text_input_url_valid',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be less than 8 characters`
  String get valitae_pasword {
    return Intl.message(
      'Password cannot be less than 8 characters',
      name: 'valitae_pasword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
