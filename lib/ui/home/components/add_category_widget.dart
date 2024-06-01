import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_contains.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';

class AddCategoryWidget extends StatefulWidget {
  final Function(
    String categoryName,
    Color color,
  ) onPressAdd;

  const AddCategoryWidget({
    super.key,
    required this.onPressAdd,
  });

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  TextEditingController controller = TextEditingController();
  Color colorSelected = AppContains.colorTheme.first;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 30.h),
        Text(
          'Theme',
          style: TextStyle(
            color: const Color(0xff303030),
            fontSize: 15.r,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        AppLabelTextField(
          textEditingController: controller,
          hintText: 'Enter your Category name',
          background: Colors.grey.shade100,
        ),
        SizedBox(height: 20.h),
        Text(
          'Theme',
          style: TextStyle(
            color: const Color(0xff303030),
            fontSize: 15.r,
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
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    colorSelected = AppContains.colorTheme[index];
                  });
                },
                child: Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: AppContains.colorTheme[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: colorSelected == AppContains.colorTheme[index]
                            ? Color(0xffF26950)
                            : Colors.transparent,
                        width: 2.r),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 14);
            },
          ),
        ),
        SizedBox(height: 20.h),
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
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.onPressAdd(
                  controller.text,
                  colorSelected,
                );
              },
              child: Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                    color: Color(0xffF26950),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
