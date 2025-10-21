// import 'package:flutter/material.dart';
// import 'package:khizmat_new/consts/colors/const_colors.dart';
// import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
// import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
// import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';

// class CardTestPage extends StatefulWidget {
//   @override
//   _CardTestPageState createState() => _CardTestPageState();
// }

// class _CardTestPageState extends State<CardTestPage> {
//   List<String> items = List.generate(5, (index) => 'Element $index');

//   @override
//   Widget build(BuildContext context) {
//     final size = AdaptiveSizes(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal:size.otstup10),
//         child: Center(
//           child: SingleChildScrollView(
//             physics: NeverScrollableScrollPhysics(),
//             reverse: true, // 🔹 прокрутка снизу вверх
//             child: SizedBox(
//               // height: 150, // 🔹 подстрой под свой контент
//               child: Stack(
//                 alignment: Alignment.topLeft,
//                 children:
//                     items.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final item = entry.value;

//                       // смещения можно оставить прежние
//                       final offsetVnizIVlevo = Offset(
//                         -index * 1.0,
//                         -index * 4.0,
//                       );
//                       final offsetSverkhuVniz = Offset(
//                         -index * 0.0,
//                         -index * 7.0,
//                       );
//                       final isTop = index == items.length - 1;

//                       final cardWidget = Transform.translate(
//                         offset: offsetSverkhuVniz,
//                         child: buildCard(item, size,isTop),
//                       );

//                       if (isTop) {
//                         return Dismissible(
//                           key: ValueKey(item),
//                           direction:
//                               DismissDirection.vertical, // 🔹 свайп вверх
//                           onDismissed: (_) {
//                             setState(() {
//                               items.remove(item);
//                             });
//                           },
//                           child: cardWidget,
//                         );
//                       }

//                       return cardWidget;
//                     }).toList(),
//               ),
//             ),
//           ),

//           // SizedBox(
//           //   width: double.infinity,
//           //   height: 250,
//           //   child:
//           //   Stack(
//           //     alignment: Alignment.topLeft,
//           //     children: items.asMap().entries.map((entry) {
//           //       final index = entry.key;
//           //       final item = entry.value;
//           //       final isTop = index == items.length - 1;

//           //       // 🔹 Смещение карточек — можно поиграться со значениями
//           //       final offset = Offset(index * 5.0, index * 8.0);
//           //       final offsetVlevoIVniz = Offset(-index * 12.0, index * 8.0);
//           //       final offsetVverkhVpravo = Offset(index * 12.0, -index * 8.0);
//           //       final offsetVnizIVlevo = Offset(-index * 1.0, -index * 4.0);
//           //       final offsetSverkhuVniz = Offset(-index * 12.0, index * 12.0);

//           //       final cardWidget = Transform.translate(
//           //         offset: offsetVnizIVlevo,
//           //         child: buildCard(item, size),
//           //       );
//           //       // final cardWidget = Transform.translate(
//           //       //   offset: offsetVverkhVpravo,
//           //       //   child: buildCard(item, size),
//           //       // );
//           //       // final cardWidget = Transform.translate(
//           //       //   offset: offsetVlevoIVniz,
//           //       //   child: buildCard(item, size),
//           //       // );
//           //       // final cardWidget = Transform.translate(
//           //       //   offset: offsetSverkhuVniz,
//           //       //   child: buildCard(item, size),
//           //       // );

//           //       if (isTop) {
//           //         return Dismissible(
//           //           key: ValueKey(item),
//           //           direction: DismissDirection.endToStart,
//           //           onDismissed: (_) {
//           //             setState(() {
//           //               items.remove(item);
//           //             });
//           //           },
//           //           child: cardWidget,
//           //         );
//           //       }

//           //       return cardWidget;
//           //     }).toList(),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   Widget buildCard(String item, AdaptiveSizes size, bool isTop) {
//     return SizedBox(
//       height: 140,
//       width:isTop ? size.screenWidth*0.9 : size.screenWidth*0.85,
//       child: Center(
//         child: Card(
//           color: Colors.white,
//           // elevation: 4,
//           shadowColor: Colors.black26,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.otstup15,
//               vertical: size.otstup15,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ContainerAsButton(
//                       size: size,
//                       text: "Гражданство",
//                       backGroundColor: const Color(0xFFBECBC5),
//                     ),
//                     textCWithH2GreyStyle(
//                       "№121223",
//                       fontweight: FontWeight.bold,
//                       color: lightBlackTextColor,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.otstup10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWithH1Style(
//                       textAlign: TextAlign.start,
//                       "Уплата налога на транспортные средства (легковые автомобили)",
//                       fontsize: 16,
//                     ),
//                     SizedBox(height: size.otstup10),
//                     Row(
//                       children: [
//                         sameStyleDifColor("29.09.24", color: greyDateColor),
//                         SizedBox(width: size.otstup10),
//                         Container(width: 1, height: 13, color: Colors.grey),
//                         SizedBox(width: size.otstup10),
//                         sameStyleDifColor("14:00", color: greyDateColor),
//                         SizedBox(width: size.otstup15),
//                         sameStyleDifColor(
//                           "Успешно подписан",
//                           color: const Color(0xFF26AC71),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:khizmat_new/consts/colors/const_colors.dart';
// import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
// import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
// import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
// import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
// import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';

// class CardTestPage extends ConsumerStatefulWidget {
//   final List<CategoryElement> categories;

//   const CardTestPage({super.key, required this.categories});
//   @override
//   _CardTestPageState createState() => _CardTestPageState();
// }

// class _CardTestPageState extends ConsumerState<CardTestPage> {
//   List<String> items = List.generate(5, (index) => 'Element $index');

//   void moveTopToBottom() {
//     setState(() {
//       final top =
//           items.removeLast(); // берём верхнюю карточку (последний элемент)
//       items.insert(0, top); // добавляем в начало списка
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = AdaptiveSizes(context);
//     final currentLocale = ref.watch(localeProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.otstup10),
//           child: Stack(
//             alignment: Alignment.center,
//             children:
//                 items.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final item = entry.value;

//                   final isTop = index == items.length - 1;
//                   final scale = 1 - (items.length - 1 - index) * 0.05;
//                   final verticalOffset = (items.length - 1 - index) * 10.0;

//                   final cardWidget = Transform.translate(
//                     offset: Offset(0, verticalOffset),
//                     child: Transform.scale(
//                       scale: scale,
//                       alignment: Alignment.center,
//                       child: buildCard(item, size, isTop, index, currentLocale),
//                     ),
//                   );

//                   if (isTop) {
//                     return Dismissible(
//                       key: ValueKey(item),
//                       direction: DismissDirection.vertical,
//                       onDismissed: (_) {
//                         moveTopToBottom(); // вместо удаления — отправляем вниз
//                       },
//                       child: cardWidget,
//                     );
//                   }

//                   return cardWidget;
//                 }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCard(
//     String item,
//     AdaptiveSizes size,
//     bool isTop,
//     int index,
//     Locale currentLocale,
//   ) {
//     return SizedBox(
//       height: 140,
//       child: Card(
//         color: Colors.white,
//         // elevation: 6,
//         shadowColor: Colors.black26,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: greyTextFBorderColor),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.otstup15,
//             vertical: size.otstup15,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ContainerAsButton(
//                     size: size,
//                     text: widget.categories[index].title.getText(currentLocale),
//                     // text: "Гражданство",
//                     backGroundColor: const Color(0xFFBECBC5),
//                   ),
//                   textCWithH2GreyStyle(
//                     "№121223",
//                     fontweight: FontWeight.bold,
//                     color: lightBlackTextColor,
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.otstup10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   textWithH1Style(
//                     textAlign: TextAlign.start,
//                     "Уплата налога на транспортные средства (легковые автомобили)",
//                     fontsize: 16,
//                   ),
//                   SizedBox(height: size.otstup10),
//                   Row(
//                     children: [
//                       sameStyleDifColor("29.09.24", color: greyDateColor),
//                       SizedBox(width: size.otstup10),
//                       Container(width: 1, height: 13, color: Colors.grey),
//                       SizedBox(width: size.otstup10),
//                       sameStyleDifColor("14:00", color: greyDateColor),
//                       SizedBox(width: size.otstup15),
//                       sameStyleDifColor(
//                         "Успешно подписан",
//                         color: const Color(0xFF26AC71),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart'
    as doc;
import 'package:khizmat_new/feature/home/data/models/podcategories_model.dart';
import 'package:khizmat_new/feature/home/data/providers/category_provider.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';

class CardTestPage extends ConsumerStatefulWidget {
  final List<doc.CategoryElement> categories;
  final List<doc.Document> documents;

  const CardTestPage({
    super.key,
    required this.categories,
    required this.documents,
  });
  @override
  _CardTestPageState createState() => _CardTestPageState();
}

class _CardTestPageState extends ConsumerState<CardTestPage> {
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
      body: asyncCategoryData.when(
        data: (model) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Stack(
                alignment: Alignment.center,
                children:
                    indices.asMap().entries.map((entry) {
                      final index = entry.key;
                      final categoryIndex = entry.value; // Индекс категории
                      final category =
                          widget.categories[categoryIndex]; // Данные категории

                      final documentIndex = entry.value;
                      final document = widget.documents[documentIndex];
                      final subCategoryIndex = entry.value;
                      final subcategories =
                          model.subcategoriesByCategory[widget
                              .categories[index]
                              .id] ??
                          [];
                      final subCategory = subcategories[0];

                      final isTop = index == indices.length - 1;
                      final scale = 1 - (indices.length - 1 - index) * 0.05;
                      final verticalOffset =
                          (indices.length - 1 - index) * 10.0;

                      final cardWidget = Transform.translate(
                        offset: Offset(0, verticalOffset),
                        child: Transform.scale(
                          scale: scale,
                          alignment: Alignment.center,
                          child: buildCard(
                            document,
                            category,
                            size,
                            isTop,
                            categoryIndex,
                            currentLocale,
                            subCategory,
                          ),
                        ),
                      );

                      if (isTop) {
                        return Dismissible(
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
          );
        },
        error: (error, st) => Center(child: Text("$error")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildCard(
    doc.Document document,
    doc.CategoryElement category,
    AdaptiveSizes size,
    bool isTop,
    int index,
    Locale currentLocale,
    SubcategoryByDocumentIdModel subCategory,
  ) {
    return SizedBox(
      height: 140,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerAsButton(
                    size: size,
                    // text: document.category.title.getText(currentLocale),
                    text: category.title.getText(currentLocale),
                    backGroundColor: const Color(0xFFBECBC5),
                  ),
                  textCWithH2GreyStyle(
                    "№121223",
                    fontweight: FontWeight.bold,
                    color: lightBlackTextColor,
                  ),
                ],
              ),
              SizedBox(height: size.otstup10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWithH1Style(
                    textAlign: TextAlign.start,
                    subCategory.data.document.title.getText(currentLocale),
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
                        "Успешно подписан",
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
