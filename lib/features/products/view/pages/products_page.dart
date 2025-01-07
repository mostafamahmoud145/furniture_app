import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/category_products_list_view.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/main.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal:
                      (MediaQuery.sizeOf(context).width * 0.025).clamp(20, 50)),
              child: Center(
                child: Column(
                  children: [
                    /// <--- AppBar --->
                    CustomAppBar(),

                    /// <--- Vertical spacing --->
                    SizedBox(height: 20),

                    /// <--- What Are You Looking For Text --->
                    Text(
                      "What Are You Looking For?",
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(
                          context,
                          fontSize: 25,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// <--- Vertical spacing --->
                    const SizedBox(height: 20),

                    /// <--- Search Bar and Search Button --->
                    const SearchBarAndSearchButton(),

                    /// <--- Vertical spacing --->
                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category: Chairs",
                          style: TextStyle(
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(245, 246, 250, 1.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.sort),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "sort by",
                                  style: TextStyle(
                                    fontSize: getResponsiveFontSize(context,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    /// <--- Vertical spacing --->
                    const SizedBox(height: 40),

                    /// <--- Products List View --->
                    const CategoryProductsListView(),
                  ],
                ),
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

class SearchBarAndSearchButton extends StatelessWidget {
  const SearchBarAndSearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width * 0.8).clamp(100, 800),
      child: const IntrinsicHeight(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// <--- Search Bar --->
            Expanded(child: CustomSearchBar()),

            /// <--- Horizontal spacing --->
            SizedBox(
              width: 16,
            ),

            /// <--- Search Button --->
            SearchButton(),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.sizeOf(context).width * 0.1).clamp(20, 60),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Handle search logic here
                print("Search query: $value");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance
            .collection("Products")
            .add({"name": "chair"}).then((onValue) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product Was Added Successully")));
        }).catchError((error) {
          print("Error: $error");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed To Add Product $error")));
        });
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffb518581),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            "Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
