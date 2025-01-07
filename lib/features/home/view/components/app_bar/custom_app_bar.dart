import 'package:flutter/material.dart';
import 'package:furniture_app/features/home/view/widgets/app_bar_choices_widget.dart';
import 'package:furniture_app/features/home/view/widgets/faramawy_title_and_logo_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// <--- Faramawy Logo and Title --->
        const FaramawyLogoAndTitle(),
    
        /// <--- AppBar Choices --->
        MediaQuery.sizeOf(context).width > 1200
            ? const AppBarChoicesForDesktop()
            : const Icon(
                Icons.menu,
                size: 30,
              ),
      ],
    );
  }
}