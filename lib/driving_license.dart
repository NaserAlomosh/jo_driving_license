import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/theme_data.dart';
import 'core/helper/design_size_responsive.dart';
import 'features/botton_nav_bar/botton_nav_bar.dart';

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
          theme: lightMode,
          darkTheme: darkMode,
          debugShowCheckedModeBanner: false,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavBarApp(),
          ),
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