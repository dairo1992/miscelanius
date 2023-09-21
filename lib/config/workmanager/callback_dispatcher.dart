import 'package:miscelanius/infrastructure/datasources/pokemons_datasource_impl.dart';
import 'package:miscelanius/infrastructure/repositories/local_db_repositrory_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    "com.ingdairo.miscelanius.fetch-background-pokemon";
const fetchPeriodicBackgroundTaskKey =
    "com.ingdairo.miscelanius.fetch-Periodic-background-pokemon";

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextpokemon();
        break;

      case fetchPeriodicBackgroundTaskKey:
        await loadNextpokemon();
        break;
    }
    return true;
  });
}

Future loadNextpokemon() async {
  final localDbReposity = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonDataSourceImpl();
  final lastpokemonId = await localDbReposity.pokemonCount() + 1;
  try {
    final (pokemon, message) =
        await pokemonRepository.getPokemon("$lastpokemonId");
    if (pokemon == null) throw message;
    await localDbReposity.insertPokemon(pokemon);
    print("pokemon insertado ${pokemon.name}");
  } catch (e) {
    print("Catch $e");
  }
}
