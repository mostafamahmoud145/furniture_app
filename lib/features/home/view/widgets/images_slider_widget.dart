import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AutoImageSlider extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs

  const AutoImageSlider({super.key, required this.imageUrls});

  @override
  State<AutoImageSlider> createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  /// <--- Page Controller --->
  final PageController _pageController = PageController(initialPage: 0);

  /// <--- Current Page --->
  int _currentPage = 0;

  /// <--- Timer for Auto Slide --->
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    /// <--- Start Auto Slide --->
    if (widget.imageUrls.length > 1) {
      _startAutoSlide();
    }

    /// <--- Page Controller Listener --->
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  /// <--- Start Auto Slide Function --->
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first image after the last
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();

    // Dispose the PageController
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// <--- Image Slider --->
        Expanded(
          child: _ImageSlider(pageController: _pageController, widget: widget),
        ),

        /// <--- Vertical spacing --->
        const SizedBox(height: 10),

        /// <--- Page Indicator --->
        _PageIndicator(widget: widget, currentPage: _currentPage),
      ],
    );
  }
}

/// <--- Image Slider --->
class _ImageSlider extends StatelessWidget {
  const _ImageSlider({
    required PageController pageController,
    required this.widget,
  }) : _pageController = pageController;

  final PageController _pageController;
  final AutoImageSlider widget;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 5.5,
      child: PageView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: widget.imageUrls[index],
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },
      ),
    );
  }
}

/// <--- Page Indicator --->
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.widget,
    required int currentPage,
  }) : _currentPage = currentPage;

  final AutoImageSlider widget;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xffb518581)
                : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
