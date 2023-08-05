import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelanius/presentation/providers/providers.dart';


class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationAsync = ref.watch(userlocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("MapScreen"),
      ),
      body: locationAsync.when(data: (data)=>_MapView(initialLat: data.$1, initialLng: data.$2,), error: (error, stackTrace) => Text("$error"), loading: ()=> const Center(child: CircularProgressIndicator.adaptive(),)),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(widget.initialLat, widget.initialLng), zoom: 12),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
        },
      );
  }
}