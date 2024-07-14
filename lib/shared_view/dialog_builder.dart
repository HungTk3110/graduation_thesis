import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/home/components/add_category_widget.dart';

class DialogBuilder {
  final BuildContext context;

  DialogBuilder(this.context);

  void showDialogLoading(SimpleFontelicoProgressDialog dialog) {
    dialog.show(
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal,
        indicatorColor: Color(0xffF26950));
  }

  void hideDialogLoading(SimpleFontelicoProgressDialog dialog) {
    dialog.hide();
  }

  void showDialogAddCategory({
    required BuildContext context,
    String? textTitle,
    Color? colorSelected,
    required Function(
      String categoryName,
      Color color,
    ) onPressAdd,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: AddCategoryWidget(
              onPressAdd: onPressAdd,
              textTitle: textTitle,
              colorSelected: colorSelected,
            ),
          ),
        );
      },
    );
  }

  void showDialogTitleTask({
    required BuildContext context,
    required TextEditingController controller,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                AppLabelTextField(
                  textEditingController: controller,
                  background: Color(0xffFAFAFA),
                ),
                SizedBox(height: 30),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppNavigator.pop();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                        color: Color(0xffF26950),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Center(
                      child: Text(
                        'ok',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.r,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogResetPassword({
    required BuildContext context,
  }) {
    TextEditingController emailResetPassword = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Color(0xff252729).withOpacity(0.8),
                    fontSize: 22.r,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Enter your username or email we will send 5 digits verification code',
                  style: TextStyle(
                    color: Color(0xff252729).withOpacity(0.4),
                    fontSize: 14.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Username or E-mail',
                  style: TextStyle(
                    color: Color(0xff252729).withOpacity(0.8),
                    fontSize: 15.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppLabelTextField(
                  textEditingController: emailResetPassword,
                  background: Color(0xffFAFAFA),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: const Color(0xff303030),
                          fontSize: 15.r,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: emailResetPassword,
                      builder: (BuildContext context, value, Widget? child) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: value.text.isNotEmpty
                              ? () async{
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: emailResetPassword.text)
                                .then((value) => {
                              AppNavigator.pop()
                            })
                                .catchError((error) {
                              // Xử lý lỗi: Hiển thị thông báo lỗi cho người dùng
                              print("Reset password failed: $error");
                            });
                          }
                              : null,
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                                color: value.text.isNotEmpty ? Color(0xffF26950) : Colors.grey,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
