import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class Applicationcard extends StatelessWidget {
  final int count;
  const Applicationcard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: size.otstup15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF6FFFA), Color(0xFFFFFFFF)],
                stops: [0.0, 1.0],
              ),
              border: Border.all(color: greyBorderColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.otstup10,
                    vertical: size.otstup10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: greyBorderColor),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup20,
                            vertical: size.otstup25,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/applicationCardIcon.svg",
                            width: size.imageSize60,
                          ),
                        ),
                      ),
                      SizedBox(width: size.otstup10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWithH2BlackStyle(
                              "Архитектура и градостроительство",
                              maxline: 1,
                              textAlign: TextAlign.start,
                            ),
                            textCWithH2GreyStyle(
                              "Разрешение на начало строительных работ",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: size.otstup10),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: greyBorderColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFFF6FFFA),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.otstup10,
                                      vertical: 3,
                                    ),
                                    child: textWithH2BlackStyle(
                                      "На рассмотрении",
                                      color: primaryGreenColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup10),
                                Row(
                                  children: [
                                    textWithH1Style(
                                      "100с",
                                      fontsize: 15,
                                      color: primaryGreenColor,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.otstup5,
                                      ),
                                      child: textWithH1Style(
                                        "из",
                                        fontsize: 15,
                                        color: Color(0xFF686868),
                                      ),
                                    ),
                                    textWithH1Style(
                                      "400с",
                                      fontsize: 15,
                                      color: Color(0xFF686868),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
