import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permiso Requerido"),
      ),
      body: Center(
        child: FilledButton(
          child: const Text(
            "Localizacion Necesaria",
          ),
          onPressed: () {
            ref.read(permissionsProvider.notifier).requestLocationAcess();
          },
        ),
      ),
    );
  }
}
