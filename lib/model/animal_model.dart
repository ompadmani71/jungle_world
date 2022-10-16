import 'dart:convert';

List<Animal> animalFromJson(String str) => List<Animal>.from(json.decode(str).map((x) => Animal.fromJson(x)));
List<Animal> animalFromJsonDatabase(String str) => List<Animal>.from(json.decode(str).map((x) => Animal.fromJsonDatabase(x)));


class Animal {
  Animal({
    this.name,
    this.common_name,
    this.location,
    this.nesting_location,
    this.color,
    this.top_speed,
    this.weight,
    this.length,
    this.images_bytes
  });

  String? name;
  String? common_name;
  String? location;
  String? nesting_location;
  String? color;
  String? top_speed;
  String? weight;
  String? length;
  String? images_bytes;


  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
    name: json["name"],
    common_name: json["characteristics"]["common_name"],
    location: json["characteristics"]["location"],
    nesting_location: json["characteristics"]["nesting_location"],
    color: json["characteristics"]["color"],
    top_speed: json["characteristics"]["top_speed"],
    weight: json["characteristics"]["weight"],
    length: json["characteristics"]["length"],
  );
  factory Animal.fromJsonDatabase(Map<String, dynamic> json) => Animal(
    name: json["animal_name"],
    common_name: json["common_name"],
    location: json["location"],
    nesting_location: json["nesting_location"],
    color: json["color"],
    top_speed: json["top_speed"],
    weight: json["weight"],
    length: json["length"],
    images_bytes: json["image"]
  );
}
