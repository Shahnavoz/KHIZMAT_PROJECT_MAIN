import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Category_detail_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/all_categories_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/new_home_page.dart';

class MainCategoryServicesPage extends ConsumerWidget {
  const MainCategoryServicesPage({
    super.key,
    required this.size,
    required this.categories,
    required this.documents,
    this.leftWidget,
    this.rightWidget,
    this.height,
    this.itemCount,
  });

  final AdaptiveSizes size;
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final double? height;
  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final query = ref.watch(queryProvider);
    final filtredCategories =
        categories.where((category) {
          final title = category.title.getText(currentLocale).toLowerCase();
          return title.contains(query);
        }).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftWidget ?? Text(""),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AllCategoriesPage(
                          categories: categories,
                          documents: documents,
                        ),
                  ),
                );
              },
              child: rightWidget ?? Text(""),
            ),
          ],
        ),

        SizedBox(height: height ?? size.otstup15),
        Container(
          padding: EdgeInsets.symmetric(vertical: size.otstup10),
          decoration: BoxDecoration(
            border: Border.all(color: greyTextFBorderColor),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          // height: 300,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemCount ?? 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final docId = documents[index].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CategoryDetailPage(
                            categories: categories,
                            category: categories[index],
                            documents: documents,
                            docId: docId,
                          ),
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
                              color:
                                  index % 2 == 0
                                      ? primaryGreenColor
                                      : secondaryGreenColor,
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
                              color:
                                  index % 2 == 0
                                      ? primaryGreenColor
                                      : secondaryGreenColor,
                            ),
                            child: Image.asset(
                              "assets/icons/Union (2).png",
                              width: size.imageSize50,
                              // color: Colors.white,
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
