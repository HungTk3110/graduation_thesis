part of 'app_config_bloc.dart';

class AppConfigState extends Equatable {
  final Locale locale;
  final bool firstOpenApp;
  final bool firstSetupLanguage;
  final bool showRateDialog;
  final bool userPremium;
  final int uiTrialTest;

  const AppConfigState(
      {required this.locale,
      required this.firstOpenApp,
      required this.firstSetupLanguage,
      required this.showRateDialog,
      required this.userPremium,
      required this.uiTrialTest});

  AppConfigState copyWith({
    Locale? locale,
    bool? firstOpenApp,
    bool? firstSetupLanguage,
    bool? showRateDialog,
    bool? userPremium,
    int? uiTrialTest,
  }) {
    return AppConfigState(
      locale: locale ?? this.locale,
      firstOpenApp: firstOpenApp ?? this.firstOpenApp,
      firstSetupLanguage: firstSetupLanguage ?? this.firstSetupLanguage,
      showRateDialog: showRateDialog ?? this.showRateDialog,
      userPremium: userPremium ?? this.userPremium,
      uiTrialTest: uiTrialTest ?? this.uiTrialTest,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstOpenApp': firstOpenApp,
      'firstSetupLanguage': firstSetupLanguage,
      'locale': locale.languageCode,
      'showRateDialog': showRateDialog,
      'userPremium': userPremium,
      'uiTrialTest': uiTrialTest,
    };
  }

  factory AppConfigState.fromJson(json) {
    return AppConfigState(
      locale: Locale(json['locale']),
      firstOpenApp: json['firstOpenApp'],
      firstSetupLanguage: json['firstSetupLanguage'],
      showRateDialog: json['showRateDialog'],
      userPremium: json['userPremium'],
      uiTrialTest: json["uiTrialTest"],
    );
  }

  @override
  List<Object?> get props => [
        locale.languageCode,
        firstOpenApp,
        firstSetupLanguage,
        showRateDialog,
        userPremium,
        uiTrialTest
      ];
}
