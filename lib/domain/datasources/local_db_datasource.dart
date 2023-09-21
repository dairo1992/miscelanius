import 'package:miscelanius/domain/domain.dart';

abstract class LocalDbDatasource {
  Future<List<Pokemon>> loadPokemons();
  Future<int> pokemonCount();
  Future<bool> insertPokemon(Pokemon pokemon);
}
