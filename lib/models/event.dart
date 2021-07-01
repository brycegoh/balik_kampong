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
  @HiveField(6)
  String location;
  @HiveField(7)
  String endDate;
  @HiveField(8)
  String eventType;
  @HiveField(9)
  int hostId;
  @HiveField(10)
  String hostName;
  @HiveField(11)
  String? hostContact;
  @HiveField(12)
  String? livestreamURL;

  Event({
    required this.id,
    required this.name,
    required this.countryId,
    required this.imageUrl,
    required this.dateHappening,
    required this.subheader,
    required this.location,
    required this.endDate,
    required this.eventType,
    required this.hostId,
    required this.hostName,
    this.livestreamURL = "",
    this.hostContact,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      subheader: json['subheader'],
      countryId: json['country_id'],
      imageUrl: json['image_url'],
      dateHappening: json["date_happening"],
      livestreamURL:
          json.containsKey('livestream_url') ? json["livestream_url"] : null,
      location: json['location'],
      endDate: json['ending_date'],
      eventType: json['event_type'],
      hostId: json["user_id"],
      hostName: json["host_name"],
    );
  }
}
