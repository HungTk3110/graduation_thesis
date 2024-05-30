import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
