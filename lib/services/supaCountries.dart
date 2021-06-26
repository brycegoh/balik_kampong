import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/country.dart';

class SupaCountries {
  static Future<dynamic> getCountries() async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('countries').select();

    PostgrestResponse response = await query.execute();
    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Country> container = data.map<Country>((e) {
        return Country.fromJson(e);
      }).toList();
      return container;
    }
  }
}
