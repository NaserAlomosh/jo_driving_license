import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final AlignmentGeometry? alignment;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.padding,
    this.fit,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.h, vertical: 6),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(14),
          child: SizedBox(
            height: height ?? 100.sp,
            width: width ?? 100.sp,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              fit: fit ?? BoxFit.cover,
              placeholder: (context, url) => SizedBox(
                height: height ?? 100.sp,
                width: width ?? 100.sp,
                child: myLoadingIndicator(context),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
