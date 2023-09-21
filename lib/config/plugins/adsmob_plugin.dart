import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

// ! replace this test ad unit with your own ad unit.
final adBannerId = Platform.isAndroid
    //  ? 'ca-app-pub-3940256099942544/6300978111'  //PRUEBAS
    ? 'ca-app-pub-5396621013512775/6045917683' // CUENTA PERSONAL
    : 'ca-app-pub-3940256099942544/2934735716';

// TODO: replace this test ad unit with your own ad unit.
final aDIntersticialId = Platform.isAndroid
    // ? 'ca-app-pub-3940256099942544/1033173712' //PRUEBAS
    ? 'ca-app-pub-5396621013512775/3283528130'
    : 'ca-app-pub-3940256099942544/4411468910';

// TODO: replace this test ad unit with your own ad unit.
final adRewardedId = Platform.isAndroid
    // ? 'ca-app-pub-3940256099942544/5224354917'  //PRUEBAS
    ? 'ca-app-pub-5396621013512775/1479491875'
    : 'ca-app-pub-3940256099942544/1712485313';

// TODO: replace this test ad unit with your own ad unit.
final rewardedInterstitialId = Platform.isAndroid
    ? 'ca-app-pub-5396621013512775/2141836852'
    : 'ca-app-pub-3940256099942544/6978759866';

class AdmobPlugin {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    return BannerAd(
      adUnitId: adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  static Future<InterstitialAd> loadIntersticialAd() async {
    Completer<InterstitialAd> completer = Completer();
    InterstitialAd.load(
        adUnitId: aDIntersticialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            print('$ad loaded.');

            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            completer.completeError(error);
          },
        ));
    return completer.future;
  }

  static Future<RewardedAd> loadRewardedAd() async {
    Completer<RewardedAd> completer = Completer();
    RewardedAd.load(
        adUnitId: adRewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');

            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            completer.completeError(error);
          },
        ));
    return completer.future;
  }

  static Future<RewardedInterstitialAd> loadRewardedInterstitialAd() async {
    Completer<RewardedInterstitialAd> completer = Completer();
    RewardedInterstitialAd.load(
        adUnitId: rewardedInterstitialId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            completer.completeError(error);
          },
        ));
    return completer.future;
  }
}
