import 'package:jiffy/jiffy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../utility/hiveConstants.dart';

part 'community.g.dart';

@HiveType(typeId: HiveTypes.COMMUNITY)
class Community {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int countryId;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  List<String> interestTags;
  @HiveField(5)
  String subheader;

  Community({
    required this.id,
    required this.name,
    required this.countryId,
    required this.imageUrl,
    required this.interestTags,
    required this.subheader,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'],
      name: json['name'],
      subheader: json['subheader'],
      countryId: json['country_id'],
      imageUrl: json['image_url'],
      interestTags: List<String>.from(json['interest_tags'].map((e) => e)),
    );
  }
}
