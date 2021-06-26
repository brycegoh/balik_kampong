import 'package:jiffy/jiffy.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utility/hiveConstants.dart';

part 'country.g.dart';

// class Event {

//   Event();

//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(

//       id: json['id'],

//       startDatetime: Jiffy(json["start_datetime"]).dateTime,

//       forms: List<DynamicForm>.from(
//           json["forms"].map((value) => DynamicForm.fromJson(value))),

//     );
//   }
// }
@HiveType(typeId: HiveTypes.COUNTRIES)
class Country {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}
