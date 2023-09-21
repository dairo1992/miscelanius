import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/config/plugins/share_preferences_plugin.dart';

const _storeKey = "showAds";

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharePreferencesPlugin.getBool(_storeKey) ?? true;
  }

  void removeAds() {
    SharePreferencesPlugin.setBool(_storeKey, false);
    state = false;
  }

  void showAds() {
    SharePreferencesPlugin.setBool(_storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});
