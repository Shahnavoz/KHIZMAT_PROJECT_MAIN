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
  int? maxLines,
  double fontSize=15
}) {
  return Text(
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    text,
    style: GoogleFonts.robotoFlex(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color,
    ),
    textAlign: textAlign,
  );
}

Widget textWithH2BlackStyle(
  String text, {
  TextAlign textAlign = TextAlign.center,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.black,
  int maxline=2
}) {
  return Text(
    text,
    style: GoogleFonts.robotoFlex(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      
    ),
    textAlign: textAlign,
    maxLines: maxline,
  );
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
    ),
  );
}



Widget scrollTextWithH1Style(
  String text, {
  TextAlign textAlign = TextAlign.start,
  Color color = Colors.black,
  double fontSize = 20,
  int maxLines = 2,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return SizedBox(
        height: fontSize * 0.5 * maxLines + 8,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent
              ],
              stops: [0.0, 0.05, 0.95, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.hardEdge,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text(
                  text,
                  maxLines: maxLines,
                  textAlign: textAlign,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    height: 1.2,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}



Widget smartScrollableLastLine(
  String text, {
  double fontSize = 18,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
  TextAlign textAlign = TextAlign.start,
  int maxLines = 3,            
  double extraRightPadding = 120.0, 
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final double lineHeight = fontSize * 1.2;
      final double totalHeight = lineHeight * maxLines;

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: GoogleFonts.ibmPlexSans(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 1.2,
            color: color,
          ),
        ),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: constraints.maxWidth);

      final bool textFits = textPainter.didExceedMaxLines == false;
      if (textFits) {
        return Text(
          text,
          style: GoogleFonts.ibmPlexSans(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 1.2,
            color: color,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      }
      return SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            Text(
              text,
              maxLines: maxLines - 1,
              style: GoogleFonts.ibmPlexSans(
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: 1.2,
                color: color,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: lineHeight + 4,
              child: ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                  stops: [0.0, 0.05, 0.95, 1.0],
                ).createShader(rect),
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(right: extraRightPadding),
                    child: Text(
                      text,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        height: 1.2,
                        color: color,
                      ),
                      maxLines: maxLines,
                      textAlign: textAlign,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}