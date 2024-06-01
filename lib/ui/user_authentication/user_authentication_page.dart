import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/models/enum/authentication_type.dart';
import 'package:untitled1/ui/user_authentication/components/login_widget.dart';
import 'package:untitled1/ui/user_authentication/components/signup_widget.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';

class UserAuthenticationPage extends StatefulWidget {
  const UserAuthenticationPage({super.key});

  @override
  State<UserAuthenticationPage> createState() => _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late UserAuthenticationCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    _tabController = TabController(
      initialIndex:
          cubit.state.authenticationType == AuthenticationType.login ? 0 : 1,
      length: 2,
      animationDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
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
          SizedBox(height: 100.h),
          SvgPicture.asset('assets/icon/tasky.svg'),
          SizedBox(height: 60.h),
          tabBarWidget(),
          BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
            builder: (context, state) {
              return SizedBox(
                height: state.authenticationType == AuthenticationType.login
                    ? 600.h
                    : 1100.h,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LoginWidget(
                      cubit: cubit,
                    ),
                    SignUpWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget tabBarWidget() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            S.of(context).logIn,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            S.of(context).signUp,
          ),
        ),
      ],
      onTap: (value) {
        if (value == 0) {
          cubit.onChangeType(type: AuthenticationType.login);
        } else {
          cubit.onChangeType(type: AuthenticationType.signup);
        }
      },
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
      indicatorPadding: EdgeInsets.only(right: 60.w),
      indicatorColor: const Color(0xffF26950),
      indicatorWeight: 2.r,
    );
  }
}
