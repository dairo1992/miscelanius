import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool seguirUsuario;
  final List<Marker> marcadores;
  final GoogleMapController? controller;

  MapState(
      {this.isReady = false,
      this.seguirUsuario = false,
      this.marcadores = const [],
      this.controller});

  Set<Marker> get marketSet {
    return Set.from(marcadores);
  }

  MapState copyWith({
    bool? isReady,
    bool? seguirUsuario,
    List<Marker>? marcadores,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      seguirUsuario: seguirUsuario ?? this.seguirUsuario,
      marcadores: marcadores ?? this.marcadores,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocationSuscription;
  (double, double)? lastKnowLocation;
  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnowLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  goToLocation(double lat, double lng) {
    final newposition = CameraPosition(target: LatLng(lat, lng), zoom: 17);
    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newposition));
  }

  toggleSeguimientoUser() {
    state = state.copyWith(seguirUsuario: !state.seguirUsuario);
    if (state.seguirUsuario) {
      findUser();
      userLocationSuscription = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocationSuscription?.cancel();
    }
  }

  findUser() {
    if (lastKnowLocation == null) return;
    final (latitude, longitude) = lastKnowLocation!;
    goToLocation(latitude, longitude);
  }

  void addMarketCurrentPosition() {
    if (lastKnowLocation == null) return;
    final (latitude, longitude) = lastKnowLocation!;
    
    addMarcador(latitude, longitude, "Por aqui paso el usuario");
  }

  void addMarcador(double lat, double lng, String name) {
    final newmarker = Marker(
        markerId: MarkerId("${state.marcadores.length}"),
        position: LatLng(lat, lng),
        infoWindow:
            InfoWindow(title: name, snippet: "Por aqui paso el usuario"));
    state = state.copyWith(marcadores: [...state.marcadores, newmarker]);
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
