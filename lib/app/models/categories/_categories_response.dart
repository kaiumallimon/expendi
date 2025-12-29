import 'package:expendi/app/models/categories/_add_category_response.dart';

class CategoriesResponseModel{
  final bool success;
  final String message;
  final List<Category> data;

  CategoriesResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json){
    return CategoriesResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>).map((e) => Category.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
