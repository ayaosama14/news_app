import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyEmail = 'email';
  static Future setEmail(String email) async => await _storage.write(
        key: _keyEmail,
        value: email,
      );
  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);
}
