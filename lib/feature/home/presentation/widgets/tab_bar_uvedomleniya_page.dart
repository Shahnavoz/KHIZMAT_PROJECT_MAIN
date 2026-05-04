import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_documents_provider.dart';
import 'package:khizmat_new/feature/documents/presentation/pages/my_documents_page.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_document_detail_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/generated/l10n.dart';

// class TabBarUvedomleniyaPage extends ConsumerWidget {
//   final List<CategoryElement> categories;
//   final List<UpdatedDateDocument> documents;
//   const TabBarUvedomleniyaPage({
//     super.key,
//     required this.size,
//     required this.categories,
//     required this.documents,
//   });

//   final AdaptiveSizes size;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final asyncDocs = ref.watch(myDocumentsProvider);
//     final locale = ref.watch(localeProvider);
    

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: size.otstup10, vertical: size.otstup10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: asyncDocs.when(
//               loading: () =>
//                   const Center(child: CircularProgressIndicator(strokeWidth: 2)),
//               error: (e, _) => Center(
//                 child: Text(e.toString(),
//                     style: const TextStyle(fontSize: 12)),
//               ),
//               data: (model) {
//                 final registers =
//                     (model.data?.registers ?? []).take(3).toList();
//                 if (registers.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'Нет документов',
//                       style: TextStyle(
//                           color: Colors.grey[500], fontSize: 13),
//                     ),
//                   );
//                 }
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     for (int i = 0; i < registers.length; i++) ...[
//                       _DocCard(
//                         reg: registers[i],
//                         index: i,
//                         fullModel: model,
//                         locale: locale,
//                         size: size,
//                       ),
//                       if (i < registers.length - 1)
//                         SizedBox(height: size.otstup5),
//                     ],
//                   ],
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: size.otstup10),
//           My_Button(
//             width: size.screenWidth * 0.815,
//             size: size,
//             borderRadius: 10,
//             backgroundColor: Colors.white,
//             borderColor: greyTextFBorderColor,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => MyDocumentsPage(
//                       selectedIndex: 0, document: documents),
//                 ),
//               );
//             },
//             child: const Text(
//               'Все документы',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DocCard extends StatelessWidget {
//   final Register reg;
//   final int index;
//   final MyDocumentsModel fullModel;
//   final Locale locale;
//   final AdaptiveSizes size;

//   const _DocCard({
//     required this.reg,
//     required this.index,
//     required this.fullModel,
//     required this.locale,
//     required this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final docTitle = reg.document?.getText(locale) ?? '';
//     final categoryTitle = reg.category?.title?.getText(locale) ?? '';
//     final dateStr = reg.registrationDate?.split('T').first ?? '';

//     return GestureDetector(
//       onTap: () {
//         if (reg.id == null) return;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => MyDocumentDetailPage(
//               docModel: fullModel,
//               index: index,
//               id: reg.id!,
//               currentLocale: locale,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         color: Colors.white,
//         shadowColor: Colors.black26,
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: greyTextFBorderColor),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.otstup15,
//             vertical: size.otstup10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (categoryTitle.isNotEmpty)
//                     Flexible(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 3),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEBFFF3),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           categoryTitle,
//                           style: const TextStyle(
//                             fontSize: 11,
//                             color: primaryGreenColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   if (reg.registerNumber != null)
//                     textCWithH2GreyStyle(
//                       '№${reg.registerNumber}',
//                       fontweight: FontWeight.bold,
//                       color: lightBlackTextColor,
//                     ),
//                 ],
//               ),
//               SizedBox(height: size.otstup10),
//               textWithH1Style(
//                 docTitle,
//                 textAlign: TextAlign.start,
//                 fontsize: 14,
//               ),
//               SizedBox(height: size.otstup10),
//               if (dateStr.isNotEmpty)
//                 sameStyleDifColor(dateStr, color: greyDateColor),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class TabBarUvedomleniyaPage extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;

  const TabBarUvedomleniyaPage({
    super.key,
    required this.categories,
    required this.documents,
  });

  @override
  ConsumerState<TabBarUvedomleniyaPage> createState() =>
      _TabBarUvedomleniyaPageState();
}

class _TabBarUvedomleniyaPageState
    extends ConsumerState<TabBarUvedomleniyaPage> {
  List<int> _indices = [];
  int _loadedLength = -1;
  int _dismissKey = 0;

  void _initIndices(int length) {
    if (length != _loadedLength) {
      _loadedLength = length;
      _indices = List.generate(length, (i) => i);
    }
  }

  void _moveTopToBottom() {
    setState(() {
      _dismissKey++;
      if (_indices.length < 2) return;
      final top = _indices.removeLast();
      _indices.insert(0, top);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final asyncDocs = ref.watch(myDocumentsProvider);
    final locale = ref.watch(localeProvider);

    return asyncDocs.when(
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (model) {
        final registers = (model.data?.registers ?? []).take(3).toList();

        _initIndices(registers.length);

        if (registers.isEmpty) {
          return Center(
            child: Text(
              S.of(context).noDocuments,
              style: TextStyle(color: Colors.grey[500]),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: _indices.asMap().entries.map((entry) {
                  final stackIndex = entry.key;
                  final docIndex = entry.value;
                  final reg = registers[docIndex];

                  final isTop = stackIndex == _indices.length - 1;
                  final verticalOffset =
                      (_indices.length - 1 - stackIndex) * 10.0;

                  final card = Transform.translate(
                    offset: Offset(0, verticalOffset),
                    child: _buildDocCard(
                      reg,
                      docIndex,
                      model,
                      locale,
                      size,
                    ),
                  );

                  if (isTop) {
                    return Dismissible(
                      movementDuration: const Duration(milliseconds: 10),
                      resizeDuration: const Duration(milliseconds: 2),
                      dragStartBehavior: DragStartBehavior.down,
                      key: ValueKey('top_$_dismissKey'),
                      direction: DismissDirection.vertical,
                      onDismissed: (_) => _moveTopToBottom(),
                      child: card,
                    );
                  }

                  return card;
                }).toList(),
              ),
            ),

            SizedBox(height: size.otstup10),

            My_Button(
              width: size.screenWidth * 0.815,
              size: size,
              borderRadius: 10,
              backgroundColor: Colors.white,
              borderColor: greyTextFBorderColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyDocumentsPage(
                      selectedIndex: 0,
                      document: widget.documents,
                    ),
                  ),
                );
              },
              child:  Text(
                S.of(context).allDocuments,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDocCard(
    Register reg,
    int index,
    MyDocumentsModel fullModel,
    Locale locale,
    AdaptiveSizes size,
  ) {
    final docTitle = reg.document?.getText(locale) ?? '';
    final categoryTitle = reg.category?.title?.getText(locale) ?? '';
    final dateStr = reg.registrationDate?.split('T').first ?? '';

    return SizedBox(
      height: 140,
      child: GestureDetector(
        onTap: () {
          if (reg.id == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MyDocumentDetailPage(
                docModel: fullModel,
                index: index,
                id: reg.id!,
                currentLocale: locale,
              ),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: greyTextFBorderColor),
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
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          color:  const Color.fromARGB(255, 181, 246, 219),
                          borderRadius: BorderRadius.circular(6),
                          // border: Border.all(color: primaryGreenColor), 
                        ),
                        child: Text(
                          categoryTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: primaryGreenColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    if (reg.registerNumber != null)
                      textCWithH2GreyStyle(
                        '№${reg.registerNumber}',
                        fontweight: FontWeight.bold,
                        color: lightBlackTextColor,
                      ),
                  ],
                ),
                SizedBox(height: size.otstup10),
                textWithH1Style(
                  docTitle,
                  fontsize: 14,
                  textAlign: TextAlign.start
                ),
                SizedBox(height: size.otstup10),
                if (dateStr.isNotEmpty)
                  sameStyleDifColor(dateStr, color: greyDateColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}