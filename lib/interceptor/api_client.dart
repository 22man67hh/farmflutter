import 'package:dio/dio.dart';
import 'package:flutter_project/helper/token_storage.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1. Attach Auth Token automatically if available
          final token = await Tokenstorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // 2. Attach active language (e.g., 'en' or 'ne')
          options.headers['Accept-Language'] = 'en'; 

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Handle global 401 Unauthorized (token expired)
          if (e.response?.statusCode == 401) {
            await Tokenstorage.deleteToken();
            // Trigger navigation to Login screen here
          }
          return handler.next(e);
        },
      ),
    );
  }
}