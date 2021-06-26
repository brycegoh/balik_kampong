import 'package:supabase/supabase.dart';
import 'package:postgrest/postgrest.dart';
import 'package:jiffy/jiffy.dart';
import 'package:gotrue/src/gotrue_client.dart';

import 'secrets.dart';
import '../models/country.dart';
import '../models/community.dart';
import '../models/event.dart';
import '../models/interest.dart';
import '../models/user.dart';
import '../utility/secureStorage.dart';

class SupaClient {
  static final SupabaseClient supaBaseClient =
      SupabaseClient(SUPABASE_URL, SUPABASE_KEY, autoRefreshToken: true);

  static String getPersistentString() {
    return supaBaseClient.auth.currentSession!.persistSessionString;
  }
}
