import 'dart:convert';




class Pokedex {
  List<Pokemon> pokemon;

  Pokedex({
    required this.pokemon,
  });





  factory Pokedex.fromSnapshot(Map<String,dynamic> data){
    return Pokedex(pokemon: List.generate(data['pokemon'].length, (index) => Pokemon.fromJson(data["pokemon"][index])));
  }
}



class Pokemon {
  var id;
  var num;
  var name;
  var img;
  var type;
  var height;
  var weight;
  var candy;
  var candyCount;
  var egg;
  var spawnChance;
  var avgSpawns;
  var spawnTime;
  var multipliers;
  var weaknesses;
  var nextEvolution;
  var prevEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {


      try{
        return Pokemon(
          id: json["id"],
          num: json["num"],
          name: json["name"],
          img: json["img"],
          type:  List.generate(json['type'].length, (index) => json['type'][index]),
          height: json["height"],
          weight: json["weight"],
          candy: json["candy"],
          candyCount: json["candy_count"],
          egg: json["egg"],
          spawnChance: json["spawn_chance"],
          avgSpawns: json["avg_spawns"] ,
          spawnTime: json["spawn_time"],
          multipliers: json["multipliers"] == null ? [] : List.generate(json["multipliers"].length, (index) => json['multipliers'][index]),
          weaknesses: List.generate(json["weaknesses"].length, (index) => json["weaknesses"][index]),
          nextEvolution: json["next_evolution"] == null ? [] :  List.generate(json["next_evolution"].length, (index) => Evolution.fromJson(json['next_evolution'][index])),
          prevEvolution: json["prev_evolution"] == null ? [] : List.generate(json["prev_evolution"].length, (index) => Evolution.fromJson(json['prev_evolution'][index])),
        );
      }
      catch(e){
        print(e);
        return Pokemon(
          id: json["id"],
          num: json["num"],
          name: json["name"],
          img: json["img"],
          type: [], // List.generate(json['type'].length, (index) => json['type'][index]),
          height: json["height"],
          weight: json["weight"],
          candy: json["candy"],
          candyCount: json["candy_count"],
          egg: json["egg"],
          spawnChance: json["spawn_chance"],
          avgSpawns: json["avg_spawns"] ,
          spawnTime: json["spawn_time"],
          multipliers: [], // List.generate(json["multipliers"].length, (index) => json['multipliers'][index])
          weaknesses:[], // List.generate(json["weaknesses"].length, (index) => json["weaknesses"][index]),
          nextEvolution: [],//  List.generate(json["next_evolution"].length, (index) => Evolution.fromJson(json['next_evolution'][index])),
          prevEvolution: [],// List.generate(json["prev_evolution"].length, (index) => Evolution.fromJson(json['prev_evolution'][index])),
        );
      }
    }




}

class Evolution {
  String? num;
  String? name;

  Evolution({
    required this.num,
    required this.name,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) =>  Evolution(
    num: json["num"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "num": num,
    "name": name,
  };
}