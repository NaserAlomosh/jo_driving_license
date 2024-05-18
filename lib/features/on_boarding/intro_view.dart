import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/widgets/general/custom_text.dart';
import '../botton_nav_bar/botton_nav_bar.dart';
import 'widgets/on_boarding_view1.dart';
import 'widgets/on_boarding_view2.dart';
import 'widgets/on_boarding_view3.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //track pages
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: GeneralConst.horizontalPadding),
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: const [
                OnBoardingViewOne(),
                OnBoardingViewTwo(),
                OnBoardingViewThree(),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 60.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: SlideEffect(
                        dotHeight: 8.w,
                        dotWidth: 8.w,
                        dotColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        activeDotColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: onLastPage
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        onLastPage
                            ? const SizedBox()
                            : Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const BottomNavBarApp();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .surfaceVariant,
                                        // border: Border.all(
                                        //   color: Theme.of(context)
                                        //       .colorScheme
                                        //       .onSecondary,
                                        ),
                                    // borderRadius:
                                    //     BorderRadius.circular(50)),
                                    child: CustomText(
                                      text: tr('skip'),
                                      textAlign: TextAlign.center,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(width: 15),
                        //next or let's go
                        onLastPage
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          });
                                      Navigator.of(context).pop();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const BottomNavBarApp();
                                          },
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 60.w,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            // color: Theme.of(context)
                                            //     .colorScheme
                                            //     .onSecondary,
                                            // borderRadius:
                                            //     BorderRadius.circular(50),
                                            ),
                                        child: CustomText(
                                          text: tr('getStarted'),
                                          textAlign: TextAlign.center,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .onSecondary,
                                        // borderRadius: BorderRadius.circular(50),
                                        ),
                                    child: CustomText(
                                      text: tr('next'),
                                      textAlign: TextAlign.center,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
