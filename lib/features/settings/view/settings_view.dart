import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../../../core/widgets/general/custom_switch_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText(
          text: tr('settings'),
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GeneralConst.horizontalPadding,
            vertical: GeneralConst.horizontalPadding,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12)),
                height: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: tr('darkMode'),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    appearanceSwitch(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appearanceSwitch() {
    return Row(
      children: [
        CustomSwitchValue(
          onChanged: (value) {
            value = !value;
          },
          value: false,
        ),
      ],
    );
  }
}
