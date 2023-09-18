import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';

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

class DetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  const DetailsPage({super.key, required this.pokemon});

  String capitalize(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
  Color getColorForStat(int value) {
  // Aquí puedes definir las reglas para asignar colores según el valor
  if (value >= 100) {
    return Colors.green;
  } else if (value >= 50) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(pokemon.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  pokemon.imageUrl,
                  height: 220,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon.types.isNotEmpty
                    ? pokemon.types
                        .map(
                          (type) => Chip(
                            label: Text(capitalize(type)),
                            backgroundColor: typeColors[type], //assingar color
                            avatar: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(typeIcons[type]), //asignar Icono
                            ),
                          ),
                        )
                        .toList()
                    : [const Text('No hay tipos disponibles')],
              ),
              ),

              
              const SizedBox(height: 16),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'About'),
                        Tab(text: 'Base Stats'),
                        Tab(text: 'Evolution'),
                      ],
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 300,
                      child: TabBarView(
                        children: [
                          // Pestaña "About"
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Contenido para la pestaña "About"
                                  Text(
                                    'Altura: ${(pokemon.height / 10) * 100} cm',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Peso: ${pokemon.weight / 10} kg',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Experiencia base: ${pokemon.baseExperience}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Habilidades:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: pokemon.abilities.isNotEmpty
                                        ? pokemon.abilities
                                            .map(
                                              (ability) => ListTile(
                                                title: Text(
                                                    capitalize(ability.name)),
                                                // No mostramos el enlace de la descripción de la habilidad
                                              ),
                                            )
                                            .toList()
                                        : [
                                            const Text(
                                                'No hay habilidades disponibles')
                                          ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),                          
                          // Pestaña "Base Stats"
                           SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Contenido para la pestaña "Base Stats"
                                  const Text(
                                    'Estadísticas:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    children: pokemon.stats.isNotEmpty
                                        ? pokemon.stats
                                            .map(
                                              (stat) => Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                        capitalize(stat.name) +
                                                            ": " +
                                                            "${stat.baseValue}"),
                                                    //subtitle: Text('Base: ${stat.baseValue}'),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 6,
                                                        width: 400,
                                                        color: Colors.grey,
                                                      ),
                                                      Container(
                                                        height: 6,
                                                        width: (stat.baseValue/100) * 400,
                                                        color: getColorForStat(stat.baseValue),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList()
                                        : [
                                            const Text(
                                              'No hay estadísticas disponibles',
                                            )
                                          ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),

                          
                          // Pestaña "Evolution"
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Contenido para la pestaña "Evolution"
                                  const Text(
                                    'Evolucion',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
