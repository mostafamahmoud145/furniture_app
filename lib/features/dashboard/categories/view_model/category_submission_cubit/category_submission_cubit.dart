import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/data/repos/category_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'category_submission_state.dart';

class CategorySubmissionCubit extends Cubit<CategorySubmissionState> {
  final CategoryRepository categoryRepository;

  CategorySubmissionCubit({
    required this.categoryRepository,
  }) : super(CategorySubmissionInitial());

  Future<void> submitCategory({
    required String id,
    required String name,
    Uint8List? newImage,
    required String existingImageUrl,
  }) async {
    emit(CategorySubmissionLoading());

    try {
      String? uploadedImageUrl = existingImageUrl;
      // Handle Image Upload
      if (newImage != null) {
        // Delete old image if exists
        if (existingImageUrl.trim().isNotEmpty) {
          await categoryRepository.deleteImage(
            _extractFilePath(existingImageUrl),
          );
        }
        // Upload new image
        uploadedImageUrl = await categoryRepository.uploadImage(
          newImage,
          'category_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        if (uploadedImageUrl == null) {
          emit(CategorySubmissionError(
              message: "Error While Upload Image Please Try Again"));
          return;
        }
      }

      // Create Category Model
      final category = CategoryModel(
        id: id.isEmpty ? const Uuid().v4() : id,
        name: name,
        imageUrl: uploadedImageUrl,
      );

      // Determine Add or Update
      if (id.isEmpty) {
        await categoryRepository.addCategory(category);
        emit(
            CategorySubmissionSuccess(message: 'Category added successfully.'));
      } else {
        await categoryRepository.updateCategory(category);
        emit(CategorySubmissionSuccess(
            message: 'Category updated successfully.'));
      }
    } catch (e) {
      emit(CategorySubmissionError(message: 'Failed to submit category: $e'));
    }
  }

  String _extractFilePath(String publicUrl) {
    final basePath =
        Supabase.instance.client.storage.from('images').getPublicUrl('');
    return publicUrl.replaceFirst(basePath, '');
  }
}
