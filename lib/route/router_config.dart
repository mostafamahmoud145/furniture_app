import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/view/pages/add_banner_page.dart';
import 'package:furniture_app/features/dashboard/banners/view/pages/view_banners_page.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/view/pages/add_category_page.dart';
import 'package:furniture_app/features/dashboard/categories/view/pages/view_categories_page.dart';
import 'package:furniture_app/features/home/view/pages/home_page.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/dashboard/products/view/pages/add_product_page.dart';
import 'package:furniture_app/features/products/view/pages/product_details_page.dart';
import 'package:furniture_app/features/products/view/pages/products_page.dart';
import 'package:furniture_app/features/dashboard/products/view/pages/view_products_page.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:furniture_app/screen1.dart';
import 'package:furniture_app/screen1_section1.dart';
import 'package:furniture_app/screen2.dart';
import 'package:furniture_app/screen3.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  GoRouter router = GoRouter(
    initialLocation: '/', // Set initial location if not done
    routes: [
      // GoRoute(
      //   path: '/',
      //   name: RoutersNames.home,
      //   pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      // ),

      // GoRoute(
      //   path: '/',
      //   name: RoutersNames.products,
      //   pageBuilder: (context, state) =>
      //       const MaterialPage(child: ProductsPage()),
      // ),

      // GoRoute(
      //   path: '/',
      //   name: RoutersNames.products,
      //   pageBuilder: (context, state) =>
      //       const MaterialPage(child: ProductDetailsPage()),
      // ),

      GoRoute(
          path: '/addProduct',
          name: RoutersNames.addProduct,
          pageBuilder: (context, state) {
            var args = state.extra != null ? state.extra as ProductModel : null;
            return MaterialPage(
                child: AddProductPage(
              product: args,
            ));
          }),

      GoRoute(
          path: '/addCategory',
          name: RoutersNames.addCategory,
          pageBuilder: (context, state) {
            var args =
                state.extra != null ? state.extra as CategoryModel : null;
            return MaterialPage(
                child: AddCategoryPage(
              category: args,
            ));
          }),

      GoRoute(
          path: '/addBanner',
          name: RoutersNames.addBanner,
          pageBuilder: (context, state) {
            var args = state.extra != null ? state.extra as BannerModel : null;
            return MaterialPage(
                child: AddBannerPage(
              banner: args,
            ));
          }),

      // GoRoute(
      //   path: '/',
      //   name: RoutersNames.viewProducts,
      //   pageBuilder: (context, state) =>
      //       const MaterialPage(child: ViewProductsPage()),
      // ),

      // GoRoute(
      //   path: '/',
      //   name: RoutersNames.viewCategories,
      //   pageBuilder: (context, state) =>
      //       const MaterialPage(child: ViewCategoriesPage()),
      // ),

      GoRoute(
        path: '/',
        name: RoutersNames.viewBanners,
        pageBuilder: (context, state) =>
            const MaterialPage(child: ViewBannersPage()),
      ),

      GoRoute(
          path: '/screen1',
          name: RoutersNames.screen1,
          pageBuilder: (context, state) => const MaterialPage(child: Screen1()),
          routes: [
            GoRoute(
              path: 'section1',
              name: RoutersNames.screen1Section1,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: Screen1Section1()),
            ),
          ]),
      GoRoute(
        path: '/screen2',
        name: RoutersNames.screen2,
        pageBuilder: (context, state) => const MaterialPage(child: Screen2()),
      ),
      GoRoute(
        path: '/screen3',
        name: RoutersNames.screen3,
        pageBuilder: (context, state) => const MaterialPage(child: Screen3()),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Error: ${state.error.toString()}',
        ),
      ),
    ),
  );
}
