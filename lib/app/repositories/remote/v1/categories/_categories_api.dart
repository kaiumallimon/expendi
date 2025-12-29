import 'package:dio/dio.dart';
import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/models/categories/_add_category_req.dart';
import 'package:expendi/app/models/categories/_add_category_response.dart';
import 'package:expendi/app/models/categories/_categories_response.dart';

class CategoriesApi {
  const CategoriesApi._();

  // Add a new category
  static Future<AddCategoryResponseModel> addCategory({
    required AddCategoryRequestModel data,
  }) async {
    try {
      final client = ApiClient();
      final response = await client.post('/categories', data: data.toJson());
      if (response.statusCode == 201) {
        return AddCategoryResponseModel.fromJson(response.data);
      }

      throw Exception(
        response.data['message'] ??
            'An error occurred while adding the category.',
      );
    } catch (error) {
      if (error is DioException) {
        throw Exception(
          error.response?.data['message'] ??
              'An error occurred while adding the category.',
        );
      }

      throw Exception('An unexpected error occurred: $error');
    }
  }

  // get all categories
  static Future<CategoriesResponseModel> getCategories() async {
    try {
      final client = ApiClient();
      final response = await client.get('/categories');
      if (response.statusCode == 200) {
        return CategoriesResponseModel.fromJson(response.data);
      }

      throw Exception(
        response.data['message'] ??
            'An error occurred while fetching categories.',
      );
    } catch (error) {
      if (error is DioException) {
        throw Exception(
          error.response?.data['message'] ??
              'An error occurred while fetching categories.',
        );
      }

      throw Exception('An unexpected error occurred: $error');
    }
  }
}
