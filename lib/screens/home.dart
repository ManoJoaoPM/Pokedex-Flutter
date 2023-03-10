import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/pokeapi.dart';
import '../models/PokemonModel.dart';
import '../widgets/pokemon_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Pokemon> pokemon = List.empty();

  @override
  void initState() {
    super.initState();
    getPokemonFromPokeApi();
  }

  void getPokemonFromPokeApi() async {
    PokeAPI.getPokemon().then((response) {
      List<Map<String, dynamic>> data =
          List.from(json.decode(response.body)['results']);
      setState(() {
        pokemon = data.asMap().entries.map<Pokemon>((element) {
          element.value['id'] = element.key + 1;
          element.value['img'] =
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
          return Pokemon.fromJson(element.value);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width > 1000)
        ? 5
        : (width > 700)
            ? 4
            : (width > 450)
                ? 3
                : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/liked",
                  );
                },
                child: const Icon(
                  Icons.list,
                  size: 26.0,
                )),
          )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(7),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200 / 244,
        physics: const BouncingScrollPhysics(),
        children: pokemon
            .map(
              (pokemon) => PokemonCard(
                id: pokemon.id,
                name: pokemon.name,
                image: pokemon.img,
              ),
            )
            .toList(),
      ),
    );
  }
}
