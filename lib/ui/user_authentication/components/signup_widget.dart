import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';
import 'package:untitled1/utils/validator.dart';

class SignUpWidget extends StatefulWidget {
  final UserAuthenticationCubit cubit;

  const SignUpWidget({super.key, required this.cubit});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 44.h),
            Text(
              'Username',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
              buildWhen: (prev, current) =>
                  prev.validateContentSignUp != current.validateContentSignUp,
              builder: (context, state) {
                return AppLabelTextField(
                  textEditingController: widget.cubit.userNameController,
                  hintText: 'Enter your username',
                  validator: (value) {
                    if (!state.validateContentSignUp) {
                      return null;
                    } else {
                      return Validator.validEmpty(value, context);
                    }
                  },
                );
              },
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
            BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
              buildWhen: (prev, current) =>
                  prev.validateContentSignUp != current.validateContentSignUp,
              builder: (context, state) {
                return AppLabelTextField(
                  textEditingController: widget.cubit.emailSignUpController,
                  hintText: 'Enter your e-mail',
                  validator: (value) {
                    if (!state.validateContentSignUp) {
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
                  prev.validateContentSignUp != current.validateContentSignUp,
              builder: (context, state) {
                return AppLabelTextField(
                  textEditingController: widget.cubit.passWordSignUpController,
                  hintText: 'Create your password',
                  obscureText:isShowPassword,
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
                    if (!state.validateContentSignUp) {
                      return null;
                    } else {
                      return Validator.validPassWord(value ?? '', context);
                    }
                  },
                );
              },
            ),
            SizedBox(height: 34.h),
            Text(
              'Confirm password',
              style: TextStyle(
                color: Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
              buildWhen: (prev, current) =>
                  prev.validateContentSignUp != current.validateContentSignUp,
              builder: (context, state) {
                return AppLabelTextField(
                  textEditingController: widget.cubit.confirmPasswordController,
                  hintText: 'Confirm your password',
                  obscureText:isShowConfirmPassword,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          isShowConfirmPassword = !isShowConfirmPassword;
                        });
                      },
                      child: SvgPicture.asset(
                        isShowConfirmPassword
                            ? 'assets/icon/eye-off.svg'
                            : 'assets/icon/eye.svg',
                        width: 18.r,
                        height: 18.r,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (!state.validateContentSignUp) {
                      return null;
                    } else {
                      return Validator.validConfirmPassWord(
                        value ?? '',
                        widget.cubit.passWordSignUpController.text,
                        context,
                      );
                    }
                  },
                );
              },
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
                    'Sign Up',
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
      ),
    );
  }
}
