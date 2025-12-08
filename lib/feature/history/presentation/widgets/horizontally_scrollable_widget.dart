// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:khizmat_new/consts/colors/const_colors.dart';
// import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
// import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

// class HorizontallyScrollableWidgetForDynamicList extends StatefulWidget {
//   HorizontallyScrollableWidgetForDynamicList({
//     super.key,
//     required this.categories,
//     required this.size,
//     required this.currentLocale,
//     this.oneActiveColor,
//     this.nonActiveColor,
//     required this.selectedIndex,
//     this.activeTextColor,
//     this.nonActiveTextColor,
//     this.borderColor,
//     required this.onTap
//   });

//   final List<dynamic> categories;
//   final AdaptiveSizes size;
//   final Locale currentLocale;
//   Color? oneActiveColor = secondaryColorForScroll;
//   Color? nonActiveColor = secondaryColorForScroll;
//   int selectedIndex;
//   Color? activeTextColor = Colors.white;
//   Color? nonActiveTextColor = Colors.white;
//   Color? borderColor;
//   final void Function()? onTap;

//   @override
//   State<HorizontallyScrollableWidgetForDynamicList> createState() =>
//       _HorizontalScrollableWidgetState();
// }

// class _HorizontalScrollableWidgetState
//     extends State<HorizontallyScrollableWidgetForDynamicList> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.categories.isEmpty) {
//       return const Text(
//         'Нет категорий',
//         style: TextStyle(color: Colors.red, fontSize: 16),
//       );
//     }

//     return Container(
//       height: 50,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: List.generate(widget.categories.length, (index) {
//             final title =
//                 widget.categories[index];
//             return Padding(
//               padding:EdgeInsets.only(left: 8),
//                   // widget.selectedIndex==index
//                   //     ? const EdgeInsets.only(left: 8)
//                   //     : const EdgeInsets.only(left: 0),
//               child: GestureDetector(

//                 onTap:widget.onTap,
//                 //  () {
//                 //   setState(() {
//                 //     widget.selectedIndex = index;
//                 //   });
//                 // },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color:widget.selectedIndex==index ? widget.borderColor ?? primaryButtonColor : greyBorderColor,
//                     ),
//                     color:
//                         widget.selectedIndex==index
//                             ? widget.oneActiveColor
//                             : widget.nonActiveColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: widget.size.otstup20,
//                       vertical: widget.size.horizontalPadding20,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         textWithH1Style(
//                           title,
//                           color:
//                               widget.selectedIndex==index
//                                   ? widget.activeTextColor!
//                                   : widget.nonActiveTextColor!,
//                           fontsize: 16,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class HorizontallyScrollableWidgetForDynamicList extends StatefulWidget {
  const HorizontallyScrollableWidgetForDynamicList({
    super.key,
    required this.categories,
    required this.size,
    required this.currentLocale,
    this.oneActiveColor,
    this.nonActiveColor,
    required this.selectedIndex,
    required this.onTabChanged, // ← Новый обязательный параметр
    this.activeTextColor,
    this.nonActiveTextColor,
    this.borderColor,
  });

  final List<dynamic> categories;
  final AdaptiveSizes size;
  final Locale currentLocale;
  final Color? oneActiveColor;
  final Color? nonActiveColor;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged; // ← Вот это главное!
  final Color? activeTextColor;
  final Color? nonActiveTextColor;
  final Color? borderColor;

  @override
  State<HorizontallyScrollableWidgetForDynamicList> createState() =>
      _HorizontalScrollableWidgetState();
}

class _HorizontalScrollableWidgetState
    extends State<HorizontallyScrollableWidgetForDynamicList> {
  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const Text('Нет категорий', style: TextStyle(color: Colors.red));
    }

    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              widget.categories.asMap().entries.map((entry) {
                final index = entry.key;
                final title = entry.value;

                final isSelected = widget.selectedIndex == index;

                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
                  child: GestureDetector(
                    onTap:
                        () => widget.onTabChanged(
                          index,
                        ), // ← Передаём индекс наверх
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? (widget.oneActiveColor ??
                                    secondaryColorForScroll)
                                : (widget.nonActiveColor ?? Colors.transparent),
                        border: Border.all(
                          color:
                              isSelected
                                  ? (widget.borderColor ?? primaryGreenColor)
                                  : greyBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.size.otstup20,
                        vertical: widget.size.horizontalPadding20,
                      ),
                      child: textWithH1Style(
                        title.toString(),
                        color:
                            isSelected
                                ? (widget.activeTextColor ?? Colors.white)
                                : (widget.nonActiveTextColor ?? Colors.black),
                        fontsize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
