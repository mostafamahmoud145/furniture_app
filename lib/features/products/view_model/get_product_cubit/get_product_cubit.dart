import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/products/data/repos/product_repository.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(GetProductInitial());

  final ProductRepository repository = ProductRepository();

  Future<void> getProduct({required String productId}) async {
    emit(GetProductLoading());
    try {
      final product = await repository.getProduct(productId: productId);
      emit(GetProductSuccess(product: product));
    } catch (e) {
      print('Error: $e');
      emit(GetProductError());
    }
  }
}
