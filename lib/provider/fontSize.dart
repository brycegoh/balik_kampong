import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';

import '../models/user.dart';
import '../utility/secureStorage.dart';
import '../services/supaClient.dart';
import '../services/supaAuth.dart';
import '../services/supaUser.dart';
import '../../utility/constants.dart';

class FontProvider with ChangeNotifier {
  late double multiplier = 1.0;

  Map<String, double> multi = {
    "LARGE": 1.4,
    "MEDIUM": 1.2,
    "SMALL": 0.8,
    "DEFAULT": 1.0
  };

  void setMultiplier(double settings) {
    multiplier = settings;
    notifyListeners();
  }
}
