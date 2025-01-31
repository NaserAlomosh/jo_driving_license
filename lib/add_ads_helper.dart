import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  // Replace with your actual ad unit ID
  static String get bannerUnit => 'ca-app-pub-9061646917670990/2813461362';

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static BannerAd getBannerAd(BannerAdListener listener) {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: bannerUnit,
      listener: listener,
      request: AdRequest(),
    );
  }
}

class ADState {
  static InterstitialAd? interstitialAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-9061646917670990/6255912737'
      : 'ca-app-pub-3940256099942544/4411468910';

  /// Loads an interstitial ad.
  loadAd() {
    try {
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            log('${ad.adUnitId} loaded.');
            // Keep a reference to the ad so you can show it later.
            ad.show();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // Handle the error by contains the error message.
            log('InterstitialAd failed to load: $error');
          },
        ),
      );
    } on AdError catch (e) {
      log(e.message);
    }
  }
}
