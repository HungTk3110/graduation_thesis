import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/shared_view/dialog_builder.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';
import 'package:untitled1/utils/validator.dart';

class LoginWidget extends StatefulWidget {
  final UserAuthenticationCubit cubit;

  const LoginWidget({
    super.key,
    required this.cubit,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 44.h),
          Text(
            S.of(context).usernameOrEmail,
            style: TextStyle(
              color: Color(0xff303030),
              fontSize: 15.r,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
            buildWhen: (prev, current) =>
                prev.validateContentLogin != current.validateContentLogin,
            builder: (context, state) {
              return AppLabelTextField(
                textEditingController: widget.cubit.emailController,
                hintText: 'Enter your E-mail',
                validator: (value) {
                  if (!state.validateContentLogin) {
                    return null;
                  } else {
                    return Validator.validEmail(value, context);
                  }
                },
              );
            },
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
          BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
            buildWhen: (prev, current) =>
                prev.validateContentLogin != current.validateContentLogin,
            builder: (context, state) {
              return AppLabelTextField(
                textEditingController: widget.cubit.passWordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                obscureText: isShowPassword,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    child: SvgPicture.asset(
                      isShowPassword
                          ? 'assets/icon/eye-off.svg'
                          : 'assets/icon/eye.svg',
                      width: 18.r,
                      height: 18.r,
                    ),
                  ),
                ),
                validator: (value) {
                  if (!state.validateContentLogin) {
                    return null;
                  } else {
                    return Validator.validPassWord(value ?? '', context);
                  }
                },
              );
            },
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () {
              DialogBuilder(context).showDialogResetPassword(
                context: context,
              );
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xff303030),
                  fontSize: 15.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 34.h),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              widget.cubit.onPressAuthentication(context);
            },
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                  color: Color(0xffF26950),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.r,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
