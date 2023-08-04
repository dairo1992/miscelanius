import 'package:miscelanius/config/infrastructure/datasources/pokemons_datasource_impl.dart';
import 'package:miscelanius/domain/domain.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDataSource dataSource;

  PokemonRepositoryImpl({PokemonDataSource? dataSource})
      : dataSource = dataSource ?? PokemonDataSourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return dataSource.getPokemon(id);
  }
}
