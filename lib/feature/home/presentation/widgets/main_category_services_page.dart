import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Category_detail_page.dart';

class MainCategoryServicesPage extends ConsumerWidget {
  const MainCategoryServicesPage({
    super.key,
    required this.size,
    required this.categories,
  });

  final AdaptiveSizes size;
  final List<CategoryElement> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textWithH1Style("Категории услуг"),
            Text('Все категории', style: h2TitleNotSoBold),
          ],
        ),

        SizedBox(height: size.otstup15),
        Container(
          padding: EdgeInsets.symmetric(vertical: size.otstup10),
          decoration: BoxDecoration(
            border: Border.all(color: greyTextFBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          // height: 300,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailPage(categories: categories,),
                    ),
                  );
                },
                child: ListTile(
                  leading:
                      categories[index].iconId != null
                          ? Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              shape: BoxShape.circle,
                              color: primaryButtonColor,
                            ),

                            child: Image.network(
                              categories[index].iconId!,
                              width: size.imageSize50,
                              color: Colors.white,
                            ),
                          )
                          : Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              shape: BoxShape.circle,
                              color: primaryButtonColor,
                            ),
                            child: Image.asset(
                              "assets/icons/Group 831885407.png",
                              width: size.imageSize50,
                            ),
                          ),
                  title: textWithH1Style(
                    maxLines: 1,
                    fontsize: 16,
                    categories[index].title.getText(currentLocale),
                    textAlign: TextAlign.start,
                  ),
                ),
              );
            },
            separatorBuilder:
                (BuildContext context, int index) =>
                    Divider(color: greyTextFBorderColor),
          ),
        ),
      ],
    );
  }
}
