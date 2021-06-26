import 'package:postgrest/postgrest.dart';

import './supaClient.dart';

class SupaUser {
  static Future<PostgrestResponse> getUser() async {
    var userResponse = await SupaClient.supaBaseClient
        .from('users')
        .select()
        .eq("auth_id", SupaClient.supaBaseClient.auth.currentUser!.id)
        .execute();
    return userResponse;
  }

  static Future<Map<String, dynamic>?> getUserById(id) async {
    Map<String, dynamic>? container;
    var userResponse = await SupaClient.supaBaseClient
        .from('users')
        .select()
        .eq("id", id)
        .execute();
    if (userResponse.error == null && userResponse.data.length > 0) {
      container = userResponse.data[0];
    }
    return container;
  }

  static Future<Map<String, dynamic>> addUser(Map<String, dynamic> user) async {
    user["auth_id"] = SupaClient.supaBaseClient.auth.currentUser!.id;
    user["is_onboard"] = true;
    var response =
        await SupaClient.supaBaseClient.from('users').insert(user).execute();
    if (response.error != null) {
      print(response.error!.message);
    }
    print(response.data);
    return {
      "success": response.error == null,
      "user": response.data[0],
    };
  }
}
