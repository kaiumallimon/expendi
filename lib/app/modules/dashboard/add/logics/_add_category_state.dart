part of '_add_category_cubit.dart';


abstract class  AddCategoryState {
  const  AddCategoryState();
}

class  AddCategoryInitial extends  AddCategoryState {
  const  AddCategoryInitial();
}

class  AddCategoryLoading extends  AddCategoryState {
  const  AddCategoryLoading();
}

class  AddCategorySuccess extends  AddCategoryState {
  final List<Category> categories;
  const  AddCategorySuccess({required this.categories});
}

class  AddCategoryFailure extends  AddCategoryState {
  final String errorMessage;
  const  AddCategoryFailure({required this.errorMessage});
}
