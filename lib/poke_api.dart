import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/pokemon.dart';


class PokemonService {
  static const String apiUrl = 'https://pokeapi.co/api/v2/pokemon/';
  final int totalPokemons = 151;  // Total de Pokémon en la Pokédex
  
Future<List<Pokemon>> fetchPokemonList({int page = 0, int pageSize = 20}) async {
  if(page * pageSize >= totalPokemons){
    return[];
  }
  
  final response = await http.get(Uri.parse('$apiUrl?offset=${page * pageSize}&limit=$pageSize'));
 if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      final List<Pokemon> pokemonList = [];
      for (final result in results) {
        final pokemonUrl = result['url'];
        final pokemonResponse = await http.get(Uri.parse(pokemonUrl));
        if (pokemonResponse.statusCode == 200) {
          final pokemonData = jsonDecode(pokemonResponse.body);
          final pokemon = Pokemon(
            id: pokemonData['id'],
            name: pokemonData['name'],
            imageUrl: pokemonData['sprites']['front_default'],
            height: pokemonData['height'],
            weight: pokemonData['weight'],
            baseExperience: pokemonData['base_experience'],
            abilities: (pokemonData['abilities'] as List<dynamic>)
                .map((abilityData) => Ability(
                      name: abilityData['ability']['name'],
                      description: abilityData['ability']['url'],
                    ))
                .toList(),
            types: List<String>.from((pokemonData['types'] as List<dynamic>).map((typeData) => typeData['type']['name'])),
            stats: (pokemonData['stats'] as List<dynamic>)
                .map((statData) => Stat(
                      name: statData['stat']['name'],
                      baseValue: statData['base_stat'],
                    ))
                .toList(),
            moves: (pokemonData['moves'] as List<dynamic>)
                .map((moveData) => Move(
                      name: moveData['move']['name'],
                      type: moveData['move']['name'],
                      power: moveData['power'] ?? 0,
                      accuracy: moveData['accuracy'] ?? 0,
                      pp: moveData['pp'] ?? 0,
                    ))
                .toList(),
          );
          pokemonList.add(pokemon);
        }
      }
      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }
  
  
  Future<Pokemon> fetchPokemonDetails(int id, pokemonName) async {
    final response = await http.get(Uri.parse('$apiUrl$id/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final abilities = (data['abilities'] as List<dynamic>)
          .map((abilityData) => Ability(
                name: abilityData['ability']['name'],
                description: abilityData['ability']['url'],
              ))
          .toList();

      final types = (data['types'] as List<dynamic>)
          .map((typeData) => typeData['type']['name'].toString())
          .toList();

      final stats = (data['stats'] as List<dynamic>)
          .map((statData) => Stat(
                name: statData['stat']['name'],
                baseValue: statData['base_stat'],
              ))
          .toList();

      final moves = (data['moves'] as List<dynamic>)
          .map((moveData) => Move(
                name: moveData['move']['name'],
                type: moveData['version_group_details'][0]['move_learn_method']['name'],
                power: moveData['power'] ?? 0,
                accuracy: moveData['accuracy'] ?? 0,
                pp: moveData['pp'] ?? 0,
              ))
          .toList();

      final pokemon = Pokemon(
        id: data['id'],
        name: data['name'],
        imageUrl: data['sprites']['front_default'],
        height: data['height'],
        weight: data['weight'],
        baseExperience: data['base_experience'],
        abilities: abilities,
        types: types,
        stats: stats,
        moves: moves,
      );

      return pokemon;
    } else {
      throw Exception('Failed to load Pokemon details');
    }
  }
  
}