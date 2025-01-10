part of 'category_form_cubit.dart';

class CategoryFormState {
  final String name;
  final String imageUrl;
  final Uint8List? imageBytes;

  CategoryFormState({
    this.name = '',
    this.imageUrl = '',
    this.imageBytes,
  });

  CategoryFormState copyWith({
    String? name,
    String? imageUrl,
    Uint8List? imageBytes,
  }) {
    return CategoryFormState(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }
}
