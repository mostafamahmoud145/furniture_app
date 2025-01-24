import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/products/data/repos/product_repository.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'get_all_products_of_category_state.dart';

class GetAllProductsOfCategoryCubit
    extends Cubit<GetAllProductsOfCategoryState> {
  GetAllProductsOfCategoryCubit() : super(GetAllProductsOfCategoryInitial());

  final ProductRepository repository = ProductRepository();

  Future<void> getAllProductsOfCategory({String? categoryId}) async {
    emit(GetAllProductsOfCategoryLoading());
    try {
      final products =
          await repository.getAllProductsOfCategory(categoryId: categoryId);
      emit(GetAllProductsOfCategorySuccess(products: products));
      print('Valid Products: $products');
    } catch (e) {
      print('Error: $e');
      emit(GetAllProductsOfCategoryError());
    }
  }
}
