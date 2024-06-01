import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:untitled1/shared_view/app_contains.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';

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

  void showDialogAddCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Categorys',
                  style: TextStyle(
                    color: const Color(0xff303030),
                    fontSize: 20.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                AppLabelTextField(
                  hintText: 'Enter your Category name',
                  background: Colors.grey.shade100,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Theme',
                  style: TextStyle(
                    color: const Color(0xff303030),
                    fontSize: 20.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 34.r,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppContains.colorTheme.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 34.r,
                        height: 34.r,
                        decoration: BoxDecoration(
                          color: AppContains.colorTheme[index],
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 14);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
