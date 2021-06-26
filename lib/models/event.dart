import 'package:jiffy/jiffy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../utility/hiveConstants.dart';

part 'event.g.dart';

@HiveType(typeId: HiveTypes.EVENT)
class Event {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int countryId;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String dateHappening;
  @HiveField(5)
  String subheader;

  Event({
    required this.id,
    required this.name,
    required this.countryId,
    required this.imageUrl,
    required this.dateHappening,
    required this.subheader,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      subheader: json['subheader'],
      countryId: json['country_id'],
      imageUrl: json['image_url'],
      dateHappening: json["date_happening"],
    );
  }
}
