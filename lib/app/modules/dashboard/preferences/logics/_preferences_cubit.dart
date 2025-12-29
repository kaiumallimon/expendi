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
      final userDataMap = userBox.get('user') as Map<String, dynamic>?;
      if (userDataMap != null) {
        final user = UserData.fromJson(userDataMap);
        emit(PreferencesSuccess(user: user));
      } else {
        emit(const PreferencesInitial());
      }
    } catch (error) {
      emit(const PreferencesFailure(errorMessage: 'Something went wrong'));
    }
  }
}
