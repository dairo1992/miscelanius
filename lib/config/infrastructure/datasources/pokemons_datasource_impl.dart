import 'package:dio/dio.dart';
import 'package:miscelanius/config/infrastructure/mappers/pokemon_mapper.dart';
import 'package:miscelanius/domain/domain.dart';

class PokemonDataSourceImpl implements PokemonDataSource {
  final Dio dio;
  PokemonDataSourceImpl()
      : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);
      return (pokemon, "Data obtenida correctamente");
    } catch (e) {
      return (null, "No se pudo obtener el pokemon $e");
    }
  }
}
