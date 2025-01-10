import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'category_form_state.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final ImagePicker _picker = ImagePicker();

  CategoryFormCubit() : super(CategoryFormState());

  /// Initialize the cubit with existing category data or defaults
  void initialize({
    required String name,
    required String existingImageUrl,
  }) {
    emit(CategoryFormState(
      name: name,
      imageUrl: existingImageUrl,
    ));
  }

  /// Update specific fields in the category form state
  void updateField({
    String? name,
  }) {
    emit(state.copyWith(name: name ?? state.name));
  }

  /// Pick an image and update the state with the selected image
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        emit(state.copyWith(imageBytes: imageBytes));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
