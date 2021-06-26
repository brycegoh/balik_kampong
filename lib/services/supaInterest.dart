import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/interest.dart';

class SupaInterest {
  static Future<dynamic> getInterests() async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('interests').select();

    PostgrestResponse response = await query.execute();
    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Interest> container = data.map<Interest>((e) {
        return Interest.fromJson(e);
      }).toList();
      return container;
    }
  }
}
