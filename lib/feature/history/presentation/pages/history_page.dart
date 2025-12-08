import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/history/presentation/widgets/ApplicationCard.dart';
import 'package:khizmat_new/feature/history/presentation/widgets/horizontally_scrollable_widget.dart';
import 'package:khizmat_new/feature/history/presentation/widgets/payment_card.dart';
import 'package:khizmat_new/feature/home/presentation/pages/steps_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  List<String> tabs = ["Все", "Оплата", "Документы", "Заявки"];
  int selectedIndex = 0;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final documents = List.generate(1, (_) => HistoryCard(size: size));
    final applications = List.generate(1, (_) => Applicationcard(count: 3));
    final payments = List.generate(1, (_) => PaymentCard(count: 3));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: "История",
        // actionWidget: Padding(
        //   padding: EdgeInsets.only(right: size.otstup10),
        //   child: FontSettingContainer(size: size),
        // ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup15,
              vertical: size.otstup20,
            ),
            child: Column(
              children: [
                MyTextFieldWithPrefix(
                  hintText: "Поиск вопросов",
                  controller: controller,
                  onChanged: (p0) {},
                ),
                SizedBox(height: size.otstup15),
                HorizontallyScrollableWidgetForDynamicList(
                  activeTextColor: Colors.white,
                  nonActiveColor: Colors.transparent,
                  nonActiveTextColor: Colors.black,
                  oneActiveColor: primaryGreenColor,
                  categories: tabs,
                  size: size,
                  currentLocale: currentLocale,
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    setState(() => selectedIndex = index);
                  },
                ),
                SizedBox(height: size.otstup10),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xFFF7F7F7)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.otstup10,
                horizontal: size.otstup15,
              ),
              child: textWithH1Style(
                "25 ноября, среда",
                color: Color(0xFFAFAFAF),
                textAlign: TextAlign.start,
                fontsize: 16,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.otstup15,
                vertical: size.otstup5,
              ),
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  _buildAllTab(size, documents, applications, payments),
                  _buildPaymentsTab(size, payments.length),
                  _buildDocumentsTab(size, documents.length),
                  _buildApplicationsTab(size, applications.length),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTab(
    AdaptiveSizes size,
    List<HistoryCard> documents,
    List<Applicationcard> applications,
    List<PaymentCard> payments,
  ) {
    // final sectionTitles = ['Документы', 'Заявления', 'Платежи'];

    return ListView(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSection(
          // title: sectionTitles[0],
          items: documents,
          itemSeparator: SizedBox(height: size.otstup10),
        ),
        // SizedBox(height: size.otstup20),-----------------
        _buildSection(
          // title: sectionTitles[1],
          items: applications,
          itemSeparator: SizedBox(height: size.otstup10),
        ),
        // SizedBox(height: size.otstup20),
        _buildSection(
          // title: sectionTitles[2],
          items: payments,
          itemSeparator: SizedBox(height: size.otstup10),
        ),
      ],
    );
  }

  Widget _buildSection({
    // String title = '',
    required List<dynamic> items,
    required Widget itemSeparator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final widget = entry.value;

          return Column(
            children: [widget, if (index < items.length - 1) itemSeparator],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPaymentsTab(AdaptiveSizes size, int count) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder:
          (_, i) => Padding(
            padding: EdgeInsets.only(bottom: size.otstup5),
            child: PaymentCard(count: count),
          ),
    );
  }

  Widget _buildDocumentsTab(AdaptiveSizes size, final count) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 3,
      itemBuilder:
          (_, i) => Padding(
            padding: EdgeInsets.only(bottom: size.otstup5),
            child: HistoryCard(size: size),
          ),
    );
  }

  Widget _buildApplicationsTab(AdaptiveSizes size, int count) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder:
          (_, i) => Padding(
            padding: EdgeInsets.only(bottom: size.otstup5),
            child: Applicationcard(count: count),
          ),
    );
  }
}

class HistoryCard extends StatefulWidget {
  final AdaptiveSizes size;
  const HistoryCard({super.key, required this.size});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  double _rating = 0;
  bool _isRated = false;

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF6FFFA), Color(0xFFFFFFFF)],
        ),
        border: Border.all(color: greyBorderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.size.otstup10,
              vertical: widget.size.otstup10,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyBorderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    // shape: BoxShape.circle
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size.otstup20,
                      vertical:
                          _rating == 0
                              ? widget.size.otstup20
                              : widget.size.otstup20,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/documentCardIcon.svg",
                      width: widget.size.imageSize50,
                    ),
                  ),
                ),
                SizedBox(width: widget.size.otstup15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWithH2BlackStyle(
                        "Архитектура и градостроительство",
                        maxline: 1,
                        textAlign: TextAlign.start,
                      ),
                      textCWithH2GreyStyle(
                        "Разрешение на начало строительных работ",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: widget.size.otstup10),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.size.otstup20,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: greyBorderColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFFF6FFFA),
                            ),
                            child: textWithH2BlackStyle(
                              "Успешно",
                              color: primaryGreenColor,
                            ),
                          ),
                          SizedBox(width: widget.size.otstup10),
                          _isRated
                              ? Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  textWithH1Style(
                                    _rating.toStringAsFixed(1),
                                    fontsize: 16,
                                  ),
                                ],
                              )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!_isRated) ...[
            const Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.otstup10,
                vertical: size.otstup5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textWithH2BlackStyle(
                    "Оцените услугу",
                    color: Color(0xFF686868),
                  ),
                  SizedBox(width: widget.size.otstup15),
                  RatingBar.builder(
                    itemSize: 25,
                    initialRating: _rating,
                    minRating: 1,
                    allowHalfRating: false,
                    itemCount: 5,
                    glow: false,
                    itemBuilder:
                        (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() => _rating = rating);
                    },
                  ),
                  SizedBox(width: widget.size.otstup10),
                  IconButton(
                    onPressed:
                        _rating > 0
                            ? () {
                              setState(() => _isRated = true);
                            }
                            : null,
                    icon: Icon(Icons.done, color: primaryGreenColor),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
