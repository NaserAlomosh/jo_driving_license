import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/car_offices/view/car_ofifces_view.dart';
import 'package:jo_driving_license/features/final_exam/view/final_exam_view.dart';
import 'package:jo_driving_license/features/home/view/home_view.dart';
import 'widgets/app_drawer.dart';

class BottomNavBarApp extends StatefulWidget {
  final int? index;

  const BottomNavBarApp({
    super.key,
    this.index,
  });

  @override
  BottomNavBarAppState createState() => BottomNavBarAppState();
}

class BottomNavBarAppState extends State<BottomNavBarApp> {
  late int initialIndex;
  List<Widget> screens = [
    const HomeView(),
    const FinalExamView(),
    const CarOfficesView(),
  ];
  @override
  void initState() {
    super.initState();
    initialIndex = widget.index ?? 0;
  }

  final List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      // title: tr('home'),
    ),
    const TabItem(
      icon: Icons.quiz,
      // title: tr('favourite'),
    ),
    const TabItem(
      icon: Icons.emoji_events,
      // title: tr('favourite'),
    ),
    // const TabItem(
    //   icon: Icons.person,
    //   // title: tr('profile'),
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 28.h,
              ),
            );
          },
        ),
        title: Row(
          children: [
            // CustomText(
            //   text: 'الاردن',
            //   color: Theme.of(context).colorScheme.primary,
            //   fontWeight: FontWeight.bold,
            //   fontSize: 20.sp,
            // ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                radius: 20.sp,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.person,
                  size: 28.sp,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: tr('hello'),
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                CustomText(
                  text: 'Tasneem',
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ],
            ),
          ],
        ),
      ),
      body: screens[initialIndex],
      bottomNavigationBar: BottomBarInspiredInside(
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: items,
        color: Colors.white,
        iconSize: 32.sp,
        colorSelected: Colors.white,
        indexSelected: initialIndex,
        onTap: (int selectedIndex) => setState(() {
          initialIndex = selectedIndex;
        }),
        chipStyle: ChipStyle(
          convexBridge: true,
          background: Theme.of(context).colorScheme.surface.withOpacity(0.2),
        ),
        itemStyle: ItemStyle.circle,
        animated: false,
      ),
    );
  }
}
