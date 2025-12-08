import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/shimmers/applications_shimmer.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/providers/category_provider.dart';

class CardPageForUvedomleni extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;

  const CardPageForUvedomleni({
    super.key,
    required this.categories,
    required this.documents,
  });
  @override
  _CardTestPageState createState() => _CardTestPageState();
}

class _CardTestPageState extends ConsumerState<CardPageForUvedomleni> {
  late List<int> indices; // Список индексов для категорий

  @override
  void initState() {
    super.initState();
    // Инициализируем индексы на основе категорий
    indices = List.generate(5, (index) => index);
  }

  void moveTopToBottom() {
    setState(() {
      final top = indices.removeLast(); // Берём верхний индекс
      indices.insert(0, top); // Вставляем в начало (вниз стека)
      // print('New order: $indices'); // Отладка (можно удалить позже)
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final asyncCategoryData = ref.watch(combinedCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
      // asyncCategoryData.when(
      //   data: (model) {
      //     return
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children:
              indices.asMap().entries.map((entry) {
                final index = entry.key;
                final categoryIndex = entry.value; // Индекс категории
                final category =
                    widget.categories[categoryIndex]; // Данные категории

                final documentIndex = entry.value;
                final document = widget.documents[documentIndex];
                // final subCategoryIndex = entry.value;
                // final subcategories =
                //     model.subcategoriesByCategory[widget
                //         .categories[index]
                //         .id] ??
                //     [];
                // final subCategory = subcategories[subCategoryIndex];

                final isTop = index == indices.length - 1;
                final scale = 1 - (indices.length - 1 - index) * 0.00;
                final verticalOffset = (indices.length - 1 - index) * 10.0;

                final cardWidget = Transform.translate(
                  offset: Offset(0, verticalOffset),
                  child: Transform.scale(
                    scale: scale,
                    // alignment: Alignment.topLeft,
                    child: buildCard(
                      document,
                      category,
                      size,
                      isTop,
                      categoryIndex,
                      currentLocale,
                      // subCategory,
                    ),
                  ),
                );

                if (isTop) {
                  return Dismissible(
                    resizeDuration: Duration(milliseconds: 2),
                    key: ValueKey(categoryIndex),
                    direction: DismissDirection.vertical,
                    onDismissed: (_) {
                      moveTopToBottom();
                    },
                    child: cardWidget,
                  );
                }

                return cardWidget;
              }).toList(),
        ),
      ), 
      //   },
      //   error: (error, st) => Center(child: Text("$error")),
      //   loading: () => Center(child: ApplicationsShimmer()),
      // ),
    );
  }

  Widget buildCard(
    UpdatedDateDocument document,
    CategoryElement category,
    AdaptiveSizes size,
    bool isTop,
    int index,
    Locale currentLocale,
    // SubcategoryByDocumentIdModel subCategory,
  ) {
    return SizedBox(
      height: 120,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: greyTextFBorderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.otstup15,
            vertical: size.otstup15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ContainerAsButton(
              //       size: size,
              //       // text: document.category.title.getText(currentLocale),
              //       text: category.title.getText(currentLocale),
              //       backGroundColor: const Color(0xFFBECBC5),
              //     ),
              //     textCWithH2GreyStyle(
              //       // "№121223",
              //       category.id.toString(),
              //       fontweight: FontWeight.bold,
              //       color: lightBlackTextColor,
              //     ),
              //   ],
              // ),
              SizedBox(height: size.otstup10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWithH1Style(
                    textAlign: TextAlign.start,
                    // subCategory.data.document.title.getText(currentLocale),
                    category.description.getText(currentLocale),
                    // "Уплата налога на транспортные средства (легковые автомобили)",
                    fontsize: 16,
                  ),
                  SizedBox(height: size.otstup10),
                  Row(
                    children: [
                      sameStyleDifColor("29.09.24", color: greyDateColor),
                      SizedBox(width: size.otstup10),
                      Container(width: 1, height: 13, color: Colors.grey),
                      SizedBox(width: size.otstup10),
                      sameStyleDifColor("14:00", color: greyDateColor),
                      SizedBox(width: size.otstup15),
                      sameStyleDifColor(
                        // "Успешно подписан",
                        category.status.toString() == "1"
                            ? "Успешно подписан"
                            : "В рассмотрении",
                        color: const Color(0xFF26AC71),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
