import 'package:flutter/material.dart';
import 'package:pokedex_app/home_page.dart'; // Asegúrate de importar el archivo home_page.dart
import 'package:pokedex_app/details_page.dart';
import 'package:pokedex_app/pokemon.dart';

void main() {
 runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // Cambiar a una función que reciba el argumento Pokemon
        '/details': (context) => DetailsPage(pokemon: ModalRoute.of(context)!.settings.arguments as Pokemon),
      },
    );
  }
}