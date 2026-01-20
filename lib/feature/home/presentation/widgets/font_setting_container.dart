import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class FontSettingContainer extends StatelessWidget {
  const FontSettingContainer({super.key, required this.size});

  final AdaptiveSizes size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyBorderColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.otstup5,
          vertical: size.otstup5,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyBorderColor),
                shape: BoxShape.circle,
                color: Color(0xFFEBFFF3),
              ),
              child: Icon(Icons.add, color: primaryGreenColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.otstup15),
              child: Text("Aaa", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyBorderColor),
                shape: BoxShape.circle,
                color: Color(0xFFEBFFF3),
              ),
              child: Icon(Icons.remove, color: primaryGreenColor),
            ),
          ],
        ),
      ),
    );
  }
}
