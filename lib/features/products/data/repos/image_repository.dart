import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageRepository {
  final SupabaseClient _supabaseClient;

  ImageRepository() : _supabaseClient = Supabase.instance.client;

  /// Upload an image to Supabase Storage
  Future<String?> uploadImage(Uint8List fileBytes, String fileName) async {
    try {
      // Specify the bucket name where the images will be stored
      const bucketName = 'images';

      // Generate a unique path for the file
      final String filePath = 'products/$fileName';

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
}
