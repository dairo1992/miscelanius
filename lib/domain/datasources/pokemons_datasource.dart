import 'package:miscelanius/domain/domain.dart';

abstract class PokemonDataSource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
