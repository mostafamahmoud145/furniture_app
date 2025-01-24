import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/widgets/product_list_view_item.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount;
      if (width <= 450) {
        crossAxisCount = 1;
      } else if (width <= 770) {
        crossAxisCount = 2;
      } else if (width <= 1000) {
        crossAxisCount = 3;
      } else {
        crossAxisCount = 4;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItemWidget(
            product: products[index],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: width <= 1500 ? 20 : 40,
          childAspectRatio: 5 / 6.5,
        ),
      );
    });
  }
}
