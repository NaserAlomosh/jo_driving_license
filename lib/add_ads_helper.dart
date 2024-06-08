import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  static String get bannerUnit => 'ca-app-pub-9061646917670990/6728801438';
  late RewardedAd _rewardedAd;
  InterstitialAd? _interstitialAd;
  int num_of_attempt_load = 0;

  static initialize() {
    // Create an instance of AdmobHelper
    AdmobHelper admobHelper = AdmobHelper();
    // Call instance method using the instance
    admobHelper.createInterad();
  }

  static getBannerAd() {
    try {
      BannerAd bAd = new BannerAd(
          size: AdSize.banner,
          adUnitId: bannerUnit,
          listener: BannerAdListener(
            onAdClosed: (Ad ad) {
              print("Ad Closed");
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdLoaded: (Ad ad) {
              print('Ad Loaded');
            },
            onAdOpened: (Ad ad) {
              print('Ad opened');
            },
          ),
          request: AdRequest());
      return bAd;
    } catch (e) {
      log(e.toString());
    }
  }

  // Instance method to create interstitial ads
  void createInterad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        num_of_attempt_load + 1;
        _interstitialAd = null;

        if (num_of_attempt_load <= 2) {
          createInterad();
        }
      }),
    );
  }

  // Instance method to show interstitial ads to user
  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createInterad();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }

  void createRewardAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            this._rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  void showRewardAd() {
    // _rewardedAd.show(
    //     onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
    //   print("Adds Reward is ${rewardItem.amount}");
    // });
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
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
