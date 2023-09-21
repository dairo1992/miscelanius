import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permissions"),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {
    final permisions = ref.watch(permissionsProvider);
    final showAds = ref.watch(showAdsProvider);
    return ListView(
      children: [
        CheckboxListTile(
          value: permisions.cameraGranted,
          title: const Text("Camara"),
          subtitle: Text(permisions.camera.toString()),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAcess();
          },
        ),
        CheckboxListTile(
          value: permisions.photosLibraryGranted,
          title: const Text("Galeria Fotos"),
          subtitle: Text(permisions.photosLibrary.toString()),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotosLibraryAcess();
          },
        ),
        CheckboxListTile(
          value: permisions.locationGranted,
          title: const Text("Ubicacion"),
          subtitle: Text(permisions.location.toString()),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAcess();
          },
        ),
        CheckboxListTile(
          value: permisions.sensorsGranted,
          title: const Text("Sensores"),
          subtitle: Text(permisions.sensors.toString()),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAcess();
          },
        ),
        CheckboxListTile(
          value: permisions.locationAlwaysGranted,
          title: const Text("locationAlways"),
          subtitle: Text(permisions.locationAlways.toString()),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAlwaysAcess();
          },
        ),
        CheckboxListTile(
          value: permisions.locationWhenInUserGranted,
          title: const Text("locationWhenInUse"),
          subtitle: Text(permisions.locationWhenInUser.toString()),
          onChanged: (_) {
            ref
                .read(permissionsProvider.notifier)
                .requestLocationWhenInUserAcess();
          },
        ),
        SwitchListTile(
          value: showAds,
          title: const Text("Mostrar Ads"),
          subtitle: Text("Esta opcion muestra y oculta ads"),
          onChanged: (_) {
            ref.read(showAdsProvider.notifier).toggleAds();
          },
        ),
      ],
    );
  }
}
