import 'package:dio/dio.dart';
import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/models/auth/_register_req.dart';
import 'package:expendi/app/models/auth/_register_response.dart';

class RegisterApi {
  RegisterApi._();

  static Future<RegisterResponse> registerUser({
    required RegisterReqModel data,
  }) async {
    try {
      final apiClient = ApiClient();

      // Debug: print the payload being sent

      final response = await apiClient.post(
        '/auth/register',
        data: data.toJson(),
      );

      if (response.statusCode == 201) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to register user');
      }
    } catch (error) {
      // Debug: print error details
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
