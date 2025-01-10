import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/products/view/components/dialogs/delete_confirmation_dialog.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/dashboard/products/data/repos/product_repository.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:go_router/go_router.dart';

class ViewProductsPage extends StatefulWidget {
  const ViewProductsPage({super.key});

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              /// Navigate to add product page
              GoRouter.of(context).push(RoutersNames.addProduct);
            },
          )
        ],
      ),
      body: FirestorePagination(
        isLive: true,
        query: FirebaseFirestore.instance.collection('Products'),
        separatorBuilder: (p0, p1) => const Divider(),
        itemBuilder: (context, document, index) {
          try {
            /// Convert the document to a product model
            ProductModel product = ProductModel.fromJson(
                document[index].data() as Map<String, dynamic>);

            /// Item Builder
            return ListTile(
              onTap: () {
                /// Navigate to the add product page
                GoRouter.of(context)
                    .push(RoutersNames.addProduct, extra: product);
              },
              title: Text("Code: ${product.productCode}"),
              subtitle: Text("Name: ${product.name}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  /// Show the delete confirmation dialog
                  showDeleteConfirmationDialog(
                    context: context,
                    name: product.productCode,
                    onConfirm: () {
                      ProductRepository().deleteProduct(product);
                    },
                  );
                },
              ),
            );
          } catch (e) {
            return const SizedBox();
          }
        },
        onEmpty: const Center(child: Text('No products found')),
      ),
    );
  }
}
