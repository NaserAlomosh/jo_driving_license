import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/theme_data.dart';
import 'core/helper/design_size_responsive.dart';
import 'features/on_boarding/intro_view.dart';

class DrivingLicenseApp extends StatelessWidget {
  const DrivingLicenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle();
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: getDesignSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          locale: context.locale,
          theme: lightMode,
          darkTheme: darkMode,
          debugShowCheckedModeBanner: false,
          home:
              //  Directionality(
              // textDirection: TextDirection.ltr,
              // child: BottomNavBarApp(),
              // child:
              const IntroScreen(),
          //  ),
        );
      },
    );
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: const Color(0xFFF7F7F7).withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
//
