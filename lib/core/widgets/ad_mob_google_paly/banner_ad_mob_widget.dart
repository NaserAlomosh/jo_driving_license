// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import '../../../add_ads_helper.dart';

// class AdMobBannerWidget extends StatefulWidget {
//   const AdMobBannerWidget({super.key});

//   @override
//   _AdMobBannerWidgetState createState() => _AdMobBannerWidgetState();
// }

// class _AdMobBannerWidgetState extends State<AdMobBannerWidget> {
//   late BannerAd _bannerAd;
//   bool _isAdLoaded = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadBannerAd();
//   }

//   void _loadBannerAd() async {
//     await AdmobHelper.initialize();
//     _bannerAd = await AdmobHelper.getBannerAd(
//       BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           setState(() {
//             _isAdLoaded = true;
//           });
//           log('Banner ad loaded.');
//         },
//       ),
//     );
//     _bannerAd.load();
//     _isAdLoaded = true;
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _bannerAd.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: _isAdLoaded ? AdWidget(ad: _bannerAd) : SizedBox.shrink(),
//     );
//   }
// }
