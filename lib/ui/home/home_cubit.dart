import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/user_local.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  HomeCubit() : super(const HomeState());

  void initData(BuildContext context) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    UserLocal userLocal =
        await FireBaseHelper().getCurrentUser() ?? UserLocal(userName: '');
    List<Categories> categories =
        await FireBaseHelper().getAllCategories(uid: uid ?? '');
    emit(state.copyWith(
      userLocal: userLocal,
      categories: categories,
    ));
    debugPrint('hungtl${userLocal.userName}');
  }
}
