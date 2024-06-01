import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_cache_image.dart';
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
      length: 3,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CupertinoButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          child: SizedBox(
            width: 24.r,
            height: 24.r,
            child: SvgPicture.asset(
              'assets/icon/menu.svg',
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AppNavigator.push(Routes.profile);
            },
            child: Container(
              width: 46.r,
              height: 46.r,
              margin: EdgeInsets.only(right: 25.w),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return AppCacheImage(
                    url: state.userLocal?.avatar ?? '',
                    borderRadius: 10.r,
                  );
                },
              ),
            ),
          )
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Padding(
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
                child: SvgPicture.asset('assets/icon/ic_search.svg'),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  color: const Color(0xff303030),
                  fontSize: 15.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  DialogBuilder(context).showDialogAddCategory(context);
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
          Container(
            width: 152.w,
            height: 210.h,
            decoration: BoxDecoration(
              color: Color(0xff5486E9),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff5486E9).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 10), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                  image: AssetImage('assets/image/bg_collection.png'),
                  fit: BoxFit.fill),
            ),
            child: Column(
              children: [],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SizedBox(
                width: 300.w,
                child: TabBar(
                  padding: EdgeInsets.zero,
                  dividerHeight: 0,
                  controller: _tabController,
                  tabs: [
                    Text(
                      'Category',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                        color: const Color(0xff303030),
                        fontSize: 15.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
