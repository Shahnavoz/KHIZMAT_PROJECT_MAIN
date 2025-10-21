import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class ContainerAsButton extends StatelessWidget {
  const ContainerAsButton({
    super.key,
    required this.size,
    required this.text,
    required this.backGroundColor,
    this.textColor,
  });
  final AdaptiveSizes size;
  final String text;
  final Color backGroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.otstup15,
          vertical: size.otstup5,
        ),
        child: SizedBox(
          width: size.screenWidth*0.4,
          child: textWithH1Style(
            maxLines: 1,
            text,
            fontsize: 15,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
