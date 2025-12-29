part of '_preferences_cubit.dart';

abstract class PreferencesState {
  const PreferencesState();
}

class PreferencesInitial extends PreferencesState {
  const PreferencesInitial();
}

class PreferencesLoading extends PreferencesState {
  const PreferencesLoading();
}

class PreferencesSuccess extends PreferencesState {
  final UserData user;
  const PreferencesSuccess({required this.user});
}

class PreferencesFailure extends PreferencesState {
  final String errorMessage;
  const PreferencesFailure({required this.errorMessage});
}
