import 'package:go_router/go_router.dart';
import 'package:miscelanius/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen()),
  GoRoute(
      path: '/acelerometer',
      builder: (context, state) => const AcelerometerScreen()),
  GoRoute(path: '/compass', builder: (context, state) => const CompassScreen()),
  GoRoute(
      path: '/gyroscope-Ball',
      builder: (context, state) => const GyroscopeBallScreen()),
  GoRoute(
      path: '/gyroscope', builder: (context, state) => const GyroscopeScreen()),
  GoRoute(
      path: '/magnetometer',
      builder: (context, state) => const MagnetometerScreen()),
  GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonsScreen(),
      routes: [
        GoRoute(
            path: ':id',
            builder: (context, state) {
              final pokemonId = state.pathParameters['id'] ?? '1';
              return PokemonScreen(
                pokemonId: pokemonId,
              );
            })
      ]),
  GoRoute(
      path: '/Biometricos',
      builder: (context, state) => const BiometricScreen()),
  GoRoute(
      path: '/Controlled-map',
      builder: (context, state) => const ControlledMapScreen()),
  GoRoute(
      path: '/Location',
      builder: (context, state) => const LocationScreen()),
  GoRoute(
      path: '/Maps',
      builder: (context, state) => const MapScreen()),
  GoRoute(
      path: '/badge',
      builder: (context, state) => const BadgeScreen()),
]);
