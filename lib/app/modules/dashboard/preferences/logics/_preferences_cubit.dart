import 'package:expendi/app/models/auth/_register_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part '_preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit() : super(const PreferencesInitial());

  Future<void> init() async {
    emit(const PreferencesLoading());
    try {
      final userBox = await Hive.openBox('user_data');
      final userDataRaw = userBox.get('user');
      if (userDataRaw is Map<String, dynamic>) {
        final user = UserData.fromJson(userDataRaw);
        emit(PreferencesSuccess(user: user));
      } else if (userDataRaw != null) {
        // Try to convert if it's a Map but not typed
        try {
          final userDataMap = Map<String, dynamic>.from(userDataRaw);
          final user = UserData.fromJson(userDataMap);
          emit(PreferencesSuccess(user: user));
        } catch (e) {
          emit(const PreferencesFailure(errorMessage: 'User data is corrupted. Please log in again.'));
        }
      } else {
        emit(const PreferencesFailure(errorMessage: 'No user data found. Please log in again.'));
      }
    } catch (error) {
      emit(PreferencesFailure(errorMessage: error.toString()));
    }
  }
}
