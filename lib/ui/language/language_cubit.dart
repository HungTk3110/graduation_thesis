import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  final Locale initLocale;
  LanguageCubit(this.initLocale): super(initLocale);

  void updateLanguageSelection(Locale locale){
    emit(locale);
  }
}