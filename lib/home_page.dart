// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';
import 'package:pokedex_app/poke_api.dart';

import 'details_page.dart';
Map<String, Color> typeColors = {
  // Agrega más tipos y colores aquí
  'normal': Colors.grey,
  'fire': Colors.orange,
  'water': Colors.blue,
  'grass': Colors.green,
  'poison': const Color.fromRGBO(160, 64, 160, 1.0),
  'electric': Colors.yellow,
  'fighting': Colors.red,
  'flying': const Color.fromRGBO(168, 144, 240, 1.0),
  'bug': const Color.fromRGBO(168, 182, 32, 1.0),
  'ground': const Color.fromRGBO(224, 192, 104, 2.0),
  'fairy': Colors.pinkAccent,
  'psychic': const Color.fromRGBO(248, 88, 136, 1.0),
  'rock': const Color.fromRGBO(184, 160, 56, 1.0),
  'steel':const Color.fromRGBO(184, 184, 208, 1.0),
  'ice': const Color.fromARGB(255, 19, 189, 241),
  'ghost': const Color.fromARGB(255, 89, 27, 100),
  'dragon': const Color.fromRGBO(112, 56, 248, 1.0),
  
};
Map<String, IconData> typeIcons = {
  // Agrega más tipos y sus iconos aquí
  'normal': Icons.album_sharp,
  'fire': Icons.whatshot,
  'water': Icons.opacity,
  'grass': Icons.grass,
  'electric': Icons.offline_bolt ,
  'flying': Icons.air_sharp,
  'poison': Icons.dangerous,
  'bug': Icons.bug_report,
  'fairy': Icons.stars,
  'ground': Icons.terrain,
  'fighting': Icons.how_to_reg,
  'psychic': Icons.all_inclusive,
  'rock': Icons.filter_b_and_w,
  'steel': Icons.settings,
  'ghost': Icons.nightlight_round,
  'ice': Icons.blur_on,
  'dragon':Icons.fingerprint 
  
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonService _pokemonService = PokemonService();
  final List<Pokemon> _pokemonList = [];
  int _currentPage = 0;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

   @override
  void initState() {
    super.initState();
     _loadPokemonList();
    _scrollController.addListener(_onScroll);
  }
   @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
   void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMorePokemon();
    }
  } Future<void> _loadPokemonList() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      List<Pokemon> pokemonList = await _pokemonService.fetchPokemonList(
        page: _currentPage,
        pageSize: 20,
      );
      setState(() {
        _pokemonList.addAll(pokemonList);
        _isLoading = false;
      });
    } catch (e) {
      // Manejo de errores si ocurre algún problema al obtener la lista de Pokémon
      //print('Error al cargar la lista de Pokémon: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Ha ocurrido un error al cargar la lista de Pokémon.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> _loadMorePokemon() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      List<Pokemon> morePokemonList = await _pokemonService.fetchPokemonList(
        page: _currentPage + 1,
        pageSize: 20,
      );
      setState(() {
        _pokemonList.addAll(morePokemonList);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      //print('Error al cargar más Pokémon: $e');
      // Manejo de errores si ocurre algún problema al cargar más Pokémon
      setState(() {
        _isLoading = false;
      });
    }
  }

// función para capitalizar la primera letra de una cadena
String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1);
}
  Widget _buildPokemonCard(Pokemon pokemon) {
    //String type = pokemon.types.first.toLowerCase();
    //Color typeColor =  typeColors[type] ?? Colors.grey;
    //IconData typeIcon = typeIcons[type] ?? Icons.help_outline;

    List<String> pokemonTypes = pokemon.types.map((type) => type.toLowerCase()).toList();
    List<IconData> pokemonTypeIcons = pokemonTypes.map((type) => typeIcons[type] ?? Icons.help_outline).toList();
    List<Color> pokemonTypeColors = pokemonTypes.map((type) => typeColors[type] ?? Colors.grey).toList();

    return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(pokemon: pokemon),
        ),
      );
    },
     child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Asegura que el contenido se expanda horizontalmente
        children: [
         
            Expanded( // Utiliza el widget Expanded para que la imagen ocupe todo el espacio disponible verticalmente
              child: Image.network(
                  pokemon.imageUrl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
              ),
            ),
           
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              capitalizeFirstLetter(pokemon.name),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // Ajusta el tamaño de fuente del nombre
              ),
            ),

          ),
        
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Center(
              child: Wrap(
              alignment: WrapAlignment.center, // Alinea los chips al centro
              spacing: 4,
              children: List.generate(pokemonTypes.length, (index) {
                return Chip(
                  backgroundColor: pokemonTypeColors[index],
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                       pokemonTypeIcons[index],
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                       pokemonTypes [index].toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            ),
          ),
        ],
      ),
    ),
  );
}
 Widget _buildLoaderIndicator() {
    return const Center(
      child: CircularProgressIndicator(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Cambia para modificar las columnas
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              controller: _scrollController,
              itemCount: _pokemonList.length + (_isLoading ? 1 : 0), // +1 para el indicador de carga
              itemBuilder: (context, index) {
                if (index < _pokemonList.length) {
                  return _buildPokemonCard(_pokemonList[index]);
                } else if (_isLoading) {
                  return _buildLoaderIndicator();
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}