import 'package:miscelanius/domain/domain.dart';
import 'package:miscelanius/infrastructure/datasources/isa_local_db_datasrce.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDatasource _dataSource;

  LocalDbRepositoryImpl([LocalDbDatasource? datasource])
      : _dataSource = datasource ?? IsarLocalDbDatasource();

  @override
  Future<bool> insertPokemon(Pokemon pokemon) {
    return _dataSource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _dataSource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _dataSource.pokemonCount();
  }
}
