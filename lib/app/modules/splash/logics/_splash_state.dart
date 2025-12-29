part of '_splash_cubit.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoaded extends SplashState {
  final String redirectedRoute;
  const SplashLoaded({required this.redirectedRoute});
}

class SplashError extends SplashState {
  final String message;
  const SplashError({required this.message});
}
