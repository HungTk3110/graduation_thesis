import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/enum/authentication_type.dart';
import 'package:untitled1/models/model/user_local.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(const HomeState());

  void initData(BuildContext context) async {

    UserLocal userLocal = await FireBaseHelper().getCurrentUser() ?? UserLocal(userName: '');
    emit(state.copyWith(userLocal: userLocal));
    debugPrint('hungtl${userLocal.userName}');
  }
}
