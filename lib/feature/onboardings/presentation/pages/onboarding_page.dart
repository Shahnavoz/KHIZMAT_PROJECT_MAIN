import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/onboardings/presentation/widgets/page_info.dart';
import 'package:khizmat_new/generated/l10n.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    List<Map<String, dynamic>> texts = [
      {
        "title": S.of(context).poluchay_uslugi_ne_vikhodya_iz_doma,
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
      {
        "title": "Что такое ИМЗО?",
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
      {
        "title": "Что такое eKhukumat",
        "subtitle":
            "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
      },
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              PageInfo(
                controller: _controller,
                size: size,
                currentPage: currentPage,
                texts: texts,
                index: 1,
              ),
              PageInfo(
                controller: _controller,
                size: size,
                currentPage: currentPage,
                texts: texts,
                index: 2,
              ),
              PageInfo(
                controller: _controller,
                size: size,
                currentPage: currentPage,
                texts: texts,
                index: 3,
              ),
              // Container(width: 200, height: 300, color: Colors.redAccent),
              // Container(width: 200, height: 300, color: Colors.greenAccent),
              // Container(width: 200, height: 300, color: Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }
}
