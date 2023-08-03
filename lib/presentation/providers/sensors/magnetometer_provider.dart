import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnometerXYZ {
  final double x;
  final double y;
  final double z;

  MagnometerXYZ(this.x, this.y, this.z);

  @override
  String toString() {
    return '''
            x:$x,
            y:$y,
            z:$z
          ''';
  }
}

final magnetometerProvider = StreamProvider.autoDispose<MagnometerXYZ>((ref) async* {
  await for (final event in magnetometerEvents) {
    final double x = double.parse(event.x.toStringAsFixed(2));
    final double y = double.parse(event.y.toStringAsFixed(2));
    final double z = double.parse(event.z.toStringAsFixed(2));
    yield MagnometerXYZ(x, y, z);
  }
});
