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

  static RealtimeSubscription subscribeToTable({
    required String table,
    required Function onInsert,
    Function? delete,
    Function? onUpdate,
  }) {
    RealtimeSubscription chatSubscription =
        supaBaseClient.from(table).on(SupabaseEventTypes.insert, (payload) {
      switch (payload.eventType) {
        case 'INSERT':
          onInsert(newRecord: payload.newRecord);
          break;
      }
    }).subscribe((String event, {String? errorMsg}) {
      print('$table ----event: $event error: $errorMsg');
    });
    return chatSubscription;
  }

  static void removeSub(RealtimeSubscription sub) {
    supaBaseClient.realtime.remove(sub);
  }
}
