import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Tokenstorage {
  static const _storage=FlutterSecureStorage();
  static const _tokenKey='auth_token';


  static Future<void> saveToken(String token)async{
    return await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken()async{
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken()async{
    return await _storage.delete(key: _tokenKey);
  }
}
