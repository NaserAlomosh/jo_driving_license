import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/helper/spacing.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:jo_driving_license/features/botton_nav_bar/botton_nav_bar.dart';

import '../../../core/constants/image_path.dart';
import '../../../main.dart';
import '../../settings/view/settings_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController usernameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    usernameController.text = prefs.getString('username') ?? tr('guest');
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

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
                  _listTile(
                    context,
                    leadingIcon: Icons.settings,
                    tr('settings'),
                    onTap: () => context.push(const SettingsView()),
                  ),
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
      currentAccountPicture: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SvgPicture.asset(
          AppImage.policeManHappyHead,
          fit: BoxFit.contain,
        ),
      ),
      currentAccountPictureSize: const Size.square(70),
      margin: EdgeInsets.all(4.w),
      accountName: CustomText(
        text: userName,
      ),
      accountEmail: Row(
        children: [
          InkWell(
            onTap: () => focusNode.requestFocus(),
            child: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
          ),
          widthSpace(8),
          Flexible(
            child: CustomTextFormField(
                focusNode: focusNode,
                controller: usernameController,
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.transparent,
                suffixIconColor: Colors.white,
                borderSide: BorderSide(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: InputBorder.none,
                onChanged: (p0) {
                  prefs.setString(
                    'username',
                    p0 ?? 'guest',
                  );
                }),
          ),
          widthSpace(34),
        ],
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
