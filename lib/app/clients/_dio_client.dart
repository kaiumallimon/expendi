import 'package:dio/dio.dart';
import 'package:expendi/app/config/_environment.dart';
import 'package:hive/hive.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio dio;

  // Hive box for tokens
  final Box _tokenBox = Hive.box('tokens');

  factory ApiClient() => _instance;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.apiBaseUrl!,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = _tokenBox.get('accessToken');
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = _tokenBox.get('refreshToken');
            if (refreshToken != null) {
              try {
                // Attempt to refresh token
                final refreshResponse = await dio.post(
                  '/auth/refresh-token',
                  data: {'refreshToken': refreshToken},
                );

                final newAccessToken = refreshResponse.data['accessToken'];
                final newRefreshToken = refreshResponse.data['refreshToken'];

                // Save new tokens in Hive
                await _tokenBox.put('accessToken', newAccessToken);
                await _tokenBox.put('refreshToken', newRefreshToken);

                // Retry original request
                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newAccessToken';
                final cloneReq = await dio.request(
                  opts.path,
                  options: Options(method: opts.method, headers: opts.headers),
                  data: opts.data,
                  queryParameters: opts.queryParameters,
                );
                return handler.resolve(cloneReq);
              } catch (_) {
                // Token refresh failed → logout
                await clearTokens();
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Save tokens
  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _tokenBox.put('accessToken', accessToken);
    await _tokenBox.put('refreshToken', refreshToken);
  }

  // Get current tokens
  Future<Map<String, String?>> getTokens() async {
    return {
      'accessToken': _tokenBox.get('accessToken'),
      'refreshToken': _tokenBox.get('refreshToken'),
    };
  }

  // Clear tokens (logout)
  Future<void> clearTokens() async {
    await _tokenBox.delete('accessToken');
    await _tokenBox.delete('refreshToken');
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    return dio.post(path, data: data);
  }

  // PUT request
  Future<Response> put(String path, {dynamic data}) async {
    return dio.put(path, data: data);
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }
}
