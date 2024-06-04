import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/models/enum/choose_document_type.dart';
import 'package:untitled1/models/enum/choose_photo_type.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_contains.dart';
import 'package:untitled1/shared_view/bottom_sheet_picker_document_type.dart';
import 'package:untitled1/shared_view/bottom_sheet_picker_photo_type.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/home/home_cubit.dart';
import 'package:untitled1/ui/task/task_cubit.dart';
import 'package:untitled1/utils/app_permission_utils.dart';

class TaskPage extends StatefulWidget {
  final TaskEntity? task;

  const TaskPage({
    super.key,
    required this.task,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskCubit cubit;
  final TextEditingController iconController = TextEditingController();

  @override
  void initState() {
    cubit = BlocProvider.of<TaskCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // appBar: AppBar(
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: 300.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppContains.colorTheme.first,
              image: const DecorationImage(
                image: AssetImage('assets/image/bg_collection.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          AppNavigator.pop();
                        },
                        padding: EdgeInsets.zero,
                        child: SvgPicture.asset(
                          'assets/icon/ic_back.svg',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      'Type your Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: 550.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Start Time',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.r,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 5.h),
                            CupertinoButton(
                              onPressed: () async {
                                cubit.onPressStartTime(context);
                              },
                              padding: EdgeInsets.zero,
                              child: AppLabelTextField(
                                textEditingController:
                                    cubit.startTimeController,
                                background: Color(0xffFAFAFA),
                                hintText: "Enter your start time",
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'End Time',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.r,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 5.h),
                            CupertinoButton(
                              onPressed: () async {
                                cubit.onPressStartTime(context);
                              },
                              padding: EdgeInsets.zero,
                              child: AppLabelTextField(
                                textEditingController:
                                    cubit.startTimeController,
                                background: Color(0xffFAFAFA),
                                hintText: "Enter your end time",
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Note',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.r,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 5.h),
                  AppLabelTextField(
                    background: Color(0xffFAFAFA),
                    maxLines: 5,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.r,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 5.h),
                  BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                    return DropdownMenu(
                      initialSelection: state.categories.first,
                      controller: iconController,
                      // requestFocusOnTap is enabled/disabled by platforms when it is null.
                      // On mobile platforms, this is false by default. Setting this to true will
                      // trigger focus request on the text field and virtual keyboard will appear
                      // afterward. On desktop platforms however, this defaults to true.
                      requestFocusOnTap: true,
                      // onSelected: (ColorLabel? color) {
                      //   setState(() {
                      //     selectedColor = color;
                      //   });
                      // },
                      dropdownMenuEntries: state.categories
                          .map<DropdownMenuEntry<Categories>>(
                              (Categories color) {
                        return DropdownMenuEntry<Categories>(
                          value: color,
                          label: color.title ?? '',
                          // enabled: color.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Color(color.color ?? 0),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Document',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.r,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _showBottomSheetPickTypeSelectImage();
                        },
                        child: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                              color: Color(0xffF26950),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: 80.h,
            color: Colors.white,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                    color: Color(0xffF26950),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: Text(
                    'Create Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.r,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showBottomSheetPickTypeSelectImage() async {
    FocusScope.of(context).unfocus();
    ChooseDocumentType? chooseType = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const BottomSheetPickerDocumentType();
      },
    );
    if (chooseType != null) {
      switch (chooseType) {
        case ChooseDocumentType.photo:
          _pickPhotoFromLibrary();
          break;
        case ChooseDocumentType.file:
          _pickFile();
          break;
      }
    }
  }

  Future<void> _pickPhotoFromLibrary() async {
    final isDenied = await AppPermissionUtils.askPhotoLibraryPermission(() {
      // TODO: - show dialog permission denied
    });
    if (isDenied) return;
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    File file = File(imageFile.path);
    print('Image uploaded to Firebase Storage: ');

  }

  Future<void> _pickFile() async {
    final isDenied = await AppPermissionUtils.askFileMediaPermission(() {
      // TODO: - show dialog permission denied
    });
    if (isDenied) return;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    File file = File(result.files.single.path!);

  }
}
