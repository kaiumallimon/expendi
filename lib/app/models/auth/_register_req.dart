class RegisterReqModel{
  final String fullName;
  final String email;
  final String password;
  final String defaultCurrency;

  RegisterReqModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.defaultCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'default_currency': defaultCurrency,
    };
  }
}
