import 'package:postgrest/postgrest.dart';
import 'package:postgrest/src/text_search_type.dart';
import 'package:postgrest/src/count_option.dart';
import 'package:jiffy/jiffy.dart';

import './supaClient.dart';
import '../models/event.dart';

class SupaEvents {
  static Future<dynamic> getLatestEvents(int? countryId) async {
    Jiffy dateNow = Jiffy();
    Jiffy oneMonthLater = dateNow.add(months: 1);

    PostgrestFilterBuilder query = SupaClient.supaBaseClient
        .from('events')
        .select()
        .gt("date_happening", dateNow.format())
        .lte("date_happening", oneMonthLater.format());

    if (countryId != null) {
      query = query.eq("country_id", countryId);
    }

    PostgrestResponse response = await query.execute();

    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Event> container = data.map<Event>((e) {
        return Event.fromJson(e);
      }).toList();
      return container;
    }
  }

  static Future<dynamic> getAllEvents({int? countryId, String? search}) async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('events').select();

    if (countryId != null) {
      query = query.eq("country_id", countryId);
    }

    if (search != null && search.trim().length > 0) {
      query = query.ilike('name', '%$search%');
    }

    PostgrestResponse response = await query
        .eq("event_finished", false)
        .order("date_happening", ascending: true)
        .execute();

    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Event> container = data.map<Event>((e) {
        return Event.fromJson(e);
      }).toList();
      return container;
    }
  }

  static Future<dynamic> getNumOFParticipantsPerEvents({int? eventId}) async {
    PostgrestFilterBuilder query = SupaClient.supaBaseClient
        .from('users')
        .select()
        .overlaps("participating_events", [eventId]);

    PostgrestResponse response = await query.execute(count: CountOption.exact);

    if (response.error == null) {
      return response.count;
    } else {
      return 0;
    }
  }
}
