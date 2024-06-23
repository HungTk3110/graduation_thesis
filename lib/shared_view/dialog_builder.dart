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
}
