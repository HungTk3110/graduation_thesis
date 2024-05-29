part of 'app_config_bloc.dart';

abstract class AppConfigEvent {}

class UpdateFirstOpenEvent extends AppConfigEvent {
  final bool firstOpenApp;

  UpdateFirstOpenEvent({required this.firstOpenApp});
}

class UpdateFirstSetLanguageEvent extends AppConfigEvent {
  final bool firstSetupLanguage;

  UpdateFirstSetLanguageEvent({required this.firstSetupLanguage});
}

class UpdateLocaleEvent extends AppConfigEvent {
  final Locale locale;

  UpdateLocaleEvent({required this.locale});
}

class UpdateShowRateDialogEvent extends AppConfigEvent {
  final bool showRateDialog;

  UpdateShowRateDialogEvent({required this.showRateDialog});
}

class UpdateUserPremiumEvent extends AppConfigEvent {
  final bool userPremium;

  UpdateUserPremiumEvent({required this.userPremium});
}

class UpdateUiTrialTest extends AppConfigEvent {
  final int uiTrialTest;

  UpdateUiTrialTest({required this.uiTrialTest});
}
