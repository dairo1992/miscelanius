import 'package:go_router/go_router.dart';
import 'package:miscelanius/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(path: '/permissions', builder: (context, state) => const PermissionsScreen()),

  GoRoute(path: '/acelerometer', builder: (context, state) => const AcelerometerScreen()),
  GoRoute(path: '/compass', builder: (context, state) => const CompassScreen()),
  GoRoute(path: '/gyroscope-Ball', builder: (context, state) => const GyroscopeBallScreen()),
  GoRoute(path: '/gyroscope', builder: (context, state) => const GyroscopeScreen()),
  GoRoute(path: '/magnetometer', builder: (context, state) => const MagnetometerScreen()),
]);






