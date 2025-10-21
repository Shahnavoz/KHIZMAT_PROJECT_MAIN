import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/different_providers.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class MainPageCategoryServices extends ConsumerStatefulWidget {
  const MainPageCategoryServices({super.key, required this.size});
  final AdaptiveSizes size;
  @override
  ConsumerState<MainPageCategoryServices> createState() =>
      _MainPageCategoryServicesState();
}
class _MainPageCategoryServicesState
    extends ConsumerState<MainPageCategoryServices> {
  List<String> items = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'w',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
  ];
  @override
  Widget build(BuildContext context) {
    final seeProvider = ref.watch(seeAllProviders);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWithH1Style("Категории услуг"),
        SizedBox(
          height: widget.size.screenHeight * 0.9,
          child: GridView.builder(
            itemCount: 5,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: widget.size.otstup20,
              crossAxisSpacing: 10,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  gradient: borderLinearGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin: EdgeInsets.all(3.3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 45,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFF00C0E2),
                        Color(0xFFFFFFFF),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size.otstup15,
                      vertical: widget.size.otstup15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/Group 831885407.png"),
                        SizedBox(width: widget.size.otstup10),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                // items[index],
                                "Архитектура и градостроительство",
                                style: categoryTextRobotoBoldTitle,
                                maxLines: 2,
                              ),
                              SizedBox(height: widget.size.otstup5),
                              SizedBox(
                                width: widget.size.screenWidth * 0.74,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Получайте доступ к услугам в одном.",
                                  style: categoryTextRobotoTitle,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
