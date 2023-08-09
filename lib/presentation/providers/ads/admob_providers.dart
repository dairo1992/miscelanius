import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelanius/presentation/config.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  // TODO: Validar si muestra o no los anuncios
  final ad = await AdsModPlugin.loadBannerAd();
  return ad;
});
