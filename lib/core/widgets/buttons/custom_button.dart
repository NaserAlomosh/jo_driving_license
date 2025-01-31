import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../general/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? background;
  final Color? textColor;
  final bool isDisable;
  final double fontSize;
  final double borderRadius;
  final Function() onPressed;
  final double? width;
  final double? height;
  final double? elevation;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    required this.title,
    this.background,
    required this.onPressed,
    this.isDisable = false,
    this.fontSize = 16,
    this.borderRadius = 12,
    this.textColor,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation),
          foregroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade400;
            }
            return background ?? Theme.of(context).colorScheme.primary;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: isDisable ? null : onPressed,
        child: CustomText(
          color: textColor,
          text: title,
          fontSize: fontSize,
          textAlign: TextAlign.center,
          fontWeight: fontWeight ?? FontWeight.bold,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
