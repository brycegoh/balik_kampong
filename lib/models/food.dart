import 'package:jiffy/jiffy.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Food {
  int id;
  String name;
  int countryId;
  String imageUrl;
  List<String> interestTags;

  Food({
    required this.id,
    required this.name,
    required this.countryId,
    required this.imageUrl,
    required this.interestTags,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
      imageUrl: json['image_url'],
      interestTags: List<String>.from(json['interest_tags'].map((e) => e)),
    );
  }
}
