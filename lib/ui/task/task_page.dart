import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_contains.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/task/task_cubit.dart';

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
                                textEditingController: cubit.startTimeController,
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
                                textEditingController: cubit.startTimeController,
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
}
