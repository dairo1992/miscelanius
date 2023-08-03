import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sensors/acelerometer_provider.dart';

class AcelerometerScreen extends ConsumerWidget {
  const AcelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userAcelerometer = ref.watch(acelerometerGravityProvider);
    final gravityAcelerometer = ref.watch(acelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acelerometro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Acelerometro User"),
            userAcelerometer.when(
                data: (data) => Text(data.toString(), style: const TextStyle(fontSize: 30)),
                error: (error, stackTrace) => Text("$error"),
                loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )),
                    const SizedBox(height: 130,),
            const Text("Acelerometro Gravity"),
            gravityAcelerometer.when(
                data: (data) => Text(data.toString(), style: const TextStyle(fontSize: 30)),
                error: (error, stackTrace) => Text("$error"),
                loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ))
          ],
        ),
      ),
    );
  }
}
