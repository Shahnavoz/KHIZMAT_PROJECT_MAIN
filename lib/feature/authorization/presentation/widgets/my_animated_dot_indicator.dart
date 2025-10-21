import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyAnimatedDotIndicator extends StatelessWidget {
  const MyAnimatedDotIndicator({
    super.key,
    required this.currentPage,
    required this.texts,
    this.dotHeight=10,
    this.dotWidth=10,
  });

  final int currentPage;
  final List<Map<String,dynamic>> texts;
  final double dotWidth;
  final double dotHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentPage,
      count: texts.length,
      effect: SwapEffect(
        dotWidth: dotWidth,
        dotHeight: dotHeight,
        activeDotColor: primaryButtonColor,
        dotColor: const Color.fromARGB(255, 208, 219, 214),
      ),
    );
  }
}
