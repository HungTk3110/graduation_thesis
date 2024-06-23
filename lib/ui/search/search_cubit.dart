import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/user_local.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/ui/home/home_cubit.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  TextEditingController userNameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  SearchCubit() : super(const SearchState());

  void initData(BuildContext context) async {
    UserLocal userLocal =
        await FireBaseHelper().getCurrentUser() ?? UserLocal(userName: '');
    emit(state.copyWith(userLocal: userLocal));
    userNameController.text = userLocal.userName ?? '';
    debugPrint('hungtl${userLocal.userName}');
  }

  void onChangeAvatar(File file) {
    emit(state.copyWith(fileAvatar: file));
    debugPrint('hungtl${state.fileAvatar}');
  }

  Future<void> onPressUpdate(BuildContext context) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    DialogBuilder(context).showDialogLoading(dialog);
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String avatarUrl = state.userLocal?.avatar ?? '';

    if (state.fileAvatar?.path != null) {
      avatarUrl = await FireBaseHelper().getImageUrlByLocal(
        userUid: uid ?? '',
        file: File(state.fileAvatar?.path ?? ''),
      );
    } else {
      avatarUrl = avatarUrl;
    }

    UserLocal userLocal = UserLocal(
        userName: userNameController.text,
        avatar: avatarUrl,
        email: state.userLocal?.email ?? '');

    await FireBaseHelper()
        .updateProfile(uid: uid ?? '', user: userLocal.toDbMap());
    DialogBuilder(context).hideDialogLoading(dialog);
    AppNavigator.push(Routes.home);
  }

  void deleteCategory({
    required String idCategory,
    required BuildContext context,
  }) async {
    try {
      final User? user = auth.currentUser;
      final uid = user?.uid;
      await FireBaseHelper().deleteCategory(
        uid: uid ?? '',
        idCategory: idCategory,
      );
      AppNavigator.pop();
      await context.read<HomeCubit>().getAllCategory(context);
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('Delete Category Success'),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {}
  }

  void updateCategory({
    required dynamic id,
    required String categoryName,
    required Color color,
    required String createAt,
    required BuildContext context,
  }) async {
    try {
      Categories categories = Categories(
        id: id,
        title: categoryName,
        color: color.value,
        createAt: createAt,
      );
      final User? user = auth.currentUser;
      final uid = user?.uid;
      await FireBaseHelper().updateCategory(
        uid: uid ?? '',
        category: categories.toDbMap(),
        idTask: categories.id,
      );
      await context.read<HomeCubit>().getAllCategory(context);
      AppNavigator.pop();
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('Update Category Success'),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {}
  }
}
