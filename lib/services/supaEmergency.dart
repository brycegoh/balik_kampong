import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/emergency.dart';

class SupaEmergency {
  static Future<dynamic> getEmergency(int countryId) async {
    PostgrestFilterBuilder query = SupaClient.supaBaseClient
        .from('emergency')
        .select()
        .eq("country_id", countryId);

    PostgrestResponse response = await query.execute();

    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Emergency> container = data.map<Emergency>((e) {
        return Emergency.fromJson(e);
      }).toList();
      return container;
    }
  }
}
