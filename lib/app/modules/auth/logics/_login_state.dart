part of '_login_cubit.dart';



abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String redirectedRoute;
  final LoginResponse response;
  const LoginSuccess({required this.redirectedRoute, required this.response});
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({required this.errorMessage});
}
