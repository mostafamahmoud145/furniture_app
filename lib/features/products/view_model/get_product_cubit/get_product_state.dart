part of 'get_product_cubit.dart';

@immutable
sealed class GetProductState {}

final class GetProductInitial extends GetProductState {}

final class GetProductLoading extends GetProductState {}

final class GetProductSuccess extends GetProductState {
  final ProductModel product;
  GetProductSuccess({required this.product});
}

final class GetProductError extends GetProductState {}
