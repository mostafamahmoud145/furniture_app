import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/category_products_list_view.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/main.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, this.categoryId});
  final String? categoryId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String searchTerm = ""; // State to store the search term
  final TextEditingController _controller = TextEditingController();

  void updateSearch(String term) {
    setState(() {
      searchTerm = term;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: (MediaQuery.sizeOf(context).width * 0.025)
                          .clamp(20, 50)),
                  child: Center(
                    child: Column(
                      children: [
                        /// <--- AppBar --->
                        const CustomAppBar(),

                        /// <--- Vertical spacing --->
                        const SizedBox(height: 20),

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
                        SearchBarAndSearchButton(
                          controller: _controller,
                          onSearch:
                              updateSearch, // Pass the updateSearch function
                        ),

                        /// <--- Vertical spacing --->
                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category: Chairs",
                              style: TextStyle(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromRGBO(245, 246, 250, 1.0),
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
                      ],
                    ),
                  ),
                ),

                /// <--- Vertical spacing --->
                SizedBox(
                  height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
                ),
              ],
            ),
          ),
          CategoryProductsListView(
            categoryId: widget.categoryId,
            searchTerm: searchTerm,
          ),

          /// <--- Vertical spacing --->
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          /// <--- Footer --->
          const SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }
}

class SearchBarAndSearchButton extends StatelessWidget {
  final void Function(String) onSearch;
  final TextEditingController _controller;

  const SearchBarAndSearchButton(
      {super.key,
      required this.onSearch,
      required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width * 0.8).clamp(100, 800),
      child: IntrinsicHeight(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// <--- Search Bar --->
            Expanded(child: CustomSearchBar(controller: _controller)),

            /// <--- Horizontal spacing --->
            const SizedBox(
              width: 16,
            ),

            /// <--- Search Button --->
            SearchButton(
              onSearch: onSearch,
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.sizeOf(context).width * 0.1)
          .clamp(40, 60), // Adjusted minimum height to 40
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center content vertically
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: getResponsiveFontSize(context, fontSize: 18),
                ),
              ),
              style: TextStyle(
                  fontSize: getResponsiveFontSize(context, fontSize: 18)),
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
  const SearchButton(
      {super.key, required this.onSearch, required this.controller});

  final void Function(String) onSearch;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSearch(controller.text); // Pass the search term
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
