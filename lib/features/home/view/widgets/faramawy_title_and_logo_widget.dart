import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';

class FaramawyLogoAndTitle extends StatelessWidget {
  const FaramawyLogoAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffb518581),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// <--- Faramawy Logo --->
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "assets/icons/Logoo.png",
              height: 40,
              width: 40,
            ),
          ),

          /// <--- Horizontal spacing --->
          const SizedBox(
            width: 8,
          ),

          /// <--- Faramawy Title --->
          Text("Faramawy Trading Center",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: getResponsiveFontSize(context, fontSize: 20))),
        ],
      ),
    );
  }
}
