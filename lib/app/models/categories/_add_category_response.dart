class AddCategoryResponseModel {
  final bool success;
  final String message;
  final Category data;

  AddCategoryResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCategoryResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: Category.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class Category {
  final String id;
  final String userId;
  final String name;
  final String color;
  final String icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'name': name,
      'color': color,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
