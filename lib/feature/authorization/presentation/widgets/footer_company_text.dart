import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/generated/l10n.dart';

class FooterCompanyText extends StatelessWidget {
  const FooterCompanyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      S.of(context).bottom_text,
      style: TextStyle(color: primaryGreyTextColor, fontSize: 11),
    );
  }
}
