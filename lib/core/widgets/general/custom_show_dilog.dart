import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';

import '../../helper/get_device_type.dart';
import '../buttons/custom_button.dart';
import 'custom_text.dart';

void showDialogErrorBack(BuildContext context, String error) {
  bool isTablet = checkDeviceIsTaplet(context);
  double? dialogWidth =
      isTablet ? MediaQuery.of(context).size.width * 0.6 : null;

  double? dialogHeight =
      isTablet ? MediaQuery.of(context).size.height * 0.15 : null;
  context.pop();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shadowColor: Theme.of(context).colorScheme.primary,
      elevation: 2,
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: isTablet ? 24.sp : 32.sp,
              ),
              const SizedBox(height: 16),
              CustomText(
                text: error,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomText(
            text: 'Cancel',
          ),
        ),
      ],
    ),
  );
}

void showDialogSuccessBack(
  BuildContext context,
  String msg, {
  bool backBefore = false,
}) {
  if (backBefore) {
    context.pop();
  }
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.email_outlined,
        color: Colors.green,
        size: 32,
      ),
      content: Text(
        msg,
        style: const TextStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Got it',
            style: TextStyle(),
          ),
        ),
      ],
    ),
  );
}

Future questionBackShowDiloge(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: CustomText(
          text: tr('neverGiveUp'),
          color: Theme.of(context).colorScheme.onBackground,
          textAlign: TextAlign.center,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
          text: tr('areYouSureYouWantToExitTheQuiz'),
          color: Theme.of(context).colorScheme.onBackground,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.width * 0.12,
                background: Theme.of(context).colorScheme.tertiary,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: tr('no'),
                textColor: Theme.of(context).colorScheme.onBackground,
              ),
              CustomButton(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.width * 0.12,
                onPressed: () {
                  Navigator.of(context).pop(); // Pop the dialog
                  Navigator.of(context).pop(); // Pop the quiz screen
                },
                title: tr('yes'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
