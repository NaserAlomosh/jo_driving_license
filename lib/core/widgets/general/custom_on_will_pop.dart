import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helper/get_device_type.dart';
import '../../helper/spacing.dart';
import 'custom_text.dart';

Future<bool> customOnWillPop(
  BuildContext context, {
  void Function()? onPressed,
}) async {
  bool exit = await showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isTablet = checkDeviceIsTaplet(context);
      double dialogWidth = isTablet
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.8;
      double? dialogHeight =
          isTablet ? MediaQuery.of(context).size.height * 0.18 : null;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: dialogWidth,
          height: dialogHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Exit App',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'Are you sure you want to exit the app?',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),

              const Divider(), // Divider above buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Don't exit
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: 'No',
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  widthSpace(8),
                  TextButton(
                    onPressed: onPressed ??
                        () {
                          SystemNavigator.pop();
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: 'Yes',
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return exit;
}
