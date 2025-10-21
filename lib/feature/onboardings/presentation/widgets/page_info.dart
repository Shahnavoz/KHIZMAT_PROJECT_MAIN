import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_enter_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my_animated_dot_indicator.dart';

class PageInfo extends StatelessWidget {
  const PageInfo({
    super.key,
    required this.size,
    required this.currentPage,
    required this.texts,
    required this.index,
    required this.controller,
  });

  final AdaptiveSizes size;
  final int currentPage;
  final List<Map<String,dynamic>> texts;
  final int index;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.screenWidth * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/circle_box_with_Star.png"),
          Column(
            children: [
              MyAnimatedDotIndicator(currentPage: index - 1, texts: texts,dotHeight: 13,dotWidth: 13,),
              SizedBox(height: 25),
              textWithH1Style(
                "Получайте доступ к услугам в одном приложении",
              ),
              SizedBox(height: 15),
              textWithH2BlackStyle(
                "Зарегистрироваться зарегистрироваться Зарегистрироваться",
              ),
            ],
          ),
          My_Button(
            onPressed: () {
              if (index < 3) {
                controller.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              }
              if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainEnterPage()),
                );
              }
              print("My index is: $index");
            },
            width: double.infinity,
            size: size,
            backgroundColor: primaryButtonColor,
            borderColor: greenButtonBorderColor,
            child: buttonWhiteTextStyle("Далее"),
          ),
        ],
      ),
    );
  }
}
