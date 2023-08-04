import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometric = ref.watch(canCheckBiometricProvider);
    final localAuthState = ref.watch(localAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometricos"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  ref.read(localAuthProvider.notifier).authenticateUser();
                },
                child: const Text("Authenticar")),
            // TODO:
            canCheckBiometric.when(
                data: (canCheck) =>
                    Text("Puede revisar biometricos: $canCheck"),
                error: (error, stacktrace) => Text("$error"),
                loading: () => const SizedBox()),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Estado del biometrico",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              localAuthState.toString(),
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
