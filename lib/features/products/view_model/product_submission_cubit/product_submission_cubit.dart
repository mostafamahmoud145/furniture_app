import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/products/data/repos/image_repository.dart';
import 'package:furniture_app/features/products/data/repos/product_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

part 'product_submission_state.dart';

class ProductSubmissionCubit extends Cubit<ProductSubmissionState> {
  final ProductRepository productRepository;
  final ImageRepository imageRepository;

  ProductSubmissionCubit({
    required this.productRepository,
    required this.imageRepository,
  }) : super(ProductSubmissionInitial());

  Future<void> submitProduct({
    required String id,
    required String name,
    required String description,
    required num price,
    required bool isBestSeller,
    required String productCode,
    Uint8List? mainImage,
    List<Uint8List?> optionalImages = const [null, null, null],
    List<String> existingImageUrls = const [],
  }) async {
    emit(ProductSubmissionLoading());

    try {
      final List<String> uploadedImageUrls = [];

      // Handle Main Image
      if (mainImage != null) {
        // Delete old main image if exists
        if (existingImageUrls.isNotEmpty) {
          await imageRepository.deleteImage(
            _extractFilePath(existingImageUrls.first),
          );
        }
        // Upload new main image
        final mainImageUrl = await imageRepository.uploadImage(
          mainImage,
          'main_image_${id.isEmpty ? DateTime.now().millisecondsSinceEpoch : id}.jpg',
        );
        uploadedImageUrls.add(mainImageUrl!);
      } else if (existingImageUrls.isNotEmpty) {
        uploadedImageUrls.add(existingImageUrls.first);
      }

      // Handle Optional Images
      for (int i = 0; i < optionalImages.length; i++) {
        if (optionalImages[i] != null) {
          // Delete old optional image if exists
          if (existingImageUrls.length > i + 1) {
            await imageRepository.deleteImage(
              _extractFilePath(existingImageUrls[i + 1]),
            );
          }
          // Upload new optional image
          final optionalImageUrl = await imageRepository.uploadImage(
            optionalImages[i]!,
            'optional_image_${id.isEmpty ? DateTime.now().millisecondsSinceEpoch : id}_$i.jpg',
          );
          uploadedImageUrls.add(optionalImageUrl!);
        } else if (existingImageUrls.length > i + 1) {
          uploadedImageUrls.add(existingImageUrls[i + 1]);
        }
      }

      // Create Product Model
      final product = ProductModel(
        id: id.isEmpty ? const Uuid().v4() : id,
        name: name,
        description: description,
        price: price,
        images: uploadedImageUrls,
        isBestSeller: isBestSeller,
        productCode: productCode,
      );

      // Determine Add or Update
      if (id.isEmpty) {
        await productRepository.addProduct(product);
        emit(ProductSubmissionSuccess(message: 'Product added successfully.'));
      } else {
        await productRepository.updateProduct(product);
        emit(
            ProductSubmissionSuccess(message: 'Product updated successfully.'));
      }
    } catch (e) {
      emit(ProductSubmissionError(message: 'Failed to submit product: $e'));
    }
  }

  String _extractFilePath(String publicUrl) {
    final basePath =
        Supabase.instance.client.storage.from('images').getPublicUrl('');
    return publicUrl.replaceFirst(basePath, '');
  }
}
