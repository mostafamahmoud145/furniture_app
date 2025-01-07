import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/widgets/category_product_list_view_item.dart';

class CategoryProductsListView extends StatelessWidget {
  const CategoryProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "images/1.png",
      "images/2.png",
      "images/3.png",
      "images/4.png",
      "images/5.png",
      "images/6.png",
      "images/7.png",
      "images/8.png",
      "images/9.png",
      "images/10.png",
      "images/11.png",
    ];
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      print("width: $width");
      int crossAxisCount;
      if (width <= 770) {
        crossAxisCount = 2;
      } else if (width <= 1000) {
        crossAxisCount = 3;
      } else {
        crossAxisCount = 4;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 11,
        itemBuilder: (context, index) {
          return CategoryProductItemWidget(
            imageUrl: images[index],
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
