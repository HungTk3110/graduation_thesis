import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLabelTextField extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  final String highlightText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? background;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final bool obscureText;
  final String hintText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int? maxLength;
  final FocusNode? focusNode;

  const AppLabelTextField({
    super.key,
    this.labelText = "",
    this.labelStyle,
    this.highlightText = "*",
    this.suffixIcon,
    this.suffixIconConstraints,
    this.textEditingController,
    this.textStyle,
    this.hintText = "",
    this.hintStyle,
    this.onChanged,
    this.onSubmitted,
    this.textInputType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.maxLength,
    this.obscureText = false,
    this.background,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: textEditingController ?? TextEditingController(),
          builder: (context, TextEditingValue controller, child) {
            final isValid = validator?.call(controller.text);
            return TextField(
              enabled: enabled,
              focusNode: focusNode,
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              obscureText:obscureText,
              controller: textEditingController,
              style: textStyle ?? TextStyle(
                color: const Color(0xff303030),
                fontSize: 14.r,
                fontWeight: FontWeight.w400
              ),
              maxLines: 1,
              maxLength: maxLength,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isValid == null
                          ? Colors.transparent
                          : Colors.red),
                    borderRadius:BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isValid == null
                          ? Colors.transparent
                          : Colors.red),
                  borderRadius:BorderRadius.circular(10.r),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isValid == null
                          ? Colors.transparent
                          : Colors.red),
                  borderRadius:BorderRadius.circular(10.r),
                ),
                filled: true,
                fillColor: background ?? Colors.white,
                hintStyle: hintStyle ?? TextStyle(
                    color: const Color(0xff303030).withOpacity(0.4),
                    fontSize: 14.r,
                    fontWeight: FontWeight.w400
                ),
                hintText: hintText,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                prefixIcon: prefixIcon,
                prefixIconConstraints: prefixIconConstraints ??
                    const BoxConstraints(maxHeight: 32, maxWidth: 132),
                suffixIcon: suffixIcon,
                suffixIconConstraints: suffixIconConstraints ??
                    const BoxConstraints(maxHeight: 32, maxWidth: 32),
                counterText: "",
              ),
              cursorColor: Colors.black,
              keyboardType: textInputType,
              inputFormatters: inputFormatters,
            );
          },
        ),
        textEditingController != null
            ? ValueListenableBuilder(
                valueListenable: textEditingController!,
                builder: (context, TextEditingValue controller, child) {
                  final isValid = validator?.call(controller.text) ;
                  return Column(
                    children: [
                      10.verticalSpace,
                      isValid != null ? Text(
                        isValid,
                        style:
                        TextStyle(
                            color:Colors.red,
                            fontSize: 14.r,
                            fontWeight: FontWeight.w400
                        ),
                      ) : SizedBox(),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
