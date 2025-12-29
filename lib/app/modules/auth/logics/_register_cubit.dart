import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/models/auth/_register_req.dart';
import 'package:expendi/app/models/auth/_register_response.dart';
import 'package:expendi/app/repositories/remote/v1/auth/_register_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
part '_register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterInitial());

  Future<void> register({
    required String name,
    required String currency,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    try {
      final payload = RegisterReqModel(
        fullName: name,
        email: email,
        password: password,
        defaultCurrency: currency,
      );

      final response = await RegisterApi.registerUser(data: payload);
      await ApiClient().setTokens(
        accessToken: response.data.accessToken,
        refreshToken: response.data.refreshToken,
      );
            // store user data in Hive
      final userBox = await Hive.openBox('user_data');
      await userBox.put('user', response.data.user.toJson());
      emit(RegisterSuccess(response: response, redirectedRoute: '/home'));
    } catch (error) {
      print('RegisterCubit.register error: $error');
      emit(RegisterFailure(errorMessage: error.toString()));
    } finally {
      emit(const RegisterInitial());
    }
  }
}
