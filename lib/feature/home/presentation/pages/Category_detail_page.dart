import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/horizontal_scrollable_widget_for_detail_page.dart';

class CategoryDetailPage extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;

  const CategoryDetailPage({super.key, required this.categories});

  @override
  ConsumerState<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends ConsumerState<CategoryDetailPage> {
  final List<Map<Color, String>> docColors = [
    {const Color(0xFF5FB889): 'Паспорт'},
    {const Color(0xFF4A90E2): 'Водительское удостоверение'},
    {const Color(0xFFE94A4A): 'Свидетельство'},
  ];

  final int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: textWithH1Style(
          "Назад",
          fontW: FontWeight.w500,
          color: Colors.black,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(shape: const CircleBorder()),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/Rectangle 39820.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    // top: 75,
                    left: size.otstup20,
                    // right: size.otstup20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWithH1Style(
                                "Транспорт",
                                color: Colors.black,
                                fontsize: 20,
                              ),
                              SizedBox(height: size.otstup10),
                              SizedBox(
                                width: size.screenWidth * 0.66,
                                child: textCWithH2GreyStyle(
                                  "Электронная доверенность на право управления транспортным средством",
                                  textAlign: TextAlign.start,color: Colors.black54
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/Group 831885517.png",
                            width: size.screenWidth * 0.25,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      SizedBox(height: size.otstup25),
                      HorizontalScrollableWidgetForDetailPage(
                        categories: widget.categories,
                        size: size,
                        currentLocale: currentLocale,
                        selectedIndex: selectedIndex,
                        oneActiveColor: buttonsTitleGradient,
                        nonActiveColor: LinearGradient(
                          colors: [Color(0xFFFAFAFA), Colors.grey[200]!],
                        ),
                        activeTextColor: Colors.white,
                        nonActiveTextColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.otstup20,
                          right: size.otstup20,
                          left: size.otstup20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: greyTextFBorderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFAFAFA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      "assets/images/Union (1).png",
                                    ),
                                  ),
                                ),
                                title: textWithH1Style(
                                  "Электронная доверенность на право управления транспортным средством",
                                  textAlign: TextAlign.start,
                                  fontsize: 16,
                                  fontW: FontWeight.w500,
                                  maxLines: 3,
                                ),
                              );
                            },
                            separatorBuilder:
                                (context, index) =>
                                    Divider(color: greyTextFBorderColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
