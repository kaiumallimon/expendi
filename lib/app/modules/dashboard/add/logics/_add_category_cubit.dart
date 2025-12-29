import 'package:expendi/app/models/categories/_add_category_req.dart';
import 'package:expendi/app/models/categories/_add_category_response.dart';
import 'package:expendi/app/repositories/remote/v1/categories/_categories_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part '_add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(const AddCategoryInitial());

  Future<void> init() async {
    emit(const AddCategoryLoading());
    try {
      final response = await CategoriesApi.getCategories();
      emit(AddCategorySuccess(categories: response.data));
    } catch (error) {
      emit(AddCategoryFailure(errorMessage: error.toString()));
    }
  }

  Future<void> addCategory({
    required String name,
    required String icon,
    required String color,
  }) async {
    emit(const AddCategoryLoading());
    try {
      final payload = AddCategoryRequestModel(
        name: name,
        color: color,
        icon: icon,
      );
      await CategoriesApi.addCategory(data: payload);
      final fetchResponse = await CategoriesApi.getCategories();
      emit(AddCategorySuccess(categories: fetchResponse.data));
    } catch (error) {
      emit(AddCategoryFailure(errorMessage: error.toString()));
    }
  }
}
