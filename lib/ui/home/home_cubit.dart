import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/models/model/user_local.dart';
import 'package:untitled1/navigator/routes.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  HomeCubit() : super(const HomeState());

  Future<void> initData(BuildContext context) async {
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
    getAllTask();
    debugPrint('hungtl${categories.length}');
  }

  void onPressAddCategory(
    Categories categories,
    BuildContext context,
  ) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    await FireBaseHelper().addCategories(
      uid: uid ?? '',
      categories: categories,
    );
    List<Categories> categoriesNew =
        await FireBaseHelper().getAllCategories(uid: uid ?? '');
    emit(state.copyWith(categories: categoriesNew));
    AppNavigator.pop();
    toastification.show(
      context: context,
      // optional if you use ToastificationWrapper
      title: const Text('Create Category Success'),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  Future<void> getAllTask() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    List<TaskEntity> tasks = await FireBaseHelper().getAllTasks(uid: uid ?? '');
    List<Categories> categories = state.categories;
    List<List<TaskEntity>> taskByCategory = [];
    List<TaskEntity> tasksComplete = [];
    List<TaskEntity> tasksProgress = [];
    for (TaskEntity task in tasks) {
      if (task.doneTask == true) {
        tasksComplete.add(task);
      } else {
        tasksProgress.add(task);
      }
    }
    emit(state.copyWith(
      tasksProgress: tasksProgress,
      tasksComplete: tasksComplete,
    ));
    for (int i = 0; i < categories.length; i++) {
      List<TaskEntity> tasksFilter =
          tasks.where((task) => task.category == categories[i].title).toList();
      taskByCategory.add(tasksFilter);
    }
    emit(state.copyWith(taskByCategory: taskByCategory));
  }

  Future<void> getAllCategory(BuildContext context) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    List<Categories> categories =
        await FireBaseHelper().getAllCategories(uid: uid ?? '');
    emit(state.copyWith(
      categories: categories,
    ));
  }
}
