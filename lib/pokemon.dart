
class Ability {
  final String name;
  final String description;

  Ability({
    required this.name,
    required this.description,
  });
}

class Stat {
  final String name;
  final int baseValue;

  Stat({
    required this.name,
    required this.baseValue,
  });
}

class Move {
  final String name;
  final String type;
  final int power;
  final int accuracy;
  final int pp;

  Move({
    required this.name,
    required this.type,
    required this.power,
    required this.accuracy,
    required this.pp,
  });
}
class Evolution {
  final String name;
  final String imageUrl;

  Evolution({
    required this.name,
    required this.imageUrl,
  });
}

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final int baseExperience;
  final List<Ability> abilities;
  final List<String> types;
  final List<Stat> stats;
  final List<Move> moves;
  


  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.abilities,
    required this.types,
    required this.stats,
    required this.moves,

  });
}


