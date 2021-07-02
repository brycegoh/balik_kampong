import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/banner.dart' as ban;

class SupaBanner {
  static Future<dynamic> getBanners() async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('banners').select();

    PostgrestResponse response = await query.execute();

    if (response.error == null) {
      List<dynamic> data = response.data;
      List<ban.Banner> container = data.map<ban.Banner>((e) {
        return ban.Banner.fromJson(e);
      }).toList();
      return container;
    }
  }
}
