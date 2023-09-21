import 'package:miscelanius/domain/domain.dart';

abstract class LocalDbRepository {
  Future<List<Pokemon>> loadPokemons();
  Future<int> pokemonCount();
  Future<bool> insertPokemon(Pokemon pokemon);
}
