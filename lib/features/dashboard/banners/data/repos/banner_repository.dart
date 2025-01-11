import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRepository {
  final FirebaseFirestore _firestore;
  final SupabaseClient _supabaseClient;

  BannerRepository()
      : _firestore = FirebaseFirestore.instance,
        _supabaseClient = Supabase.instance.client;

  /// Add a new banner to Firestore
  Future<void> addBanner(BannerModel banner) async {
    try {
      await _firestore
          .collection('Banners')
          .doc(banner.id)
          .set(banner.toJson());
      print('Banner added successfully');
    } catch (e) {
      print('Error adding banner: $e');
      throw Exception('Failed to add Banner');
    }
  }

  /// Update an existing banner in Firestore
  Future<void> updateBanner(BannerModel banner) async {
    try {
      await _firestore
          .collection('Banners')
          .doc(banner.id)
          .update(banner.toJson());
      print('Banner updated successfully');
    } catch (e) {
      print('Error updating banner: $e');
      throw Exception('Failed to update banner');
    }
  }

  /// Delete a banner and its associated images
  Future<void> deleteBanner(
    BannerModel banner,
  ) async {
    try {
      // 1. Delete banner document from Firestore
      await _firestore.collection('Banners').doc(banner.id).delete();

      final filePath = _extractFilePath(banner.imageUrl);
      await _supabaseClient.storage.from('images').remove([filePath]);

      print('Banner and associated images deleted successfully.');
    } catch (e) {
      print('Error deleting banner: $e');
      throw Exception('Failed to delete banner and its images.');
    }
  }

  /// Upload an image to Supabase Storage
  Future<String?> uploadImage(Uint8List fileBytes, String fileName) async {
    try {
      // Specify the bucket name where the images will be stored
      const bucketName = 'images';

      // Generate a unique path for the file
      final String filePath = 'banners/$fileName';

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
