import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/helper/extensions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

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
                    'الصفحة الرئيسية',
                    onTap: () => context.pop(),
                  ),
                  _listTile(
                    context,
                    leadingIcon: Icons.account_box,
                    'الصفحة الشخصية',
                  ),
                  _listTile(
                    context,
                    leadingIcon: Icons.favorite_border,
                    'المفضلة',
                  ),
                  _listTile(
                    context,
                    leadingIcon: Icons.search_sharp,
                    'البحث',
                  ),
                  //isPortraitScreen(context) ? heightSpace(450) : heightSpace(100),
                  const Spacer(),
                  _listTile(
                    context,
                    'تسجيل خروج',
                    trailingIcon: Icon(
                      Icons.logout,
                      size: 24.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
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
    return UserAccountsDrawerHeader(
      currentAccountPictureSize: const Size.square(70),
      accountName: const CustomText(
        text: 'fullName',
      ),
      accountEmail: const CustomText(
        text: 'example@gmail.com ',
      ),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 0, 44, 79),
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
