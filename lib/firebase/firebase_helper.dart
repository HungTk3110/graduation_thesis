import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/models/model/user_local.dart';

class FireBaseHelper {
  static final db = FirebaseFirestore.instance;

  Future<UserLocal?> getCurrentUser() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    debugPrint('hungtluser${user?.uid}');
    var data = await db.collection('users').doc(user?.uid).get().then((doc) {
      if (doc.exists) {
        return UserLocal.fromDbMap(doc.data());
      } else {
        debugPrint('exists${user?.uid}');
      }
    });
    return data;
  }

  Future<void> createProfileUser({
    required UserLocal user,
    required String uid,
  }) async {
    try {
      await db.collection('users').doc(uid).set(user.toDbMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateProfile({
    required String uid,
    required Map<String, dynamic> user,
  }) async {
    try {
      await db.collection('users').doc(uid).update(user);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> getImageUrlByLocal({
    required String userUid,
    required File file,
  }) async {
    // final size = getFileSize(file);
    final name = file.path.split('/').last;
    print('size: , name: $name, path: ${file.path}');

    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child(userUid).child('images/$name');
    final snap = await imagesRef.putFile(file);
    final urlFile = await snap.ref.getDownloadURL();
    return urlFile;
  }

  Future<List<Categories>> getAllCategories({required String uid}) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('database')
          .doc(uid)
          .collection('categories')
          .get();

      List<Categories> listCategories = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Categories.fromDbMap(data);
      }).toList();

      return listCategories;
    } catch (e) {
      print("Error getting categories: $e");
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  Future<void> addCategories({
    required Categories categories,
    required String uid,
  }) async {
    try {
      final docRef =
          db.collection('database').doc(uid).collection('categories').doc();
      categories.id = docRef.id;
      categories.createAt = DateTime.now().toIso8601String();
      await docRef.set(categories.toDbMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteCategory({
    required String uid,
    required String idCategory,
  }) async {
    try {
      await db
          .collection('database')
          .doc(uid)
          .collection('categories')
          .doc(idCategory)
          .delete();
      debugPrint("hungtk}");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateCategory({
    required String uid,
    required String idTask,
    required Map<String, dynamic> category,
  }) async {
    try {
      await db
          .collection('database')
          .doc(uid)
          .collection('categories')
          .doc(idTask)
          .update(category);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> addTask({
    required TaskEntity task,
    required String uid,
  }) async {
    try {
      final docRef =
          db.collection('database').doc(uid).collection('tasks').doc();
      task.id = docRef.id;
      await docRef.set(task.toDbMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<TaskEntity>> getAllTasks({required String uid}) async {
    try {
      QuerySnapshot querySnapshot =
          await db.collection('database').doc(uid).collection('tasks').get();

      List<TaskEntity> listTaskEntity = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TaskEntity.fromDbMap(data);
      }).toList();

      return listTaskEntity;
    } catch (e) {
      print("Error getting categories: $e");
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  Future<void> deleteTask({
    required String uid,
    required String idTask,
  }) async {
    try {
      await db
          .collection('database')
          .doc(uid)
          .collection('tasks')
          .doc(idTask)
          .delete();
      debugPrint("hungtk}");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateTask({
    required String uid,
    required String idTask,
    required Map<String, dynamic> task,
  }) async {
    try {
      await db
          .collection('database')
          .doc(uid)
          .collection('tasks')
          .doc(idTask)
          .update(task);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<TaskEntity>> searchTaskByTitle({
    required String title,
    required String uid,
  }) async {
    List<TaskEntity> listTask = [];
    try {
      await db
          .collection('database')
          .doc(uid)
          .collection('tasks')
          .where('title', isGreaterThanOrEqualTo: title)
          .where('title', isLessThan: '${title}z')
          .get()
          .then(
        (QuerySnapshot querySnapshot) {
          for (int i = 0; i < querySnapshot.docs.length; i++) {
            listTask.add(
              TaskEntity.fromDbMap(
                querySnapshot.docs[i].data(),
              ),
            );
          }
        },
      );
      // for (int i = 0; i < data.length; i++) {
      //   final note = NoteEntity.fromDbMap(data[i]);
      //   listNote.add(note);
      // }
      return listTask;
    } catch (e) {
      return [];
    }
  }
}
