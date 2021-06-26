import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/community.dart';

class SupaCommunities {
  static Future<dynamic> getCommunities(
      int? countryId, List<String>? interests) async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('communities').select();

    if (countryId != null) {
      query = query.eq("country_id", countryId);
    }

    if (interests != null) {
      query = query.overlaps("interest_tags", interests);
    }

    PostgrestResponse response = await query.execute();
    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Community> container = data.map<Community>((e) {
        return Community.fromJson(e);
      }).toList();
      return container;
    }
  }

  static Future<dynamic> getAllCommunities(
      {int? countryId, String? search, List<String>? listOfTags}) async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('communities').select();

    if (countryId != null) {
      query = query.eq("country_id", countryId);
    }

    if (search != null && search.trim().length > 0) {
      query = query.ilike('name', '%$search%');
    }

    if (listOfTags != null && listOfTags.length > 0) {
      query = query.overlaps("interest_tags", listOfTags);
    }

    PostgrestResponse response = await query.execute();

    if (response.error == null) {
      List<dynamic> data = response.data;
      List<Community> container = data.map<Community>((e) {
        return Community.fromJson(e);
      }).toList();
      return container;
    }
  }

  static Future<dynamic> getNumOFParticipantsPerCommunity(
      {int? communityId}) async {
    PostgrestFilterBuilder query = SupaClient.supaBaseClient
        .from('users')
        .select()
        .overlaps("participating_communities", [communityId]);

    PostgrestResponse response = await query.execute(count: CountOption.exact);

    if (response.error == null) {
      return response.count;
    } else {
      return 0;
    }
  }
}
