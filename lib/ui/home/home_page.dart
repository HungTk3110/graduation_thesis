import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/home/components/nav_drawer.dart';
import 'package:untitled1/ui/home/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeCubit cubit;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late TabController _tabController;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      animationDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    cubit.initData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: CupertinoButton(
      //     onPressed: () {
      //       _key.currentState?.openDrawer();
      //     },
      //     child: SizedBox(
      //       width: 24.r,
      //       height: 24.r,
      //       child: SvgPicture.asset(
      //         'assets/icon/menu.svg',
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         AppNavigator.push(Routes.profile);
      //       },
      //       child: Container(
      //         width: 46.r,
      //         height: 46.r,
      //         margin: EdgeInsets.only(right: 25.w),
      //         child: BlocBuilder<HomeCubit, HomeState>(
      //           builder: (context, state) {
      //             return AppCacheImage(
      //               url: state.userLocal?.avatar ?? '',
      //               borderRadius: 10.r,
      //             );
      //           },
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: RefreshIndicator(
          onRefresh: () async {
            await cubit.initData(context);
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25.h),
                SizedBox(
                  height: 54.r,
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _key.currentState?.openDrawer();
                        },
                        child: Container(
                          width: 54.r,
                          height: 54.r,
                          decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(14.r)),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icon/menu.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: AppLabelTextField(
                            hintText: 'Search Your Task',
                            hintStyle: TextStyle(
                              color: Color(0xff303030).withOpacity(0.4),
                              fontSize: 13.r,
                              fontWeight: FontWeight.w400,
                            ),
                            background: Color(0xfff5f5f5),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child:
                                  SvgPicture.asset('assets/icon/ic_search.svg'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                            fontSize: 15.r,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: state.userLocal?.userName ?? '',
                            style: TextStyle(
                              fontSize: 15.r,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffF26950),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                Text(
                  'Complete your task today',
                  style: TextStyle(
                    color: const Color(0xff303030),
                    fontSize: 20.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Category',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        DialogBuilder(context).showDialogAddCategory(
                            onPressAdd: (String categoryName, Color color) {
                              cubit.onPressAddCategory(
                                Categories(
                                  title: categoryName,
                                  color: color.value,
                                ),
                              );
                            },
                            context: context);
                      },
                      child: Container(
                        width: 40.r,
                        height: 40.r,
                        margin: EdgeInsets.only(right: 25.w),
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
                SizedBox(height: 12.h),
                SizedBox(
                  height: 210.h,
                  child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemCategory(state.categories[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 15.w);
                      },
                    );
                  }),
                ),
                Row(
                  children: [
                    TabBar(
                      indicatorColor: const Color(0xffF26950),
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorPadding: EdgeInsets.only(right: 20.w),
                      labelPadding: EdgeInsets.zero,
                      dividerHeight: 0,
                      controller: _tabController,
                      unselectedLabelStyle: TextStyle(
                        color: const Color(0xff303030).withOpacity(0.5),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10.h, right: 15.w, top: 10.h),
                          child: Text(
                            'In Progress',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10.h, right: 15.w, top: 10.h),
                          child: Text(
                            'Complete',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 40.r,
                      height: 40.r,
                      margin: EdgeInsets.only(right: 25.w),
                      decoration: BoxDecoration(
                          color: Color(0xffF26950),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container itemCategory(
    Categories category,
  ) {
    return Container(
      width: 152.w,
      height: 210.h,
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        color: Color(category.color ?? 0),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Color(category.color ?? 0).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
        image: const DecorationImage(
            image: AssetImage('assets/image/bg_collection.png'),
            fit: BoxFit.fill),
      ),
      child: Column(
        children: [Text(category.title ?? '')],
      ),
    );
  }
}
