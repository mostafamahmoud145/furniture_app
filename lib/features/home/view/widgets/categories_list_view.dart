import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/features/home/view/widgets/category_list_view_item.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount;

      if (width <= 550) {
        crossAxisCount = 2;
      } else if (width <= 650) {
        crossAxisCount = 3;
      } else if (width <= 900) {
        crossAxisCount = 4;
      } else if (width <= 1200) {
        crossAxisCount = 5;
      } else {
        crossAxisCount = 6;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    index / 4, // Stagger animation across grid items
                    1.0,
                    curve: Curves.easeOut,
                  ),
                ),
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      index / 4,
                      1.0,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: CategoryItemWidget(
              category: widget.categories[index],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 5 / 6.5,
        ),
      );
    });
  }
}
