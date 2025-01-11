import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/data/repos/banner_repository.dart';
import 'package:furniture_app/features/dashboard/products/view/components/dialogs/delete_confirmation_dialog.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:go_router/go_router.dart';

class ViewBannersPage extends StatefulWidget {
  const ViewBannersPage({super.key});

  @override
  State<ViewBannersPage> createState() => _ViewBannersPageState();
}

class _ViewBannersPageState extends State<ViewBannersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Banners'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              /// Navigate to add banner page
              GoRouter.of(context).push(RoutersNames.addBanner);
            },
          )
        ],
      ),
      body: FirestorePagination(
        isLive: true,
        query: FirebaseFirestore.instance.collection('Banners'),
        separatorBuilder: (p0, p1) => const Divider(),
        itemBuilder: (context, document, index) {
          try {
            /// Convert the document to a banner model
            BannerModel bannerModel = BannerModel.fromJson(
                document[index].data() as Map<String, dynamic>);

            /// Item Builder
            return ListTile(
              onTap: () {
                /// Navigate to the add banner page
                GoRouter.of(context)
                    .push(RoutersNames.addBanner, extra: bannerModel);
              },
              title: Text("ID: ${bannerModel.id}"),
              leading: FadeInImage.assetNetwork(
                placeholder: 'assets/icons/load.gif',
                image: bannerModel.imageUrl,
                height: 150,
                width: 150,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  /// Show the delete confirmation dialog
                  showDeleteConfirmationDialog(
                    context: context,
                    name: bannerModel.id,
                    onConfirm: () {
                      BannerRepository().deleteBanner(bannerModel);
                    },
                  );
                },
              ),
            );
          } catch (e) {
            return const SizedBox();
          }
        },
        onEmpty: const Center(child: Text('No banners found')),
      ),
    );
  }
}
