import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/main.dart';

class PageNote extends StatefulWidget {
  const PageNote({super.key});

  @override
  State<PageNote> createState() => _PageNoteState();
}

class _PageNoteState extends State<PageNote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _arrowSlideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _arrowSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start off-screen to the left
      end: Offset.zero, // Slide to original position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// <--- Arrow Icon with Slide Animation --->
        SlideTransition(
          position: _arrowSlideAnimation,
          child: SvgPicture.asset(
            "icons/title_arrow.svg",
            height: (MediaQuery.sizeOf(context).width * 0.09).clamp(60, 90),
            width: (MediaQuery.sizeOf(context).width * 0.04).clamp(60, 90),
          ),
        ),

        /// <--- Text with Fade Animation --->
        FadeTransition(
          opacity: _textFadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // Start from below
                  end: Offset.zero, // Slide into place
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOut,
                )),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 30),
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                    children: [
                      /// <--- Sliding Text -->
                      const TextSpan(text: 'Discover Furniture With\n'),
                      const TextSpan(text: 'High Quality Wood '),

                      /// <--- Rotating Star Icon -->
                      WidgetSpan(
                        child: RotationTransition(
                          turns: Tween<double>(
                            begin: 0.0,
                            end: 1.0, // 360-degree rotation
                          ).animate(CurvedAnimation(
                            parent: _controller,
                            curve: Curves
                                .elasticOut, // Elastic effect for rotation
                          )),
                          child: Icon(
                            Icons.auto_awesome,
                            color: Colors.orange,
                            size: (MediaQuery.sizeOf(context).width * 0.03)
                                .clamp(32, 70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
