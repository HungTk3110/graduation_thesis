import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LanguageCubit() : super(const LanguageState());

  void onChangeLocal(Locale local) {
    emit(state.copyWith(currentLocal: local));
  }
}
