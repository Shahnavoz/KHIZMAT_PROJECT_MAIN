import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class My_Button extends StatelessWidget {
  const My_Button({
    super.key,
    required this.size,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
    this.width,
    required this.onPressed,
    this.borderRadius=10
  });

  final AdaptiveSizes size;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double? width;
  final void Function()? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(color: borderColor),
          backgroundColor: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
