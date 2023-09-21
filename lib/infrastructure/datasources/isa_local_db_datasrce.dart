import 'package:isar/isar.dart';
import 'package:miscelanius/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDatasource extends LocalDbDatasource {
  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final directory = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema], directory: directory.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> insertPokemon(Pokemon pokemon) async {
    final isar = await db;
    final resp = isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));
    print("insert done: $resp");
    return true;
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isar = await db;
    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;
    return isar.pokemons.count();
  }
}
