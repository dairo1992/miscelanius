import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState()) {
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final permisssionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);
    state = state.copyWith(
      camera: permisssionsArray[0],
      photosLibrary: permisssionsArray[1],
      sensors: permisssionsArray[2],
      location: permisssionsArray[3],
      locationAlways: permisssionsArray[4],
      locationWhenInUser: permisssionsArray[5],
    );
  }

  openSettings() {
    openAppSettings();
  }

  void _checkPermissionState(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestCameraAcess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);
  }

  requestPhotosLibraryAcess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photosLibrary: status);
    _checkPermissionState(status);
  }

  requestSensorsAcess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);
    _checkPermissionState(status);
  }

  requestLocationAcess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);
    _checkPermissionState(status);
  }

  requestLocationAlwaysAcess() async {
    final status = await Permission.locationAlways.request();
    state = state.copyWith(locationAlways: status);
    _checkPermissionState(status);
  }

  requestLocationWhenInUserAcess() async {
    final status = await Permission.locationWhenInUse.request();
    state = state.copyWith(locationWhenInUser: status);
    _checkPermissionState(status);
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photosLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUser;

  PermissionsState(
      {this.camera = PermissionStatus.denied,
      this.photosLibrary = PermissionStatus.denied,
      this.sensors = PermissionStatus.denied,
      this.location = PermissionStatus.denied,
      this.locationAlways = PermissionStatus.denied,
      this.locationWhenInUser = PermissionStatus.denied});

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get photosLibraryGranted {
    return photosLibrary == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUserGranted {
    return locationWhenInUser == PermissionStatus.granted;
  }

  copyWith({
    PermissionStatus? camera,
    PermissionStatus? photosLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUser,
  }) =>
      PermissionsState(
          camera: camera ?? this.camera,
          photosLibrary: photosLibrary ?? this.photosLibrary,
          sensors: sensors ?? this.sensors,
          location: location ?? this.location,
          locationAlways: locationAlways ?? this.locationAlways,
          locationWhenInUser: locationWhenInUser ?? this.locationWhenInUser);
}
