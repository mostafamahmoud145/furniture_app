import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() {
              _isHovered = true;
            }),
            onExit: (_) => setState(() {
              _isHovered = false;
            }),
            child: Stack(
              children: [
                /// Main Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/test.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity, // Makes the image responsive
                    ),
                  ),
                ),

                /// Overlay Shadow and Text (Only on Image)
                if (_isHovered)
                  Positioned.fill(
                    child: InkWell(
                      onTap: () {},
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
        const SizedBox(
          height: 15,
        ),
        const AutoSizeText(
          "Chairs For Salon",
          maxLines: 2,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
