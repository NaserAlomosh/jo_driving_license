import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../add_ads_helper.dart';

class AdMobBannerWidget extends StatelessWidget {
  const AdMobBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(
        ad: AdmobHelper.getBannerAd()..load(),
        key: UniqueKey(),
      ),
      height: 50,
    );
  }
}
