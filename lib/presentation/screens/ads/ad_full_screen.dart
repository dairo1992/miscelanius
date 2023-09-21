import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adInterstitialAsync = ref.watch(interstitialAdProvider);
    ref.listen(interstitialAdProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show();
    });
    if (adInterstitialAsync.isLoading) {
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
      body: const Center(child: Text("Ya puedes continuar")),
    );
  }
}
