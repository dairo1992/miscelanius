import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/config/infrastructure/repositories/pokemons_reotory_imp.dart';
import 'package:miscelanius/domain/domain.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch(pokemonRepositoryProvider);
  final (pokemon, error) = await pokemonRepository.getPokemon(id);
  if (pokemon != null) return pokemon;
  throw error;
});
