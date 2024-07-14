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

  /// `Search Your Task`
  String get searchYourTask {
    return Intl.message(
      'Search Your Task',
      name: 'searchYourTask',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Complete your task today`
  String get completeYourTaskToday {
    return Intl.message(
      'Complete your task today',
      name: 'completeYourTaskToday',
      desc: '',
      args: [],
    );
  }

  /// `My Category`
  String get myCategory {
    return Intl.message(
      'My Category',
      name: 'myCategory',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Delete tasks`
  String get deleteTasks {
    return Intl.message(
      'Delete tasks',
      name: 'deleteTasks',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this task?`
  String get doYouWantToDeleteThisTask {
    return Intl.message(
      'Do you want to delete this task?',
      name: 'doYouWantToDeleteThisTask',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Type your Title`
  String get typeYourTitle {
    return Intl.message(
      'Type your Title',
      name: 'typeYourTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complete task:`
  String get completeTask {
    return Intl.message(
      'Complete task:',
      name: 'completeTask',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Enter your start time`
  String get enterYourStartTime {
    return Intl.message(
      'Enter your start time',
      name: 'enterYourStartTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Enter your end time`
  String get enterYourEndTime {
    return Intl.message(
      'Enter your end time',
      name: 'enterYourEndTime',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Update task`
  String get updateTask {
    return Intl.message(
      'Update task',
      name: 'updateTask',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTask {
    return Intl.message(
      'Create Task',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
