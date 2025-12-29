import 'package:dio/dio.dart';
import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/models/auth/_login_req.dart';
import 'package:expendi/app/models/auth/_login_response.dart';

class LoginApi {
  LoginApi._();

  static Future<LoginResponse> loginUser({required LoginRequestModel data}) async {
    try {
      final apiClient = ApiClient();

      final response = await apiClient.post('/auth/login', data: data.toJson());

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to login user');
      }
    } catch (error) {
      if (error is DioException) {
        final serverMessage = error.response?.data['message'];
        if (serverMessage != null) {
          throw Exception(serverMessage);
        }
      }

      rethrow;
    }
  }
}
