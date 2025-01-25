import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/features/dashboard/categories/data/model/category_model.dart';
import 'package:furniture_app/route/routes_names.dart';
import 'package:go_router/go_router.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool _isHovered = false;

  void _handleHover(bool hoverState) {
    if (kIsWeb) {
      // Only handle hover state for web
      setState(() {
        _isHovered = hoverState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(RoutersNames.products,
                  pathParameters: {
                    "id": widget.category.id,
                    "categoryName": widget.category.name
                  });
            },
            child: MouseRegion(
              onEnter: (_) => _handleHover(true),
              onExit: (_) => _handleHover(false),
              child: Stack(
                children: [
                  /// Main Image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        image: widget.category.imageUrl,
                        fit: BoxFit.fill,
                        // width: double.infinity,
                        height: 150,
                        placeholder: "assets/icons/loading.gif",
                        placeholderFit: BoxFit.scaleDown,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text("Image not found!"));
                        },
                      ),
                    ),
                  ),

                  /// Overlay Shadow and Text (Only on Web Hover or Tap on Mobile)
                  if (_isHovered || !kIsWeb) // Always show on mobile tap
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          GoRouter.of(context).pushNamed(RoutersNames.products,
                              pathParameters: {
                                "id": widget.category.id,
                                "categoryName": widget.category.name
                              });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black
                                .withOpacity(0.5), // Semi-transparent shadow
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "View Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        AutoSizeText(
          widget.category.name,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
