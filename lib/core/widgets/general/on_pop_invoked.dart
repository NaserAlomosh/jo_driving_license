import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

import '../buttons/custom_button.dart';

Future<bool> onPopInvoked(BuildContext context) async {
  bool exit = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: CustomText(
          text: tr('stayFocused'),
          color: Theme.of(context).colorScheme.onBackground,
          textAlign: TextAlign.center,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
          text: tr('doYouReallyWantToLeaveTheApp'),
          color: Theme.of(context).colorScheme.onBackground,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.width * 0.12,
                background: Theme.of(context).colorScheme.tertiary,
                onPressed: () {
                  Navigator.of(context).pop(false); // Stay in the app
                },
                title: tr('keepGoing'),
                textColor: Theme.of(context).colorScheme.onBackground,
              ),
              CustomButton(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.width * 0.12,
                onPressed: () {
                  SystemNavigator.pop(); // Exit the app
                },
                title: tr('exit'),
              ),
            ],
          ),
        ],
      );
    },
  );

  return exit;
}
