import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_cubit.dart';

class CustomSwitchThemeWidget extends StatelessWidget {
  const CustomSwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Flexible(
          child: Switch(
            value: themeMode == ThemeMode.dark,
            onChanged: (_) {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        );
      },
    );
  }
}
