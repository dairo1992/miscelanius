import 'package:miscelanius/config/infrastructure/models/pokemonResponse.dart';
import 'package:miscelanius/domain/domain.dart';

class PokemonMapper {
  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokemonResponse.fromJson(json);
    return Pokemon(
        id: pokeApiPokemon.id,
        name: pokeApiPokemon.name,
        spriteFront: pokeApiPokemon.sprites.frontDefault);
  }
}
