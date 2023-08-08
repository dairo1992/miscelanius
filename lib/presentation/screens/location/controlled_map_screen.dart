import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final watchUserLocation = ref.watch(watchLocationProvider);
    final watchUserLocation = ref.watch(userlocationProvider);

    return Scaffold(
      body: watchUserLocation.when(
          data: (data) => MapAndControlls(
                lat: data.$1,
                lng: data.$2,
              ),
          error: (error, _) => Text("$error"),
          loading: () => const Center(
                child: Text("Ubicando usuario"),
              )),
    );
  }
}

class MapAndControlls extends ConsumerWidget {
  final double lat;
  final double lng;

  const MapAndControlls({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context, ref) {
    final mapController = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(
          initialLat: lat,
          initialLng: lng,
        ),
        // TODO Ir atras
        Positioned(
            top: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            )),
        // TODO mi ubicacion
        Positioned(
            bottom: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () => ref
                  .read(mapControllerProvider.notifier)
                  .goToLocation(lat, lng),
              icon: const Icon(Icons.location_searching_outlined),
            )),
        // TODO Ir a la posicion del usuario
        Positioned(
            bottom: 90,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () => ref
                  .read(mapControllerProvider.notifier)
                  .toggleSeguimientoUser(),
              icon: Icon(mapController.seguirUsuario
                  ? Icons.directions_run
                  : Icons.accessibility_new),
            )),
        // TODO Añadir marcador
        Positioned(
            bottom: 140,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () => ref.read(mapControllerProvider.notifier).addMarketCurrentPosition(),
              icon: const Icon(Icons.pin_drop),
            )),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);
    return GoogleMap(
      markers: mapController.marketSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLat, widget.initialLng), zoom: 12),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      onLongPress: (latLng) {
        ref
            .read(mapControllerProvider.notifier).addMarcador(latLng.latitude, latLng.longitude, 'Custom Marker');
            
      },
    );
  }
}
