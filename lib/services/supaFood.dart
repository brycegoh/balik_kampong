import 'package:balik_kampong/models/user.dart';
import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import './supaUser.dart';
import '../models/food.dart';
import '../models/review.dart';
import '../models/user.dart';

class SupaFood {
  static Future<dynamic> getAllFood(
      {int? countryId, String? search, List<String>? listOfTags}) async {
    PostgrestFilterBuilder query =
        SupaClient.supaBaseClient.from('food').select();

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
      List<Food> container = data.map<Food>((e) {
        return Food.fromJson(e);
      }).toList();
      return container;
    }
  }

  static Future<dynamic> getLatestReview({int? foodId}) async {
    UserData? user;
    Review? review;
    PostgrestFilterBuilder query = SupaClient.supaBaseClient
        .from('reviews')
        .select()
        .eq("food_id", foodId);

    PostgrestResponse response =
        await query.order("date_created", ascending: false).limit(1).execute();

    if (response.error == null && response.data.length > 0) {
      review = Review.fromJson(response.data[0]);

      Map<String, dynamic>? userResponse =
          await SupaUser.getUserById(review.userId);
      if (userResponse != null) {
        user = UserData.fromJson(userResponse);
      }
    }
    return {
      "user": user,
      "review": review,
    };
  }
}
