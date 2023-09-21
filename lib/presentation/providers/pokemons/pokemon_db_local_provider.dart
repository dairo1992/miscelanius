import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/domain/domain.dart';
import 'package:miscelanius/infrastructure/infrastructure.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();
  return pokemons;
});
