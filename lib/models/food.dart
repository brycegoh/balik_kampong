import 'package:jiffy/jiffy.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Food {
  int id;
  String name, foodName, location;
  int countryId;
  String imageUrl;
  List<String> interestTags;

  Food({
    required this.id,
    required this.name,
    required this.countryId,
    required this.imageUrl,
    required this.interestTags,
    required this.foodName,
    required this.location,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
      imageUrl: json['image_url'],
      interestTags: List<String>.from(json['interest_tags'].map((e) => e)),
      foodName: json["food_name"],
      location: json["location"],
    );
  }
}
