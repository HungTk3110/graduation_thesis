import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/enum/load_status.dart';
import 'package:untitled1/models/model/task.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  TextEditingController userNameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  SearchCubit() : super(const SearchState());

  void searchTaskByTitle({
    required String title,
  }) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
   List<TaskEntity> tasks =  await FireBaseHelper().searchTaskByTitle(
      uid: uid ?? '',
      title: title,
    );
   debugPrint('hungtk${tasks.length}');
    emit(state.copyWith(tasks: tasks));
  }
}
