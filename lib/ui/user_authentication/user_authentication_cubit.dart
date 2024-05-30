import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:untitled1/firebase/firebase_helper.dart';
import 'package:untitled1/models/enum/authentication_type.dart';
import 'package:untitled1/models/model/user_local.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/utils/app_utils.dart';
import 'package:untitled1/utils/validator.dart';

part 'user_authentication_state.dart';

class UserAuthenticationCubit extends Cubit<UserAuthenticationState> {
  TextEditingController emailController =
      TextEditingController(text: 'hung@gmail.com');
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passWordController =
      TextEditingController(text: '12345678');
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordSignUpController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  UserAuthenticationCubit() : super(const UserAuthenticationState());

  void onChangeType({
    required AuthenticationType type,
  }) {
    emit(state.copyWith(authenticationType: type));
  }

  void onPressAuthentication(BuildContext context) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    if (state.authenticationType == AuthenticationType.login) {
      emit(state.copyWith(validateContentLogin: true));
      if (Validator.validEmail(emailController.text, context) != null ||
          Validator.validPassWord(passWordController.text, context) != null) {
        return;
      }
      try {
        DialogBuilder(context).showDialogLoading(dialog);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passWordController.text,
        );
        DialogBuilder(context).hideDialogLoading(dialog);
        AppNavigator.push(Routes.home);
      } on FirebaseAuthException catch (e) {
        DialogBuilder(context).hideDialogLoading(dialog);
        AppUtils().handleFirebaseAuthException(context, e);
      }
    } else {
      emit(state.copyWith(validateContentSignUp: true));
      if (Validator.validEmail(emailSignUpController.text, context) != null ||
          Validator.validPassWord(passWordSignUpController.text, context) !=
              null ||
          Validator.validEmpty(userNameController.text, context) != null ||
          Validator.validConfirmPassWord(confirmPasswordController.text,
                  passWordSignUpController.text, context) !=
              null) {
        return;
      }
      try {
        DialogBuilder(context).showDialogLoading(dialog);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailSignUpController.text,
          password: passWordSignUpController.text,
        );
        User? user = userCredential.user;
        if (user != null) {
          UserLocal userLocal = UserLocal(
            userName: userNameController.text,
            email: emailSignUpController.text,
            avatar: '',
          );
          await FireBaseHelper()
              .createProfileUser(user: userLocal, uid: user.uid);
        }
        DialogBuilder(context).hideDialogLoading(dialog);
        AppNavigator.push(Routes.home);
      } on FirebaseAuthException catch (e) {
        DialogBuilder(context).hideDialogLoading(dialog);
        AppUtils().handleFirebaseAuthException(context, e);
      }
    }
  }
}
