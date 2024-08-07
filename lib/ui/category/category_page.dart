import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/models/enum/task_type.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/ui/category/category_cubit.dart';
import 'package:untitled1/ui/home/home_cubit.dart';
import 'package:untitled1/ui/task/task_argument.dart';

class CategoryPage extends StatefulWidget {
  final int indexCategories;

  const CategoryPage({
    super.key,
    required this.indexCategories,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<CategoryCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   leading: CupertinoButton(
      //     padding: EdgeInsets.zero,
      //     onPressed: () {
      //       AppNavigator.pop();
      //     },
      //     child: Icon(Icons.arrow_back_ios),
      //   ),
      //   title: Text('Edit Profile'),
      // ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 300.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Color(
                      state.categories[widget.indexCategories].color ?? 0),
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
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              DialogBuilder(context).showDialogAddCategory(
                                onPressAdd: (String categoryName, Color color) {
                                  cubit.updateCategory(
                                    categoryName: categoryName,
                                    color: color,
                                    id: state
                                        .categories[widget.indexCategories].id,
                                    createAt: state
                                            .categories[widget.indexCategories]
                                            .createAt ??
                                        '',
                                    context: context,
                                  );
                                },
                                context: context,
                                textTitle: state
                                    .categories[widget.indexCategories].title,
                                colorSelected: Color(state
                                        .categories[widget.indexCategories]
                                        .color ??
                                    0),
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title:  Text(S.of(context).deleteTasks),
                                  content:  Text(
                                      S.of(context).doYouWantToDeleteThisTask),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:  Text(S.of(context).no,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        AppNavigator.pop();
                                        cubit.deleteCategory(
                                          idCategory: state
                                              .categories[
                                                  widget.indexCategories]
                                              .id,
                                          context: context,
                                        );
                                      },
                                      child:  Text(S.of(context).yes),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                state.categories[widget.indexCategories]
                                        .title ??
                                    '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23.r,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 50.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  state.taskByCategory[widget.indexCategories]
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  S.of(context).task,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.r,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            )
                          ],
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
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).task,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.r,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        const Spacer(),
                        CupertinoButton(
                          onPressed: () {
                            AppNavigator.push(
                              Routes.task,
                              TaskArgument(
                                taskType: TaskType.create,
                                task: TaskEntity(
                                  category: state
                                      .categories[widget.indexCategories].title,
                                ),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            margin: EdgeInsets.only(right: 25.w),
                            decoration: BoxDecoration(
                              color: Color(state
                                      .categories[widget.indexCategories]
                                      .color ??
                                  0),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount:
                            state.taskByCategory[widget.indexCategories].length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                Routes.task,
                                TaskArgument(
                                  task: state.taskByCategory[
                                      widget.indexCategories][index],
                                  taskType: TaskType.edit,
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            state
                                                    .taskByCategory[widget
                                                        .indexCategories][index]
                                                    .title ??
                                                '',
                                            style: TextStyle(
                                              color: const Color(0xff303030),
                                              fontSize: 15.r,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            state
                                                    .taskByCategory[widget
                                                        .indexCategories][index]
                                                    .category ??
                                                '',
                                            style: TextStyle(
                                              color: const Color(0xff303030)
                                                  .withOpacity(0.5),
                                              fontSize: 13.r,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      size: 30.r,
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: SizedBox(height: 10.h),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
