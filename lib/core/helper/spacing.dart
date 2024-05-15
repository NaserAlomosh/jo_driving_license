import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// It helps me choose spaces vertically or horizontally in a way that is consistent with the sizes of the devices(Responsive)
SizedBox heightSpace(double height) => SizedBox(
      height: height.h,
    );

SizedBox widthSpace(double width) => SizedBox(
      width: width.w,
    );
