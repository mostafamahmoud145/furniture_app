import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'banner_form_state.dart';

class BannerFormCubit extends Cubit<BannerFormState> {
  final ImagePicker _picker = ImagePicker();

  BannerFormCubit() : super(BannerFormState());

  /// Initialize the cubit with existing banner data or defaults
  void initialize({
    required String existingImageUrl,
  }) {
    emit(BannerFormState(
      imageUrl: existingImageUrl,
    ));
  }

  /// Pick an image and update the state with the selected image
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        emit(state.copyWith(imageBytes: imageBytes));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
