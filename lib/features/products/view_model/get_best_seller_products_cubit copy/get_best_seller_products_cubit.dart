import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/products/data/repos/product_repository.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'get_best_seller_products_state.dart';

class GetBestSellerProductsCubit extends Cubit<GetBestSellerProductsState> {
  GetBestSellerProductsCubit() : super(GetBestSellerProductInitial());

  final ProductRepository repository = ProductRepository();

  Future<void> getBestSellerProducts() async {
    emit(GetBestSellerProductsLoading());
    try {
      final products = await repository.getBestSellerProducts();
      emit(GetBestSellerProductsSuccess(products: products));
      print('Valid Products: $products');
    } catch (e) {
      print('Error: $e');
      emit(GetBestSellerProductsError());
    }
  }
}
