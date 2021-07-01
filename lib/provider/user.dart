import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';

import '../models/user.dart';
import '../utility/secureStorage.dart';
import '../services/supaClient.dart';
import '../services/supaAuth.dart';
import '../services/supaUser.dart';

class UserProvider with ChangeNotifier {
  UserData? user;

  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> loginResponse =
        await SupaAuth.signIn(email: username, password: password);

    String? errorMsg = loginResponse["errorMsg"];
    user = loginResponse["user"];

    if (errorMsg == null) {
      print("persiting");
      String seesionString = SupaClient.getPersistentString();

      await SecureStorage.storeSession(seesionString);
    }

    return {
      'success': loginResponse["success"],
      'user': loginResponse["user"],
      'errorMsg': errorMsg,
    };
  }

  Future<Map<String, dynamic>> persistUser() async {
    Map<String, dynamic> response = await SupaAuth.recoverSession();
    if (response["success"]) {
      PostgrestResponse userResponse = await SupaUser.getUser();
      bool gotUser = userResponse.error == null && userResponse.data.length > 0;
      if (gotUser) {
        user = UserData.fromJson(userResponse.data[0]);
      }
      return {
        "success": response["success"],
        "isOnboard": gotUser,
      };
    }
    return {
      "success": response["success"],
    };
  }

  Future<void> changeCountry(
      {required int newCountryId, required String newCountryName}) async {
    if (user != null) {
      user!.countryId = newCountryId;
      user!.countryName = newCountryName;
    }
  }

  Future onboardUser(Map<String, dynamic> userData) async {
    Map<String, dynamic> response = await SupaUser.addUser(userData);

    if (response["success"]) {
      var userResponse = await SupaUser.getUser();
      if (userResponse.error == null) {
        String seesionString = SupaClient.getPersistentString();

        await SecureStorage.storeSession(seesionString);
        user = UserData.fromJson(userResponse.data[0]);
      }
      return userResponse.error == null;
    }
  }
}
