class RegisterResponse {
  final bool success;
  final String message;
  final RegisterData data;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: RegisterData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class RegisterData {
  final String accessToken;
  final String refreshToken;
  final UserData user;

  RegisterData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}

class UserData {
  final String id;
  final String email;
  final String fullName;
  final String defaultCurrency;
  final String avatarUrl;

  UserData({
    required this.id,
    required this.email,
    required this.fullName,
    required this.defaultCurrency,
    required this.avatarUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      defaultCurrency: json['default_currency'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'default_currency': defaultCurrency,
      'avatar_url': avatarUrl,
    };
  }
}
