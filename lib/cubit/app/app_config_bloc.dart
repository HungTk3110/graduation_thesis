import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_config_event.dart';

part 'app_config_state.dart';

class AppConfigBloc extends HydratedBloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc()
      : super(const AppConfigState(
            locale: Locale('en'),
            firstOpenApp: true,
            firstSetupLanguage: true,
            showRateDialog: true,
            userPremium: false,
            uiTrialTest: 0)) {
    hydrate();
    on<UpdateFirstOpenEvent>(_onUpdateFirstOpen);
    on<UpdateFirstSetLanguageEvent>(_onUpdateFirstSetLanguage);
    on<UpdateLocaleEvent>(_onUpdateLocale);
    on<UpdateShowRateDialogEvent>(_onUpdateShowRateDialog);
    on<UpdateUserPremiumEvent>(_onUpdateUserPremium);
    on<UpdateUiTrialTest>(_onUpdateUiTrialTest);
  }

  void _onUpdateFirstOpen(
      UpdateFirstOpenEvent event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(firstOpenApp: event.firstOpenApp));
  }

  void _onUpdateFirstSetLanguage(
      UpdateFirstSetLanguageEvent event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(firstSetupLanguage: event.firstSetupLanguage));
  }

  void _onUpdateLocale(UpdateLocaleEvent event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(locale: event.locale));
  }

  void _onUpdateShowRateDialog(
      UpdateShowRateDialogEvent event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(showRateDialog: event.showRateDialog));
  }

  void _onUpdateUserPremium(
      UpdateUserPremiumEvent event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(userPremium: event.userPremium));
  }

  void _onUpdateUiTrialTest(
      UpdateUiTrialTest event, Emitter<AppConfigState> emit) {
    emit(state.copyWith(uiTrialTest: event.uiTrialTest));
  }

  @override
  Map<String, dynamic>? toJson(AppConfigState state) => state.toJson();

  @override
  AppConfigState? fromJson(Map<String, dynamic> json) =>
      AppConfigState.fromJson(json);
}
