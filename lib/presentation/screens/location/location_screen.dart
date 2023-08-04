import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationAsync = ref.watch(userlocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubicacion"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Ubicacion actual"),
          locationAsync.when(data: (data) => Text("$data"), error: (error, stackTrace) => Text("$error"), loading: ()=> CircularProgressIndicator.adaptive()),
          const SizedBox(
            height: 30,
          ),
          const Text("Seguimiento de ubicacion"),
        ],
      ),
    );
  }
}
