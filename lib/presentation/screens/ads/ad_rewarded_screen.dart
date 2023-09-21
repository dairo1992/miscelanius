import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adRewardedAsync = ref.watch(rewardedAdProvider);
    final points = ref.watch(adsPointsprovider);
    ref.listen(rewardedAdProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          print("Puntos ganados: ${reward.amount}");
          ref.read(adsPointsprovider.notifier).update((state) => state + 10);
        },
      );
    });
    if (adRewardedAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text("Cargando anuncios"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ad Full Screen"),
      ),
      body: Center(child: Text("Puntos actualies: $points")),
    );
  }
}
