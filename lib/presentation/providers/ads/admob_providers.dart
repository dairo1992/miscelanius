import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelanius/config/config.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  // TODO validar si esta en modo premiun para quitar los anuncios
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw "Modo premium";
  final ad = await AdmobPlugin.loadBannerAd();

  return ad;
});

final interstitialAdProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  // TODO validar si esta en modo premiun para quitar los anuncios
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw "Modo premium";
  final ad = await AdmobPlugin.loadIntersticialAd();

  return ad;
});

final rewardedAdProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  // TODO validar si esta en modo premiun para quitar los anuncios
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw "Modo premium";
  final ad = await AdmobPlugin.loadRewardedAd();

  return ad;
});

final rewardedInterstitialAdProvider =
    FutureProvider.autoDispose<RewardedInterstitialAd>((ref) async {
  // TODO validar si esta en modo premiun para quitar los anuncios
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw "Modo premium";
  final ad = await AdmobPlugin.loadRewardedInterstitialAd();

  return ad;
});
