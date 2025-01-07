import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';

class FaramawyLogoAndTitle extends StatelessWidget {
  const FaramawyLogoAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// <--- Faramawy Logo --->
        const Icon(
          Icons.logo_dev,
          size: 50,
        ),

        /// <--- Horizontal spacing --->
        const SizedBox(
          width: 8,
        ),

        /// <--- Faramawy Title --->
        Text("El-Faramawy",
            style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize: 20))),
      ],
    );
  }
}
