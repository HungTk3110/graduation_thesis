import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/service/notification_service.dart';
import 'package:untitled1/ui/home/home_cubit.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  TaskCubit() : super(const TaskState());

  void onPressStartTime(BuildContext context) async {
    TaskEntity taskEntity = state.taskEntity ?? TaskEntity();
    DateTime? startTime = await showPickerDate(context);
    taskEntity.dateStart = formatDateTime(startTime ?? DateTime.now());
    startTimeController.text = formatDateTime(startTime ?? DateTime.now());
    emit(state.copyWith(taskEntity: taskEntity));
  }

  void onPressEndTime(BuildContext context) async {
    TaskEntity taskEntity = state.taskEntity ?? TaskEntity();
    DateTime? endTime = await showPickerDate(context);
    taskEntity.dateEnd = formatDateTime(endTime ?? DateTime.now());
    endTimeController.text = formatDateTime(endTime ?? DateTime.now());
    emit(state.copyWith(taskEntity: taskEntity));
  }

  void onPressCreateTask({
    required TextEditingController title,
    required TextEditingController note,
    required TextEditingController category,
    required BuildContext context,
  }) async {
    try {
      TaskEntity taskEntity = state.taskEntity ?? TaskEntity();
      taskEntity.doneTask = false;
      taskEntity.title = title.text;
      taskEntity.note = note.text;
      taskEntity.category = category.text;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      List<String> documents = [];
      List<File> list = state.listFile;
      for(int i =0 ; i<list.length ; i++){
        String fileUrl = await FireBaseHelper().getImageUrlByLocal(
          userUid: uid ?? '',
          file: File(list[i].path ?? ''),
        );
        documents.add(fileUrl);
      }
      taskEntity.documents = documents;
      await FireBaseHelper().addTask(
        uid: uid ?? '',
        task: taskEntity,
      );
      await context.read<HomeCubit>().getAllTask();
      LocalNotificationService().scheduleNotification();
      AppNavigator.push(Routes.home);
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('Create Task Success'),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('An Erorr'),
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(dateTime);
  }

  Future<DateTime?> showPickerDate(BuildContext context) async {
    return await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
  }

  void deleteTask({
    required String taskID,
    required BuildContext context,
  }) async {
    try {
      final User? user = auth.currentUser;
      final uid = user?.uid;
      await FireBaseHelper().deleteTask(
        uid: uid ?? '',
        idTask: taskID,
      );
      AppNavigator.pop();
      await context.read<HomeCubit>().getAllTask();
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('Delete Task Success'),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {}
  }

  void changeDoneTask(bool done) {
    emit(state.copyWith(doneTask: done));
  }

  void updateTask({
    required dynamic taskId,
    required TextEditingController title,
    required TextEditingController note,
    required TextEditingController category,
    required BuildContext context,
    required List<dynamic> document,
  }) async {
    try {
      TaskEntity taskEntity = state.taskEntity ?? TaskEntity();
      taskEntity.doneTask = false;
      taskEntity.title = title.text;
      taskEntity.note = note.text;
      taskEntity.category = category.text;
      taskEntity.dateStart = startTimeController.text;
      taskEntity.dateEnd = endTimeController.text;
      taskEntity.doneTask = state.doneTask;
      taskEntity.id = taskId;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      List<dynamic> documents = document;
      List<File> list = state.listFile;
      for(int i =0 ; i<list.length ; i++){
        String fileUrl = await FireBaseHelper().getImageUrlByLocal(
          userUid: uid ?? '',
          file: File(list[i].path ?? ''),
        );
        documents.add(fileUrl);
      }
      taskEntity.documents = documents;
      await FireBaseHelper().updateTask(
        uid: uid ?? '',
        task: taskEntity.toDbMap(),
        idTask: taskEntity.id,
      );
      await context.read<HomeCubit>().getAllTask();
      AppNavigator.pop();
      toastification.show(
        context: context,
        // optional if you use ToastificationWrapper
        title: const Text('Update Task Success'),
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {
    }
  }

  void addFile(File file){
    List<File> listFile = state.listFile;
    List<File> listFileNew = [...listFile,file];
    emit(state.copyWith(listFile:listFileNew ));
    debugPrint('hungtk${listFile.length}');
  }
}
