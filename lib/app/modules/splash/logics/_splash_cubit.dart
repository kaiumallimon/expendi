
import 'package:flutter_bloc/flutter_bloc.dart';

part '_splash_state.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit() : super(const SplashInitial());

  Future<void> loadApp() async {
    try {
      emit(const SplashLoading());
      // Simulate some loading tasks like fetching user data, settings, etc.
      await Future.delayed(const Duration(seconds: 2));
      // After loading, decide the next route (e.g., home or login)
      const redirectedRoute = '/login'; // Example route
      emit(SplashLoaded(redirectedRoute: redirectedRoute));
    } catch (e) {
      emit(SplashError(message: e.toString()));
    }
  }
}