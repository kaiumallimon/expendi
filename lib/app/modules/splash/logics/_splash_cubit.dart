import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

part '_splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> loadApp() async {
    try {
      emit(const SplashLoading());
      await Future.delayed(const Duration(seconds: 2));
      final Box tokenBox = Hive.box('tokens');

      final accessToken = tokenBox.get('accessToken');
      final redirectedRoute = (accessToken != null) ? '/home' : '/login';

      emit(SplashLoaded(redirectedRoute: redirectedRoute));
    } catch (e) {
      emit(SplashError(message: e.toString()));
    }
  }
}
