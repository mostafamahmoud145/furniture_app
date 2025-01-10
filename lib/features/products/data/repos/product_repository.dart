import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository() : _firestore = FirebaseFirestore.instance;

  /// Add a new product to Firestore
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('Products').doc(product.id).set(product.toJson());
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Failed to add product');
    }
  }

  /// Update an existing product in Firestore
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection('Products').doc(product.id).update(product.toJson());
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product');
    }
  }
}
