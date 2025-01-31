import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/get_device_type.dart';

class CustomTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final TextInputType? textInputType;
  final bool? readOnly;
  final int? maxLength;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final Color? borderSideColor;
  final bool? enabled;
  final int? maxLine;
  final Color? suffixIconColor;
  final TextAlign? textAlign;
  final double? borderRadius;
  final FocusNode? focusNode;
  const CustomTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.validator,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.textStyle,
    this.borderSideColor,
    this.borderSide,
    this.enabled,
    this.maxLength,
    this.textInputType,
    this.maxLine,
    this.suffixIconColor,
    this.textAlign,
    this.borderRadius,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLine ?? 1,
      keyboardType: textInputType,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      cursorColor: Theme.of(context).colorScheme.primary,
      controller: controller,
      obscureText: isObscureText ?? false,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          fontSize: 12.0.sp,
        ),
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 1),
              borderSide: BorderSide(
                color: borderSideColor ??
                    Theme.of(context).colorScheme.onBackground,
                width: 1,
              ),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 1),
              borderSide: borderSide ??
                  BorderSide(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    width: 1,
                  ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 1),
          borderSide: borderSide ??
              BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 1,
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 1),
          borderSide: borderSide ??
              BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1,
              ),
        ),
        hintStyle: TextStyle(
          fontSize: (checkDeviceIsTaplet(context) ? 10.sp : 16.sp),
        ),
        hintText: hintText,
        suffixIconColor: suffixIconColor,
        fillColor: backgroundColor ?? Theme.of(context).colorScheme.background,
        filled: true,
      ),
      style: textStyle ??
          TextStyle(
            fontSize: (checkDeviceIsTaplet(context) ? 10.sp : 16.sp),
          ),
    );
  }
}
