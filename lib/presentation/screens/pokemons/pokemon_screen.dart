import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelanius/domain/domain.dart';
import 'package:miscelanius/presentation/config.dart';
import 'package:miscelanius/presentation/providers/providers.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonId;
  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));
    return pokemonAsync.when(
        data: (data) => _PokemonView(
              pokemon: data,
            ),
        error: (error, stackTrace) => _ErrorWidget(message: error.toString()),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
              onPressed: () {
            //          SharePlugin.shareLink(
            //   'https://pokemon-deep-linking.up.railway.app/pokemons/${ pokemon.id }/', 
            //   'Mira este pókmeon'
            // );
                SharePlugin.shareLink(link: "https://ingdairo.website/pokemons/${pokemon.id}/", subject: "Mira este pokemon");
              },
              icon: const Icon(Icons.share_outlined))
        ],
      ),
      body: Center(
        child: Image.network(
          pokemon.spriteFront,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
