import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/botton_nav_bar/botton_nav_bar.dart';

import '../../../core/constants/image_path.dart';
import '../../settings/view/settings_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      width: MediaQuery.of(context).size.width / 1.8,
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getHeaders(context),
                  _listTile(
                    context,
                    leadingIcon: Icons.home,
                    tr('home'),
                    onTap: () => context.pop(),
                  ),
                  _listTile(
                    context,
                    leadingIcon: Icons.settings,
                    tr('settings'),
                    onTap: () => context.push(SettingsView()),
                  ),

                  _listTile(
                    context,
                    leadingIcon: Icons.quiz,
                    tr('allQuestions'),
                    onTap: () => context
                        .pushReplacement(const BottomNavBarApp(index: 1)),
                  ),

                  _listTile(
                    context,
                    leadingIcon: Icons.emoji_events,
                    tr('finalExam'),
                    onTap: () => context
                        .pushReplacement(const BottomNavBarApp(index: 2)),
                  ),
                  // _listTile(
                  //   context,
                  //   leadingIcon: Icons.search_sharp,
                  //   tr('search'),
                  // ),
                  //isPortraitScreen(context) ? heightSpace(450) : heightSpace(100),

                  // const Spacer(),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 30.h),
                  //   child: _listTile(
                  //     context,
                  //     tr('logout'),
                  //     leadingIcon: Icons.logout,
                  //     trailingIcon: const SizedBox(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _getHeaders(BuildContext context) {
    String userName = '${tr('welcome')} ${tr('myFriend')}';
    return UserAccountsDrawerHeader(
      currentAccountPictureSize: const Size.square(70),
      accountName: CustomText(
        text: userName,
      ),
      accountEmail: const CustomText(
        text: 'example@gmail.com ',
      ),
      currentAccountPicture: CircleAvatar(
        child: SvgPicture.asset(
          AppImage.policeManHappyHead,
          fit: BoxFit.contain,
        ),
        // backgroundColor: Color.fromARGB(255, 0, 44, 79),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _listTile(
    BuildContext context,
    String title, {
    IconData? leadingIcon,
    void Function()? onTap,
    Widget? trailingIcon,
  }) {
    return ListTile(
      onTap: onTap ?? () {},
      title: CustomText(
        text: title,
        fontSize: 16,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: 24.sp,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : const SizedBox.shrink(),
      trailing: trailingIcon ??
          Icon(
            Icons.chevron_right,
            size: 28.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
  }
}
