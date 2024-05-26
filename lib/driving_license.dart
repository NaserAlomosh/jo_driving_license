import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/theme_data.dart';
import 'core/helper/design_size_responsive.dart';
import 'features/on_boarding/intro_view.dart';
import 'features/theme/theme_cubit.dart';

class DrivingLicenseApp extends StatelessWidget {
  const DrivingLicenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle();
    return BlocProvider(
      create: (context) => ThemeCubit()..initializeTheme(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: getDesignSize(context),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: lightMode,
                darkTheme: darkMode,
                themeMode: themeMode, // Apply the themeMode here
                debugShowCheckedModeBanner: false,
                home: const IntroScreen(),
              );
            },
          );
        },
      ),
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
