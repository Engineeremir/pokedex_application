import 'package:flutter/material.dart';
import 'package:pokedex/models/pokedex.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/view/pokemon_detail.dart';


class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late Pokedex pokedex;
  late Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);
    print(decodedJson);
    return Pokedex.fromSnapshot(decodedJson);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder<Pokedex>(
        future: veri,
        builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
          if (!gelenPokedex.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.count(
              crossAxisCount: 2,
              children: gelenPokedex.data!.pokemon.map((poke) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PokemonDetail(pokemon: poke,)));
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      elevation: 6,
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: FadeInImage.assetNetwork(placeholder: "assets/images/loading.gif", image: poke.img),
                          ),
                          Text(poke.name, style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                );
              }).toList());

        },
      ),
    );
  }
}
