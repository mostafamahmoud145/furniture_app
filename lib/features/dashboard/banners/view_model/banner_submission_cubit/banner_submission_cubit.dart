import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/data/repos/banner_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'banner_submission_state.dart';

class BannerSubmissionCubit extends Cubit<BannerSubmissionState> {
  final BannerRepository bannerRepository;

  BannerSubmissionCubit({
    required this.bannerRepository,
  }) : super(BannerSubmissionInitial());

  Future<void> submitBanner({
    required String id,
    Uint8List? newImage,
    required String existingImageUrl,
  }) async {
    emit(BannerSubmissionLoading());

    try {
      String? uploadedImageUrl = existingImageUrl;
      // Handle Image Upload
      if (newImage != null) {
        // Delete old image if exists
        if (existingImageUrl.trim().isNotEmpty) {
          await bannerRepository.deleteImage(
            _extractFilePath(existingImageUrl),
          );
        }
        // Upload new image
        uploadedImageUrl = await bannerRepository.uploadImage(
          newImage,
          'banner_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        if (uploadedImageUrl == null) {
          emit(BannerSubmissionError(
              message: "Error While Upload Image Please Try Again"));
          return;
        }
      }

      // Create Banner Model
      final banner = BannerModel(
        id: id.isEmpty ? const Uuid().v4() : id,
        imageUrl: uploadedImageUrl,
      );

      // Determine Add or Update
      if (id.isEmpty) {
        await bannerRepository.addBanner(banner);
        emit(BannerSubmissionSuccess(message: 'Banner added successfully.'));
      } else {
        await bannerRepository.updateBanner(banner);
        emit(
            BannerSubmissionSuccess(message: 'Banner updated successfully.'));
      }
    } catch (e) {
      emit(BannerSubmissionError(message: 'Failed to submit banner: $e'));
    }
  }

  String _extractFilePath(String publicUrl) {
    final basePath =
        Supabase.instance.client.storage.from('images').getPublicUrl('');
    return publicUrl.replaceFirst(basePath, '');
  }
}
