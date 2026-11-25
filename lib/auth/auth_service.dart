import 'package:dio/dio.dart';
import 'package:flutter_project/helper/token_storage.dart';
import 'package:flutter_project/interceptor/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final String token = response.data['token'];
      await Tokenstorage.saveToken(token);
      return true;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Login failed. Check your connection.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

Future<bool> register(String email, String password,String fullName,String phoneNumber,String address) async {
  try{


final response=await _apiClient.dio.post(
        '/auth/register',
        data: {'email': email, 'password': password,'fullName':fullName,'phoneNumber':phoneNumber,'address':address},
      );
      if(response.data['success']){
        return true;
      }
      throw Exception('Registration failed.');
  }on DioException catch (e) {
    final errorMessage =
        e.response?.data['message'] ?? 'Registration failed. Check your connection.';
    throw Exception(errorMessage);
  } catch (e) {
    throw Exception('An unexpected error occurred.');
  }
}
  Future<void> logout() async {
    await Tokenstorage.deleteToken();
  }
}
