import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/data/repos/category_repository.dart';
import 'package:meta/meta.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());

  final CategoryRepository repository = CategoryRepository();

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    try {
      final categories = await repository.getCategories();
      emit(GetCategoriesSuccess(categories: categories));
      print('Valid Categories: $categories');
    } catch (e) {
      print('Error: $e');
      emit(GetCategoriesError());
    }
  }
}
