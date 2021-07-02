import 'package:hive/hive.dart';
import 'package:supabase/supabase.dart';

class SecureStorage {
  static const _supabaseSessionKey = "supabaseSessionKey";

  static Future storeSession(String sessionString) async {
    Box sess = Hive.box<String>("SESSION");
    await sess.put('SESSION', sessionString);
  }

  static String? getSession() {
    Box sess = Hive.box<String>("SESSION");
    String? session = sess.get("SESSION");
    return session;
  }

  static Future deleteSession() async {
    Box sess = Hive.box<String>("SESSION");
    await sess.deleteFromDisk();
  }
}
