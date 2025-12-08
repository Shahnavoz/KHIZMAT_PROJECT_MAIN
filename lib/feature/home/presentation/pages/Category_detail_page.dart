import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/shimmers/category_page_shimmer.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/usluga_info_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/horizontal_scrollable_widget_for_detail_page.dart';

class CategoryDetailPage extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final CategoryElement category;
  final int docId;
  final List<UpdatedDateDocument> documents;

  const CategoryDetailPage({
    super.key,
    required this.categories,
    required this.category,
    required this.docId,
    required this.documents,
  });

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
  bool showAll = false;

  void showAllText() {
    setState(() {
      showAll = !showAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);

    final combinedDataUslugi = ref.watch(
      combinedUslugaDataProvider(widget.category.id),
    );
    // final category = widget.categories[selectedIndex];
    List<CategoryElement> displayDocuments = [
      CategoryElement(
        id: 12111,
        position: 2,
        title: AllUpdatedDateDescription(tj: "Ҳама", ru: "Все", en: "All"),
        description: AllUpdatedDateDescription(
          tj: "Ҳама",
          ru: "Все",
          en: "All",
        ),
        iconId: widget.category.iconId,
        gradientStartColor: widget.category.gradientStartColor,
        gradientEndColor: widget.category.gradientEndColor,
        soon: false,
        icon: widget.category.icon,
        parentId: widget.category.parentId,
        deleted: widget.category.deleted,
        status: widget.category.status,
      ),
      ...widget.categories,
    ];

    // podcategorii  dlya kaghdoy categorii
    List<UpdatedDateDocument> filteredDocuments =
        selectedIndex == 0
            ? widget
                .documents // Vse categorii
                .where((document) => document.categoryId == widget.category.id)
                .toList()
            : widget.documents;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            textWithH1Style(
              "Назад",
              fontW: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 5),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Container(
          //   child: Image.asset(
          //     "assets/images/WHITE MAINcut.png",
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //   ),
          // ),
          // Container(
          //   decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.otstup15,
                    left: size.otstup20,
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
                              SizedBox(
                                width: size.screenWidth * 0.7,
                                child: textWithH1Style(
                                  textAlign: TextAlign.start,
                                  widget.category.title.getText(currentLocale),
                                  color: Colors.black,
                                  fontsize: 20,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: size.otstup10),
                              SizedBox(
                                width: size.screenWidth * 0.66,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textCWithH2GreyStyle(
                                      widget.category.description.getText(
                                        currentLocale,
                                      ),
                                      textAlign: TextAlign.start,
                                      color: Colors.black54,
                                      maxLines: !showAll ? 3 : 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  SvgPicture.asset(
                                    "assets/images/Vector (3).svg",
                                    width: 80,
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 15,
                                bottom: 0,
                                left: 30,
                                child:
                                    widget.category.iconId == null
                                        ? Image.asset(
                                          "assets/images/Group 831885517.png",
                                          fit: BoxFit.contain,
                                        )
                                        : Image.network(
                                          widget.category.iconId!,
                                          width: size.screenWidth * 0.19,
                                          fit: BoxFit.contain,
                                          color: Colors.white,
                                        ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.otstup25),
                      HorizontalScrollableWidgetForDetailPage(
                        category: widget.category,
                        size: size,
                        currentLocale: currentLocale,
                        selectedIndex: selectedIndex,
                        oneActiveColor: primaryGreenColor,
                        nonActiveColor: Colors.grey[200],
                        activeTextColor: Colors.white,
                        nonActiveTextColor: Colors.black,
                        categories: displayDocuments,
                      ),
                    ],
                  ),
                ),
                combinedDataUslugi.when(
                  data: (model) {
                    final List<UslugaDetailInfo> uslugaDetailInfo =
                        model.uslugaDetailInfo[widget.category.id] ?? [];

                    return Container(
                      decoration: BoxDecoration(
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
                                color: Colors.white,
                              ),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: filteredDocuments.length,
                                itemBuilder: (context, index) {
                                  final doc =
                                      uslugaDetailInfo[index].data.document;

                                  return GestureDetector(
                                    onTap: () async {
                                      final allSpecializations =
                                          model.uslugaSpecialization[doc.id] ??
                                          [];

                                      if (allSpecializations.isEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => UslugaInfoPage(
                                                  uslugaInfo:
                                                      uslugaDetailInfo[index],
                                                  specializations: [],
                                                  index: index,
                                                  requirements: [],
                                                ),
                                          ),
                                        );
                                        return;
                                      }

                                      final selectedSpec =
                                          allSpecializations.first;

                                      try {
                                        // Ждём, пока загрузятся requirements
                                        final allRequirements = await ref.read(
                                          requirementsProvider((
                                            doc.id,
                                            selectedSpec.id,
                                          )).future,
                                        );

                                        // Только после загрузки — переходим
                                        if (!context.mounted) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => UslugaInfoPage(
                                                  uslugaInfo:
                                                      uslugaDetailInfo[index],
                                                  specializations:
                                                      allSpecializations,
                                                  index: index,
                                                  requirements: allRequirements,
                                                ),
                                          ),
                                        );
                                      } catch (e) {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Ошибка загрузки: $e",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: size.otstup20,
                                        vertical: size.otstup10,
                                      ),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              index % 2 == 0
                                                  ? primaryGreenColor
                                                  : secondaryGreenColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Image.network(
                                            filteredDocuments[index].icon,
                                            color: Colors.white,
                                            width: size.imageSize50,
                                          ),
                                        ),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: textWithH1Style(
                                              color: Colors.black,
                                              filteredDocuments[index]
                                                  .title
                                                  .getText(currentLocale),
                                              textAlign: TextAlign.start,
                                              fontsize: 14,
                                              fontW: FontWeight.w700,
                                              // maxLines: 3,
                                            ),
                                          ),
                                          // textWithH1Style(
                                          //   filteredDocuments[index]
                                          //       .category
                                          //       .title
                                          //       .getText(currentLocale),
                                          //   textAlign: TextAlign.start,
                                          //   fontW: FontWeight.normal,
                                          //   fontsize: 16,
                                          //   maxLines: 3,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => Divider(
                                      color: greyTextFBorderColor,
                                      height: 0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  error:
                      (error, st) => Center(
                        child: Text('Errroooror!!${error.toString()},${st}'),
                      ),
                  loading:
                      () => SizedBox(height: 450, child: CategoryPageShimmer()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
