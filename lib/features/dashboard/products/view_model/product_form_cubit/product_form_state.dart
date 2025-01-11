part of 'product_form_cubit.dart';

class ProductFormState {
  final String name;
  final String description;
  final num price;
  final bool isBestSeller;
  final String productCode;
  final String? categoryId;
  final List<String> existingImageUrls;
  final Uint8List? mainImage;
  final List<Uint8List?> optionalImages;

  ProductFormState({
    this.name = '',
    this.description = '',
    this.price = 0,
    this.isBestSeller = false,
    this.productCode = '',
    this.categoryId,
    this.existingImageUrls = const [],
    this.mainImage,
    this.optionalImages = const [null, null, null],
  });

  ProductFormState copyWith({
    String? name,
    String? description,
    num? price,
    bool? isBestSeller,
    String? productCode,
    String? categoryId,
    List<String>? existingImageUrls,
    Uint8List? mainImage,
    List<Uint8List?>? optionalImages,
  }) {
    return ProductFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      productCode: productCode ?? this.productCode,
      categoryId: categoryId ?? this.categoryId,
      existingImageUrls: existingImageUrls ?? this.existingImageUrls,
      mainImage: mainImage ?? this.mainImage,
      optionalImages: optionalImages ?? this.optionalImages,
    );
  }
}
