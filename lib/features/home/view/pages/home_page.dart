import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/dashboard/banners/data/model/banner_model.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/dashboard/categories/view_model/get_categories_cubit/get_categories_cubit.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/categories_list_view.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/features/home/view/widgets/images_slider_widget.dart';
import 'package:furniture_app/features/home/view/widgets/page_note_widget.dart';
import 'package:furniture_app/features/home/view/widgets/products_list_view.dart';
import 'package:furniture_app/features/home/view_model/get_banners_cubit/get_banners_cubit.dart';
import 'package:furniture_app/features/home/view_model/get_best_seller_products_cubit/get_best_seller_products_cubit.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// <--- Padding --->
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// <--- AppBar --->
            const Padding(
              padding: EdgeInsets.only(
                bottom: 0,
              ),
              child: CustomAppBar(),
            ),

            /// <--- Image Slider --->
            SizedBox(
              height: (MediaQuery.sizeOf(context).width * 0.4),
              child: BlocBuilder(
                bloc: BlocProvider.of<GetBannersCubit>(context),
                builder: (context, state) {
                  if (state is GetBannersError) {
                    return const Center(
                      child: SizedBox(),
                    );
                  }
                  List<BannerModel> banners = [];
                  if (state is GetBannersSuccess) {
                    banners = state.banners;
                  }
                  return Skeletonizer(
                    enabled: state is GetBannersLoading,
                    child: AutoImageSlider(
                      imageUrls: banners.map((e) => e.imageUrl).toList(),
                    ),
                  );
                },
              ),
            ),

            /// <--- Vertical spacing --->
            const SizedBox(
              height: 25,
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.sizeOf(context).width * 0.025).clamp(20, 50),
              ),
              child: Column(
                children: [
                  /// <--- Page Note --->
                  const PageNote(),

                  /// <--- Vertical spacing --->
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width > 800 ? 60 : 30,
                  ),

                  BlocBuilder(
                    bloc: BlocProvider.of<GetCategoriesCubit>(context),
                    builder: (context, state) {
                      if (state is GetCategoriesError) {
                        return const Center(
                          child: SizedBox(),
                        );
                      }

                      List<CategoryModel> categories = [];
                      if (state is GetCategoriesSuccess) {
                        categories = state.categories;
                      }
                      return Skeletonizer(
                        enabled: state is GetCategoriesLoading,
                        child: CategoriesListView(
                          categories: categories,
                        ),
                      );
                    },
                  ),

                  /// <--- Vertical spacing --->
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
                  ),

                  Container(
                      color: const Color.fromARGB(
                        255,
                        216,
                        222,
                        217,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.sizeOf(context).width > 800 ? 50 : 20,
                          vertical: 50),
                      child: Column(
                        children: [
                          const Text(
                            "Best Selling Products",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50, // Adjust font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          /// <--- Vertical spacing --->
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width > 800
                                ? 40
                                : 20,
                          ),

                          BlocBuilder(
                            bloc: BlocProvider.of<GetBestSellerProductsCubit>(
                                context),
                            builder: (context, state) {
                              if (state is GetBestSellerProductsError) {
                                return const Center(
                                  child: SizedBox(),
                                );
                              }
                              List<ProductModel> products = [];
                              if (state is GetBestSellerProductsSuccess) {
                                products = state.products;
                              }
                              return Skeletonizer(
                                enabled: state is GetBestSellerProductsLoading,
                                child: ProductsListView(
                                  products: products,
                                ),
                              );
                            },
                          ),

                          /// <--- Vertical spacing --->
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width > 800
                                ? 40
                                : 20,
                          ),

                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "View All",
                          //       style: TextStyle(fontSize: 30),
                          //     ),
                          //     Icon(
                          //       Icons.arrow_right_alt_outlined,
                          //       size: 30,
                          //     )
                          //   ],
                          // )
                        ],
                      )),

                  /// <--- Vertical spacing --->
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
                  ),
                ],
              ),
            ),

            /// <--- Vertical spacing --->
            SizedBox(
              height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
