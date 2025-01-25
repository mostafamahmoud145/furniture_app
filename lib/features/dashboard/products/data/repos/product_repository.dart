import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;
  final SupabaseClient _supabaseClient;

  ProductRepository()
      : _firestore = FirebaseFirestore.instance,
        _supabaseClient = Supabase.instance.client;

  Future<List<ProductModel>> getBestSellerProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('Products')
          .where("isBestSeller", isEqualTo: true)
          .get();

      if (snapshot.docs.isEmpty) {
        return const []; // Return an empty list if no documents found
      }

      return snapshot.docs
          .map((doc) {
            try {
              return ProductModel.fromJson(doc.data());
            } catch (e) {
              // Skip the item if mapping fails
              print('Skipping document ${doc.id} due to error: $e');
              return null;
            }
          })
          .whereType<ProductModel>() // Filters out null items
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch best sellers products: $e');
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Products').get();

      if (snapshot.docs.isEmpty) {
        return const []; // Return an empty list if no documents found
      }

      return snapshot.docs
          .map((doc) {
            try {
              return ProductModel.fromJson(doc.data());
            } catch (e) {
              // Skip the item if mapping fails
              print('Skipping document ${doc.id} due to error: $e');
              return null;
            }
          })
          .whereType<ProductModel>() // Filters out null items
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch best sellers products: $e');
    }
  }

  Future<ProductModel> getProduct({required String productId}) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Products').doc(productId).get();

      ProductModel product =
          ProductModel.fromJson(snapshot.data() as Map<String, dynamic>);

      return product;
    } catch (e) {
      throw Exception('Failed to fetch product with id $productId: $e');
    }
  }

  Future<List<ProductModel>> getAllProductsOfCategory(
      {String? categoryId}) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> snapshot;
      if (categoryId == null) {
        snapshot = await _firestore.collection('Products').get();
      } else {
        snapshot = await _firestore
            .collection('Products')
            .where("categoryId", isEqualTo: categoryId)
            .get();
      }

      if (snapshot.docs.isEmpty) {
        return const []; // Return an empty list if no documents found
      }

      return snapshot.docs
          .map((doc) {
            try {
              return ProductModel.fromJson(doc.data());
            } catch (e) {
              // Skip the item if mapping fails
              print('Skipping document ${doc.id} due to error: $e');
              return null;
            }
          })
          .whereType<ProductModel>() // Filters out null items
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch best sellers products: $e');
    }
  }

  /// Add a new product to Firestore
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('Products')
          .doc(product.id)
          .set(product.toJson());
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Failed to add product');
    }
  }

  /// Update an existing product in Firestore
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('Products')
          .doc(product.id)
          .update(product.toJson());
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product');
    }
  }

  /// Delete a product and its associated images
  Future<void> deleteProduct(
    ProductModel product,
  ) async {
    try {
      // 1. Delete product document from Firestore
      await _firestore.collection('Products').doc(product.id).delete();

      // 2. Extract file paths from Supabase URLs and delete images
      for (String url in product.images) {
        final filePath = _extractFilePath(url);
        await _supabaseClient.storage.from('images').remove([filePath]);
      }

      print('Product and associated images deleted successfully.');
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product and its images.');
    }
  }

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

  /// Extract file path from Supabase public URL
  String _extractFilePath(String publicUrl) {
    final basePath = _supabaseClient.storage.from('images').getPublicUrl('');
    return publicUrl.replaceFirst(basePath, '');
  }
}
