import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
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
            ),
          ),
        );
      },
    );
  }
}
