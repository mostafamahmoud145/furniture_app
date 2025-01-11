import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/data/repos/category_repository.dart';
import 'package:furniture_app/features/dashboard/products/view/components/dialogs/delete_confirmation_dialog.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:go_router/go_router.dart';

class ViewCategoriesPage extends StatefulWidget {
  const ViewCategoriesPage({super.key});

  @override
  State<ViewCategoriesPage> createState() => _ViewCategoriesPageState();
}

class _ViewCategoriesPageState extends State<ViewCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              /// Navigate to add category page
              GoRouter.of(context).push(RoutersNames.addCategory);
            },
          )
        ],
      ),
      body: FirestorePagination(
        isLive: true,
        query: FirebaseFirestore.instance.collection('Categories'),
        separatorBuilder: (p0, p1) => const Divider(),
        itemBuilder: (context, document, index) {
          try {
            /// Convert the document to a category model
            CategoryModel categoryModel = CategoryModel.fromJson(
                document[index].data() as Map<String, dynamic>);

            /// Item Builder
            return ListTile(
              onTap: () {
                /// Navigate to the add category page
                GoRouter.of(context)
                    .push(RoutersNames.addCategory, extra: categoryModel);
              },
              title: Text("Name: ${categoryModel.name}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  /// Show the delete confirmation dialog
                  showDeleteConfirmationDialog(
                    context: context,
                    name: categoryModel.name,
                    onConfirm: () {
                      CategoryRepository().deleteCategory(categoryModel);
                    },
                  );
                },
              ),
            );
          } catch (e) {
            return const SizedBox();
          }
        },
        onEmpty: const Center(child: Text('No categories found')),
      ),
    );
  }
}
