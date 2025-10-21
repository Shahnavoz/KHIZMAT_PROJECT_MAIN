import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class ButtonOrContainerWithTwoParts extends StatelessWidget {
  const ButtonOrContainerWithTwoParts({
    super.key,
    required this.size,
    required this.partOneWidget,
    required this.partTwoWidget,
    required this.backGroundColor,
    required this.oneSideBorderColor,
    this.horizontalPadPartOne,
    this.borderRadius,
  });

  final AdaptiveSizes size;
  final Widget partOneWidget;
  final Widget partTwoWidget;
  final Color backGroundColor;
  final Color oneSideBorderColor;
  final double? horizontalPadPartOne;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
        color: backGroundColor,
        border: Border.all(color: oneSideBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: size.screenHeight * 0.065,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: oneSideBorderColor)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: horizontalPadPartOne ?? 15,
              ),
              child: partOneWidget,
            ),
          ),

          partTwoWidget,
        ],
      ),
    );
  }
}




