import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'product_form_state.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  ProductFormCubit() : super(ProductFormState());

  final ImagePicker _picker = ImagePicker();

  void initialize({
    required String name,
    required String description,
    required num price,
    required bool isBestSeller,
    required String productCode,
    List<String> existingImageUrls = const [],
  }) {
    emit(ProductFormState(
      name: name,
      description: description,
      price: price,
      isBestSeller: isBestSeller,
      productCode: productCode,
      existingImageUrls: existingImageUrls,
    ));
  }

  void updateField({
    String? name,
    String? description,
    num? price,
    bool? isBestSeller,
    String? productCode,
    String? categoryId,
    Uint8List? mainImage,
    List<Uint8List?>? optionalImages,
  }) {
    emit(state.copyWith(
      name: name,
      description: description,
      price: price,
      isBestSeller: isBestSeller,
      productCode: productCode,
      categoryId: categoryId,
      mainImage: mainImage,
      optionalImages: optionalImages,
    ));
  }

  /// Pick an image and update the state
  Future<void> pickImage({required bool isMain, int? index}) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        if (isMain) {
          // Update the main image
          emit(state.copyWith(mainImage: imageBytes));
        } else if (index != null &&
            index >= 0 &&
            index < state.optionalImages.length) {
          // Update an optional image
          final updatedOptionalImages =
              List<Uint8List?>.from(state.optionalImages);
          updatedOptionalImages[index] = imageBytes;
          emit(state.copyWith(optionalImages: updatedOptionalImages));
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
