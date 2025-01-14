import 'dart:typed_data';
import 'dart:ui';

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
    required List<Map<String, dynamic>> imageColors,
    List<String> existingImageUrls = const [],
  }) {
    emit(ProductFormState(
      name: name,
      description: description,
      price: price,
      isBestSeller: isBestSeller,
      productCode: productCode,
      imageColors: imageColors,
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
    List<Map<String, dynamic>>? imageColors,
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
      imageColors: imageColors,
    ));
  }

  void addColor(Map<String, dynamic> color) {
    print("111111111111111111111");
    state.imageColors.add(color); // Add the new color as a map
    emit(state.copyWith(imageColors: state.imageColors));
  }

  Map<String, dynamic> colorToMap(Color color) {
    return {
      'r': color.r * 255,
      'g': color.g * 255,
      'b': color.b * 255,
      'a': color.a * 255,
    };
  }

  Color mapToColor(Map<String, dynamic> map) {
    return Color.fromARGB(
      map['a'].toInt(),
      map['r'].toInt(),
      map['g'].toInt(),
      map['b'].toInt(),
    );
  }

  void updateColor(int index, Map<String, dynamic> newColor) {
    state.imageColors[index] = newColor; // Update the specific color
    emit(state.copyWith(imageColors: state.imageColors)); // Emit updated state
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
