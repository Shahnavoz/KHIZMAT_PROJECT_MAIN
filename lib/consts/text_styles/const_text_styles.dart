import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';

TextStyle h1Title = GoogleFonts.ibmPlexSans(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  height: 1.2,
);
TextStyle h1Title18 = GoogleFonts.ibmPlexSans(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  height: 1.2,
);
TextStyle h1RobotoTitle = GoogleFonts.roboto(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  // height: 1.2,
);
TextStyle wrapTextRobotoTitle = GoogleFonts.roboto(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
TextStyle categoryTextRobotoBoldTitle = GoogleFonts.roboto(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle categoryTextRobotoTitle = GoogleFonts.roboto(
  fontSize: 16,
  // fontWeight: FontWeight.normal,
);

TextStyle h2Title = GoogleFonts.robotoFlex(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  // height: 22,
);
TextStyle h2BoldTitle = GoogleFonts.robotoFlex(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  // height: 22,
);
TextStyle h2TitleNotSoBold = GoogleFonts.robotoFlex(
  fontSize: 15,
  // fontWeight: FontWeight.w300,
  // height: 15,
);
TextStyle h2TitleNotSoBlack = GoogleFonts.robotoFlex(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Color(0xFF4E4E4E),
  // height: 15,
);
TextStyle h2GreyTitle = GoogleFonts.robotoFlex(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  // height: 15,
  color: primaryGreyTextColor,
);
Widget textH2GreyTitle(
  String text, {
  Color textColor = primaryGreyTextColor,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    text,
    style: GoogleFonts.robotoFlex(
      fontSize: 15,
      fontWeight: fontWeight,
      // height: 15,
      color: textColor,
    ),
  );
}

Widget textWithH1Style(
  String text, {
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
  double fontsize = 20,
  int maxLines = 2,
  FontWeight fontW = FontWeight.bold,
}) {
  return Text(
    maxLines: maxLines,
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.ibmPlexSans(
      fontSize: fontsize,
      fontWeight: fontW,
      height: 1.2,
      color: color,
    ),
    textAlign: textAlign,
  );
}

Widget wrapTextH2Style(String text, {TextAlign textAlign = TextAlign.center}) {
  return Text(text, style: h1Title, textAlign: textAlign);
}

Widget textWithH2GreyStyle(
  String text, {
  TextAlign textAlign = TextAlign.center,
}) {
  return Text(text, style: h2GreyTitle, textAlign: textAlign);
}

Widget textCWithH2GreyStyle(
  String text, {
  TextAlign textAlign = TextAlign.center,
  Color color = primaryGreyTextColor,
  FontWeight fontweight = FontWeight.w400,
}) {
  return Text(
    text,
    style: GoogleFonts.robotoFlex(
      fontSize: 15,
      fontWeight: fontweight,
      // height: 15,
      color: color,
    ),
    textAlign: textAlign,
  );
}

Widget textWithH2BlackStyle(
  String text, {
  TextAlign textAlign = TextAlign.center,
  double fontSize=15,
  FontWeight fontWeight=FontWeight.bold
}) {
  return Text(text, style:  GoogleFonts.robotoFlex(
  fontSize: fontSize,
  fontWeight: fontWeight,
  // height: 22,
), textAlign: textAlign);
}

Widget buttonWhiteTextStyle(String text) {
  return Text(
    text,
    style: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}

Widget sameStyleDifColor(String text, {Color color = const Color(0xFF4E4E4E)}) {
  return Text(
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    text,
    style: GoogleFonts.robotoFlex(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color,
      // height: 15,
    ),
  );
}
