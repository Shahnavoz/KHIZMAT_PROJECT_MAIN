import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';

class HorizontalScrollableWidgetForDetailPage extends StatefulWidget {
  HorizontalScrollableWidgetForDetailPage({
    super.key,
    required this.categories,
    required this.size,
    required this.currentLocale,
    this.oneActiveColor,
    this.nonActiveColor,
    required this.selectedIndex,
    this.activeTextColor,
    this.nonActiveTextColor,
  });

  final List<CategoryElement> categories;
  final AdaptiveSizes size;
  final Locale currentLocale;
  LinearGradient? oneActiveColor = buttonsTitleGradient;
  LinearGradient? nonActiveColor = buttonsTitleGradient;
  int selectedIndex;
  Color? activeTextColor = Colors.white;
  Color? nonActiveTextColor = Colors.white;

  @override
  State<HorizontalScrollableWidgetForDetailPage> createState() =>
      _HorizontalScrollableWidgetForDetailPageState();
}

class _HorizontalScrollableWidgetForDetailPageState
    extends State<HorizontalScrollableWidgetForDetailPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const Text(
        'Нет категорий',
        style: TextStyle(color: Colors.red, fontSize: 16),
      );
    }

    return Container(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.categories.length, (index) {
            
            final title =
                widget.categories[index].title.getText(widget.currentLocale) ??
                'Без названия';
            return Padding(
              padding:
                  index != 0
                      ? const EdgeInsets.only(left: 8)
                      : const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient:
                        widget.selectedIndex == index
                            ? widget.oneActiveColor
                            : widget.nonActiveColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size.otstup25,
                      vertical: widget.size.horizontalPadding20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //ne nachinaetsa s pervogo
                        textWithH1Style(
                          index == 0 ? "Все" : title,
                          color:
                              widget.selectedIndex == index
                                  ? widget.activeTextColor!
                                  : widget.nonActiveTextColor!,
                          fontsize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
