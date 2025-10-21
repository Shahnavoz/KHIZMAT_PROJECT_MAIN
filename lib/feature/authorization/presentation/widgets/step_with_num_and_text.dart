import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_modal_bottom_sheet.dart';

class StepWithNumAndText extends StatelessWidget {
  const StepWithNumAndText({
    super.key,
    required this.widget,
    this.secondText,
    required this.textNumber,
    required this.mainTitle,
    this.greyLine,
  });

  final ButtonModalBottomSheet widget;
  final Widget? secondText;
  final String textNumber;
  final String mainTitle;
  final Widget? greyLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greenButtonBorderColor),
                shape: BoxShape.circle,
                color: primaryButtonColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // SizedBox(height: widget.size.screenHeight * 0.010),
            greyLine?? SizedBox.shrink(),
            SizedBox(height: widget.size.screenHeight * 0.015),

          ],
        ),
        SizedBox(width: widget.size.screenWidth * 0.02),
        Column(
          children: [
            SizedBox(
              width: widget.size.screenWidth * 0.8,
              child: Padding(
                padding:  EdgeInsets.only(top: 8),
                child: textH2GreyTitle(
                  textColor: lightBlackTextColor,
                  fontWeight: FontWeight.w100,
                  mainTitle,
                ),
              ),
            ),
            secondText ?? Text(""),
          ],
        ),
      ],
    );
  }
}
