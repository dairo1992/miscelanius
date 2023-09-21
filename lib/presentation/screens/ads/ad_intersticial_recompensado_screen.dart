import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class AdIntersticialcreen extends ConsumerWidget {
  const AdIntersticialcreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final rewardedInterstitialAsync = ref.watch(rewardedInterstitialAdProvider);
    ref.listen(rewardedInterstitialAdProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          print("Puntos ganados: ${reward.amount}");
        },
      );
    });
    if (rewardedInterstitialAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text("Cargando anuncios"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Ads Intersticial creen")),
      body: const Center(child: Text("Ya puedes continuar")),
    );
  }
}
