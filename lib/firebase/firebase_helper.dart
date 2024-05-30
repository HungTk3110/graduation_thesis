import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
}
