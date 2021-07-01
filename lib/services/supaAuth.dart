import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import './supaUser.dart';
import '../utility/secureStorage.dart';
import '../models/user.dart';

class SupaAuth {
  static Future signIn(
      {required String email, required String password}) async {
    String? errorMsg;
    UserData? user;

    var response = await SupaClient.supaBaseClient.auth.signIn(
      email: email,
      password: password,
    );

    if (response.error == null) {
      var userResponse = await SupaUser.getUser();

      if (userResponse.error == null && userResponse.data.length > 0) {
        String seesionString = response.data!.persistSessionString;

        await SecureStorage.storeSession(seesionString);
        user = UserData.fromJson(userResponse.data[0]);
      }

      return {"success": true, "user": user, 'errorMsg': errorMsg};
    } else {
      errorMsg = response.error!.message;
      return {
        "success": false,
        "user": user,
        'errorMsg': errorMsg,
      };
    }
  }

  static Future signUp(
      {required String email, required String password}) async {
    var response = await SupaClient.supaBaseClient.auth.signUp(email, password);

    return {
      "success": response.error == null,
      "errorMsg": response.error != null ? response.error!.message : null,
    };
  }

  static Future<void> recoverSessionOnResume() async {
    print('***** onResumed onResumed onResumed');
    final String? sessionString = await SecureStorage.getSession();

    if (sessionString != null) {
      await SupaClient.supaBaseClient.auth.recoverSession(sessionString);
    }
  }

  static Future<Map<String, dynamic>> recoverSession() async {
    final String? sessionString = await SecureStorage.getSession();

    if (sessionString != null) {
      ///// restore session
      final response =
          await SupaClient.supaBaseClient.auth.recoverSession(sessionString);
      if (response.error == null) {
        ///// store new persist string
        // var refreshSession = await supaBaseClient.auth.refreshSession();
        // if (refreshSession.error == null) {
        await SecureStorage.storeSession(response.data!.persistSessionString);
        return {"success": true, "user": response.user};
        // } else {
        // print("refresh problem");
        // print(refreshSession.error!.message);
        // }
      } else {
        print("recover problem");
        print(response.error!.message);
      }
      await SecureStorage.deleteSession();
      return {"success": false, "user": null};
    } else {
      print("No session string");
    }
    return {"success": false, "user": null};
  }
}
