import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/categories_list_view.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/features/home/view/widgets/images_slider_widget.dart';
import 'package:furniture_app/features/home/view/widgets/page_note_widget.dart';
import 'package:furniture_app/features/home/view/widgets/products_list_view.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal:
                      (MediaQuery.sizeOf(context).width * 0.025).clamp(20, 50)),
              child: CustomAppBar(),
            ),

            /// <--- Image Slider --->
            SizedBox(
              height: (MediaQuery.sizeOf(context).width * 0.4),
              child: const AutoImageSlider(
                imageUrls: [
                  "https://cdn.shopify.com/s/files/1/0549/5806/3713/files/organic_modern_furniture.jpg?v=1704830139",
                  "https://c0.wallpaperflare.com/preview/405/811/666/interior-interior-design-furniture-contemporary.jpg"
                ],
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

                  const CategoriesListView(),

                  /// <--- Vertical spacing --->
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
                  ),

                  Container(
                      color: Color.fromARGB(
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
                          Text(
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

                          const ProductsListView(),

                          /// <--- Vertical spacing --->
                          SizedBox(
                            height: MediaQuery.sizeOf(context).width > 800
                                ? 40
                                : 20,
                          ),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View All",
                                style: TextStyle(fontSize: 30),
                              ),
                              Icon(
                                Icons.arrow_right_alt_outlined,
                                size: 30,
                              )
                            ],
                          )
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
