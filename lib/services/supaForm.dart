import 'dart:convert';
import 'package:postgrest/postgrest.dart';

import './supaClient.dart';
import '../models/dynamicForm.dart';

class SupaForm {
  static Future getFormById(int formId) async {
    var response = await SupaClient.supaBaseClient
        .from("forms")
        .select()
        .eq("id", formId)
        .execute();

    return {
      'success': response.error == null,
      'data': response.data != null
          ? DynamicForm.fromJson(response.data[0]["form_config"])
          : null,
    };
  }

  static Future submitForm(
      DynamicForm formConfig, int userId, int countryId) async {
    String table = formConfig.table;

    Map<String, dynamic> container = {
      "user_id": userId,
      "country_id": countryId,
    };

    formConfig.form.forEach((FormSection e) {
      String field = e.field;
      String type = e.type;

      if (type == "textfield" || type == "datetime") {
        if (e.widgets[0].value != null && e.widgets[0].value.length > 0) {
          container[field] = e.widgets[0].value;
        }
      }
      if (type == "chips") {
        container[field] = [];
        e.widgets.forEach((e) {
          if (e.value != null && e.value) {
            container[field].add(e.key);
          }
        });
      }
    });

    if (table == "events" && container.containsKey('livestream_url')) {
      print(container['livestream_url']);
      if (container['livestream_url'] != null &&
          container['livestream_url'].length > 0) {
        container['event_type'] = "virtual";
      }
    } else if (table == 'events') {
      container['event_type'] = "physical";
    }
    print(container);
    var response =
        await SupaClient.supaBaseClient.from(table).insert(container).execute();

    if (response.error != null) {
      print(response.error!.message);
    }
    return {"success": response.error == null};
  }
}
