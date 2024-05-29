import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      animationDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color  (0xffFAFAFA),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 42.h),
          SvgPicture.asset('assets/icon/tasky.svg'),
          SizedBox(height: 60.h),
          TabBar(
            controller: _tabController,
            tabs: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: const Text(
                  'Log In',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: const Text(
                  'Sign Up',
                ),
              ),
            ],
            dividerHeight: 0,
            unselectedLabelStyle: TextStyle(
              color: const Color(0xff303030).withOpacity(0.5),
              fontSize: 20.r,
              fontWeight: FontWeight.w600,
            ),
            labelStyle: TextStyle(
              color: const Color(0xff303030),
              fontSize: 20.r,
              fontWeight: FontWeight.w700,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: const Color(0xffF26950),
            indicatorWeight: 2.r,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                logInWidget(),
                signUpWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget logInWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 44.h),
          Text(
            'Username or E-mail',
            style: TextStyle(
              color: Color(0xff303030),
              fontSize: 15.r,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          AppLabelTextField(
            hintText: 'Enter your username or E-mail',
          ),
          SizedBox(height: 34.h),
          Text(
            'Password',
            style: TextStyle(
              color: Color(0xff303030),
              fontSize: 15.r,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          AppLabelTextField(
            hintText: 'Enter your password',
          ),
          SizedBox(height: 32.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpWidget(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            Text(
              'Username or E-mail',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            AppLabelTextField(
              hintText: 'Enter your username or E-mail',
            ),
            SizedBox(height: 34.h),
            Text(
              'E-mail',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            AppLabelTextField(
              hintText: 'Enter your e-mail',
            ),
            SizedBox(height: 34.h),
            Text(
              'Password',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            AppLabelTextField(
              hintText: 'Create your password',
            ),
            SizedBox(height: 34.h),
            Text(
              'Password',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            AppLabelTextField(
              hintText: 'Create your password',
            ),
          ],
      ),
    );
  }
}
