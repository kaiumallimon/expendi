import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/models/auth/_login_req.dart';
import 'package:expendi/app/models/auth/_login_response.dart';
import 'package:expendi/app/repositories/remote/v1/auth/_login_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
part '_login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());
    try {
      final payload = LoginRequestModel(email: email, password: password);

      final response = await LoginApi.loginUser(data: payload);

      // Store tokens using ApiClient
      await ApiClient().setTokens(
        accessToken: response.data.accessToken,
        refreshToken: response.data.refreshToken,
      );

      // store user data in Hive
      final userBox = await Hive.openBox('user_data');
      await userBox.put('user', response.data.user.toJson());

      emit(LoginSuccess(response: response, redirectedRoute: '/home'));
    } catch (error) {
      emit(LoginFailure(errorMessage: error.toString()));
    } finally {
      emit(const LoginInitial());
    }
  }
}
