part of 'get_best_seller_products_cubit.dart';

@immutable
sealed class GetBestSellerProductsState {}

final class GetBestSellerProductInitial extends GetBestSellerProductsState {}

final class GetBestSellerProductsLoading extends GetBestSellerProductsState {}

final class GetBestSellerProductsSuccess extends GetBestSellerProductsState {
  final List<ProductModel> products;
  GetBestSellerProductsSuccess({required this.products});
}

final class GetBestSellerProductsError extends GetBestSellerProductsState {}
