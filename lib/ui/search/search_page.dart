import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/models/enum/task_type.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/search/search_cubit.dart';
import 'package:untitled1/ui/task/task_argument.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<SearchCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            AppNavigator.pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Search'),
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: AppLabelTextField(
                  hintText: S.of(context).searchYourTask,
                  hintStyle: TextStyle(
                    color: Color(0xff303030).withOpacity(0.4),
                    fontSize: 13.r,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (value) {
                    cubit.searchTaskByTitle(title: value);
                  },
                  background: Color(0xfff5f5f5),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: SvgPicture.asset('assets/icon/ic_search.svg'),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.tasks.length,
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.push(
                          Routes.task,
                          TaskArgument(
                            task: state.tasks[index],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.tasks[index].title ?? '',
                                      style: TextStyle(
                                        color: const Color(0xff303030),
                                        fontSize: 15.r,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.tasks[index].category ?? '',
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
              )
            ],
          ),
        );
      },
    );
  }
}
