import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase/supabase.dart';

class SecureStorage {
  static final _secureStorage = FlutterSecureStorage();

  static const _supabaseSessionKey = "supabaseSessionKey";

  static Future storeSession(String sessionString) async {
    await _secureStorage.write(key: _supabaseSessionKey, value: sessionString);
  }

  static Future<String?> getSession() async {
    String? session = await _secureStorage.read(key: _supabaseSessionKey);

    return session;
  }

  static Future deleteSession() async {
    await _secureStorage.delete(key: _supabaseSessionKey);
  }
}
