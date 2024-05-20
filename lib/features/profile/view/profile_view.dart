import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/core/widgets/text_fields/custom_text_form_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailontroller = TextEditingController();
    emailontroller.text = 'email@gmail.com';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: GeneralConst.horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30.sp,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 38.sp,
                    ),
                  ),
                  CustomText(
                    text: 'Ibtisam Alhelwe',
                    fontSize: 25.sp,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomText(
                      //   text: tr('email'),
                      //   fontSize: 18.sp,
                      //   color: Theme.of(context).colorScheme.onBackground,
                      // ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: emailontroller,
                    hintText: tr('email'),
                    readOnly: true,
                    borderRadius: 12,
                    backgroundColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    borderSideColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
