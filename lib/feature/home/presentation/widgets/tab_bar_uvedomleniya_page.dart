import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class TabBarUvedomleniyaPage extends StatelessWidget {
  const TabBarUvedomleniyaPage({
    super.key,
    required this.size,
  });

  final AdaptiveSizes size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/Group 831885407.png',
            width: size.imageSize100,
          ),
          SizedBox(height: 20),
          SizedBox(
            child: Text(
              textAlign: TextAlign.center,
              "У вас нет новостей",
              style: h1Title,
              maxLines: 2,
            ),
          ),
          SizedBox(height: size.otstup20),
          SizedBox(
            width: size.screenWidth * 0.65,
            child: Text(
              textAlign: TextAlign.center,
              "Получайте доступ к услугам в одном приложении",
              style: h2TitleNotSoBold,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
