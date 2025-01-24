part of 'get_all_products_of_category_cubit.dart';

@immutable
sealed class GetAllProductsOfCategoryState {}

final class GetAllProductsOfCategoryInitial
    extends GetAllProductsOfCategoryState {}

final class GetAllProductsOfCategoryLoading
    extends GetAllProductsOfCategoryState {}

final class GetAllProductsOfCategorySuccess
    extends GetAllProductsOfCategoryState {
  final List<ProductModel> products;
  GetAllProductsOfCategorySuccess({required this.products});
}

final class GetAllProductsOfCategoryError
    extends GetAllProductsOfCategoryState {}
