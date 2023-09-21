import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/config/config.dart';
import 'package:miscelanius/domain/domain.dart';
import 'package:miscelanius/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

class DbPokemonsScreen extends ConsumerWidget {
  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonsAsync = ref.watch(pokemonDbProvider);
    final isBackgroundFetchActive = ref.watch(backgrounPokemonFetchProvider);
    if (pokemonsAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Backgroun Process"),
        actions: [
          IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(
                    fetchBackgroundTaskKey, fetchBackgroundTaskKey,
                    initialDelay: const Duration(seconds: 3),
                    inputData: {"howMany": 30});
              },
              icon: const Icon(Icons.add_alarm_sharp))
        ],
      ),
      body: CustomScrollView(slivers: [
        _PokemonsGrid(
          pokemons: pokemons,
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgrounPokemonFetchProvider.notifier).toggleProcess();
        },
        label: (isBackgroundFetchActive == true)
            ? const Text("Activar Fetch Periodico")
            : const Text("Desactivar Fetch Periodico"),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonsGrid extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokemonsGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Column(
          children: [
            Image.network(
              pokemon.spriteFront,
              fit: BoxFit.contain,
            ),
            Text(pokemon.name)
          ],
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
    );
  }
}
