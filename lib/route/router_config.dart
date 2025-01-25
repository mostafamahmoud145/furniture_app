import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/banners/view/pages/add_banner_page.dart';
import 'package:furniture_app/features/dashboard/banners/view/pages/view_banners_page.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/view/pages/add_category_page.dart';
import 'package:furniture_app/features/dashboard/categories/view/pages/view_categories_page.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/get_categories_cubit/get_categories_cubit.dart';
import 'package:furniture_app/features/dashboard/dashboard_page.dart';
import 'package:furniture_app/features/dashboard/login_page.dart';
import 'package:furniture_app/features/home/view/pages/home_page.dart';
import 'package:furniture_app/features/home/view_model/get_banners_cubit/get_banners_cubit.dart';
import 'package:furniture_app/features/home/view_model/get_best_seller_products_cubit/get_best_seller_products_cubit.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/dashboard/products/view/pages/add_product_page.dart';
import 'package:furniture_app/features/dashboard/products/view/pages/view_products_page.dart';
import 'package:furniture_app/features/products/view/pages/product_details_page.dart';
import 'package:furniture_app/features/products/view/pages/products_page.dart';
import 'package:furniture_app/features/products/view_model/get_all_products_of_category_cubit/get_all_products_of_category_cubit.dart';
import 'package:furniture_app/features/products/view_model/get_product_cubit/get_product_cubit.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  GoRouter router = GoRouter(
    initialLocation: '/', // Set initial location if not done
    routes: [
      GoRoute(
        path: '/',
        name: RoutersNames.home,
        pageBuilder: (context, state) => MaterialPage(
            child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetBannersCubit()..getBanners(),
            ),
            BlocProvider(
              create: (context) => GetCategoriesCubit()..getCategories(),
            ),
            BlocProvider(
              create: (context) =>
                  GetBestSellerProductsCubit()..getBestSellerProducts(),
            ),
          ],
          child: const HomePage(),
        )),
      ),
      GoRoute(
          path: '/products/:id/:categoryName',
          name: RoutersNames.products,
          builder: (context, state) {
            String? categoryId = state.pathParameters['id'];
            String? categoryName = state.pathParameters['categoryName'];

            return BlocProvider(
              create: (context) => GetAllProductsOfCategoryCubit()
                ..getAllProductsOfCategory(categoryId: categoryId),
              child: ProductsPage(
                categoryName: categoryName,
                categoryId: categoryId,
              ),
            );
          }),
      GoRoute(
          path: '/productDetails/:id',
          name: RoutersNames.productDetails,
          builder: (context, state) {
            String productId = state.pathParameters['id']!;
            return BlocProvider(
              create: (context) =>
                  GetProductCubit()..getProduct(productId: productId),
              child: const ProductDetailsPage(),
            );
          }),
      GoRoute(
          path: '/addProduct',
          name: RoutersNames.addProduct,
          pageBuilder: (context, state) {
            ProductModel? args;
            if (state.extra != null) {
              if (state.extra is ProductModel) {
                args = state.extra as ProductModel;
              }
            }
            return MaterialPage(
                child: AddProductPage(
              product: args,
            ));
          }),
      GoRoute(
          path: '/addCategory',
          name: RoutersNames.addCategory,
          pageBuilder: (context, state) {
            CategoryModel? args;
            if (state.extra != null) {
              if (state.extra is CategoryModel) {
                args = state.extra as CategoryModel;
              }
            }
            return MaterialPage(
                child: AddCategoryPage(
              category: args,
            ));
          }),
      GoRoute(
          path: '/addBanner',
          name: RoutersNames.addBanner,
          pageBuilder: (context, state) {
            BannerModel? args;
            if (state.extra != null) {
              if (state.extra is BannerModel) {
                args = state.extra as BannerModel;
              }
            }
            return MaterialPage(
                child: AddBannerPage(
              banner: args,
            ));
          }),
      GoRoute(
        path: '/viewProducts',
        name: RoutersNames.viewProducts,
        pageBuilder: (context, state) =>
            const MaterialPage(child: ViewProductsPage()),
      ),
      GoRoute(
        path: '/viewCategories',
        name: RoutersNames.viewCategories,
        pageBuilder: (context, state) =>
            const MaterialPage(child: ViewCategoriesPage()),
      ),
      GoRoute(
        path: '/viewBanners',
        name: RoutersNames.viewBanners,
        pageBuilder: (context, state) =>
            const MaterialPage(child: ViewBannersPage()),
      ),
      GoRoute(
        path: '/dashboard',
        name: RoutersNames.dashboard,
        pageBuilder: (context, state) =>
            const MaterialPage(child: DashboardPage()),
      ),
      GoRoute(
        path: '/7777',
        name: RoutersNames.login,
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
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
