import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './hiveConstants.dart';
import '../models/country.dart';
import '../models/community.dart';
import '../models/event.dart';

class HiveBox {
  static Future initHive() async {
    await Hive.initFlutter();
    registerAdapter();
    await deleteBoxes();
    await openBoxes();
  }

  static openBoxes() async {
    await Hive.openBox<Country>(HiveBoxes.countries);
    await Hive.openBox<Community>(HiveBoxes.community);
    await Hive.openBox<Event>(HiveBoxes.event);
    await Hive.openBox<String>("SESSION");
  }

  static deleteBoxes() async {
    await Hive.deleteBoxFromDisk(HiveBoxes.countries);
    await Hive.deleteBoxFromDisk(HiveBoxes.community);
    await Hive.deleteBoxFromDisk(HiveBoxes.event);
  }

  static registerAdapter() {
    Hive.registerAdapter(CountryAdapter());
    Hive.registerAdapter(CommunityAdapter());
    Hive.registerAdapter(EventAdapter());
  }
}
