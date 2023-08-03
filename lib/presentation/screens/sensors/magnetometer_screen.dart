import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sensors/magnetometer_provider.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnometer = ref.watch(magnetometerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Magnetometro"),
      ),
      body: Center(child: magnometer.when(data: (data) => Text(data.x.toString()), error: (error, stackTrace) => Text("$error"), loading: ()=> const Center(child: CircularProgressIndicator.adaptive(),))),
    );
  }
}
