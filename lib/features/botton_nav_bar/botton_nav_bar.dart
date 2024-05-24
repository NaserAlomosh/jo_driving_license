import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';
import 'package:jo_driving_license/features/car_offices/view/car_ofifces_view.dart';
import 'package:jo_driving_license/features/final_exam/view/final_exam_view.dart';
import 'package:jo_driving_license/features/home/view/home_view.dart';
import '../../core/helper/get_device_type.dart';
import 'all_questions/view/questions_view.dart';
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
    const QuestionsView(),
    const FinalExamView(),
  ];
  @override
  void initState() {
    super.initState();
    initialIndex = widget.index ?? 0;
  }

  final List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
    ),
    const TabItem(
      icon: Icons.quiz,
    ),
    const TabItem(
      icon: Icons.emoji_events,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
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
        height: checkDeviceIsTaplet(context) ? 80 : 40,
        elevation: 100,
        backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        colorSelected: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        items: items,
        iconSize: checkDeviceIsTaplet(context) ? 40.sp : 33.sp,
        indexSelected: initialIndex,
        onTap: (int selectedIndex) => setState(() {
          initialIndex = selectedIndex;
        }),
        chipStyle: ChipStyle(
          convexBridge: true,
          background: Theme.of(context).colorScheme.surface.withOpacity(0.6),
          // size: checkDeviceIsTaplet(context) ? 100.sp : 20.sp,
        ),
        itemStyle: ItemStyle.circle,
        animated: false,
        sizeInside: checkDeviceIsTaplet(context) ? 80 : 48,
      ),
    );
  }
}
