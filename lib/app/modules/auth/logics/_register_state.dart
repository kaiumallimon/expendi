part of '_register_cubit.dart';

abstract class RegisterState{
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final RegisterResponse response;
  final String redirectedRoute;
  const RegisterSuccess({required this.response, required this.redirectedRoute});
}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  const RegisterFailure({required this.errorMessage});
}
