import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;
  final SupabaseClient _supabaseClient;

  CategoryRepository()
      : _firestore = FirebaseFirestore.instance,
        _supabaseClient = Supabase.instance.client;

  Future<List<CategoryModel>> getCategories() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Categories').get();

      if (snapshot.docs.isEmpty) {
        return const []; // Return an empty list if no documents found
      }

      return snapshot.docs
          .map((doc) {
            try {
              return CategoryModel.fromJson(doc.data());
            } catch (e) {
              // Skip the item if mapping fails
              print('Skipping document ${doc.id} due to error: $e');
              return null;
            }
          })
          .whereType<CategoryModel>() // Filters out null items
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// Add a new category to Firestore
  Future<void> addCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('Categories')
          .doc(category.id)
          .set(category.toJson());
      print('Category added successfully');
    } catch (e) {
      print('Error adding category: $e');
      throw Exception('Failed to add category');
    }
  }

  /// Update an existing category in Firestore
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('Categories')
          .doc(category.id)
          .update(category.toJson());
      print('Category updated successfully');
    } catch (e) {
      print('Error updating category: $e');
      throw Exception('Failed to update category');
    }
  }

  /// Delete a category and its associated images
  Future<void> deleteCategory(
    CategoryModel category,
  ) async {
    try {
      // 1. Delete category document from Firestore
      await _firestore.collection('Categories').doc(category.id).delete();

      final filePath = _extractFilePath(category.imageUrl);
      await _supabaseClient.storage.from('images').remove([filePath]);

      print('Category and associated images deleted successfully.');
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('Failed to delete category and its images.');
    }
  }

  /// Upload an image to Supabase Storage
  Future<String?> uploadImage(Uint8List fileBytes, String fileName) async {
    try {
      // Specify the bucket name where the images will be stored
      const bucketName = 'images';

      // Generate a unique path for the file
      final String filePath = 'categories/$fileName';

      // Upload the file to the Supabase bucket
      await _supabaseClient.storage
          .from(bucketName)
          .uploadBinary(filePath, fileBytes);

      // Get the public URL of the uploaded image
      final String publicUrl =
          _supabaseClient.storage.from(bucketName).getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  /// Delete an image from Supabase storage
  Future<void> deleteImage(String imagePath) async {
    try {
      await _supabaseClient.storage.from('images').remove([imagePath]);
    } catch (e) {
      print('Error deleting image: $e');
      throw Exception('Image deletion failed');
    }
  }

  /// Extract file path from Supabase public URL
  String _extractFilePath(String publicUrl) {
    final basePath = _supabaseClient.storage.from('images').getPublicUrl('');
    return publicUrl.replaceFirst(basePath, '');
  }
}
