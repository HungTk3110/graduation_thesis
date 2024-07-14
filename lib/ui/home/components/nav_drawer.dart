import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_circle_avatar.dart';
import 'package:untitled1/ui/home/home_cubit.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffFAFAFA),
      child: SafeArea(

        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return Column(
            children: <Widget>[
              SizedBox(height: 35.h),
              AppCircleAvatar(
                size: 150,
                url: state.userLocal?.avatar ?? '',
              ),
              SizedBox(height: 25.h),
              Text(
                'User Name: ${state.userLocal?.userName ?? ''}',
                style: TextStyle(
                  color: const Color(0xff303030),
                  fontSize: 15.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Email: ${state.userLocal?.email ?? ''}',
                style: TextStyle(
                  color: const Color(0xff303030).withOpacity(0.4),
                  fontSize: 15.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 25.h),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  AppNavigator.pop();
                  AppNavigator.push(Routes.profile);
                },
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  margin: EdgeInsets.symmetric(horizontal: 80.w),
                  decoration: BoxDecoration(
                      color: Color(0xffF26950),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Text(
                      S.of(context).edit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.r,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Divider(),
              ListTile(
                leading: Icon(Icons.language),
                title: Text("Language"),
                onTap: () => {
                  AppNavigator.push(Routes.language)
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(S.of(context).logout),
                onTap: () => {
                  AppNavigator.push(Routes.authen)
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
