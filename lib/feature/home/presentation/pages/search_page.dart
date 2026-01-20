import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Category_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;
  final Locale currentLocale;

  const SearchPage({
    super.key,
    required this.categories,
    required this.documents,
    required this.currentLocale,
  });

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController controller = TextEditingController();

  List<CategoryElement> filteredCategories = [];
  List<UpdatedDateDocument> filteredDocuments = [];

  //Istoriya zaprosov
  List<String> searchHistory = [];

  String searchQuery = '';

  //Maximum ;elementov v istorii
  static const int maxHistoryLength = 10;

  @override
  void initState() {
    super.initState();
    filteredCategories = widget.categories;
    filteredDocuments = widget.documents;

    controller.addListener(_performSearch);

    _loadSearchHistory();
  }

  @override
  void dispose() {
    controller.removeListener(_performSearch);
    controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = controller.text.trim().toLowerCase();

    setState(() {
      searchQuery = query;

      if (query.isEmpty) {
        filteredCategories = widget.categories;
        filteredDocuments = widget.documents;
      } else {
        filteredCategories =
            widget.categories.where((category) {
              final categoryName =
                  (category.title.getText(widget.currentLocale) ?? '')
                      .toLowerCase();
              return categoryName.contains(query);
            }).toList();

        filteredDocuments =
            widget.documents.where((doc) {
              final docTitle =
                  (doc.title.getText(widget.currentLocale) ??
                          doc.title.getText(widget.currentLocale) ??
                          '')
                      .toLowerCase();
              return docTitle.contains(query);
            }).toList();
      }
    });
  }

  //zagruzka istorii is sharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];

    setState(() {
      searchHistory = history;
    });
  }

  //Sokhraneniye novogo zaprosa v istorii
  Future<void> _addToSearchHistory(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> updatedHistory = [];

    //Ubiraem duplicat,esli oni ughe est
    updatedHistory = searchHistory.where((item) => item != query).toList();

    //dobavlyaem noviy zapros v nachalo
    updatedHistory.insert(0, query);

    //Ogranichivaem dlinu

    if (updatedHistory.length > maxHistoryLength) {
      updatedHistory = updatedHistory.sublist(0, maxHistoryLength);
    }

    await prefs.setStringList('search_history', updatedHistory);

    setState(() {
      searchHistory = updatedHistory;
    });
  }

  //Udaleniye  odnogo elementa is istorii

  Future<void> _removeFromHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.remove(query);
    await prefs.setStringList('search_history', searchHistory);

    setState(() {});
  }

  //Ochistka vsey istorii
  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');

    setState(() {
      searchHistory.clear();
    });
  }

  // Выбор запроса из истории
  void _selectHistoryQuery(String query) {
    controller.text = query;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final bool isSearching = searchQuery.isNotEmpty;
    final bool showHistory = searchQuery.isEmpty && searchHistory.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.otstup20,
            vertical: size.otstup18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyTextFieldWithPrefix(
                      backGroundColor: Colors.white,
                      hintText: "Поиск",
                      controller: controller,
                      onChanged: (value) {},
                      // onFieldSubmitted: (value) {
                      //   if (value.trim().isNotEmpty) {
                      //     _addToSearchHistory(value.trim());
                      //   }
                      // },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        },
                        //  _clearHistory,
                        icon: Icon(Icons.cancel, color: greyTextFBorderColor),
                      ),
                    ),
                  ),
                  SizedBox(width: size.otstup10),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: textWithH1Style("Отменить", fontsize: 15),
                  ),
                ],
              ),

              SizedBox(height: size.otstup10),
              Expanded(
                child:
                    isSearching
                        ? _buildSearchResults(size, widget.currentLocale)
                        : showHistory
                        ? _buildHistoryView(size)
                        : _buildInitialState(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryView(AdaptiveSizes size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: searchHistory.length,
            itemBuilder: (context, index) {
              final query = searchHistory[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _selectHistoryQuery(query),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size.otstup10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/Vector (4).svg"),
                              SizedBox(width: size.otstup18),
                              SizedBox(
                                width: size.screenWidth * 0.75,
                                child: textWithH1Style(
                                  query,
                                  fontsize: 16,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _removeFromHistory(query),
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(color: greyTextFBorderColor),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Text(
        "Start searching!",
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildSearchResults(AdaptiveSizes size, Locale currentLocale) {
    final hasResults =
        filteredCategories.isNotEmpty || filteredDocuments.isNotEmpty;

    if (!hasResults) {
      return Center(
        child: Text(
          "Ничего не найдено",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    final bool hasCategories = filteredCategories.isNotEmpty;
    final bool hasDocuments = filteredDocuments.isNotEmpty;

    final int totalItems = filteredDocuments.length + filteredCategories.length;
    final int itemCount =
        totalItems + (hasDocuments ? 1 : 0) + (hasCategories ? 1 : 0);

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        int currentIndex = 0;

        if (hasDocuments) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                "Услуги",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }
          currentIndex = 1;

          if (index < filteredDocuments.length + currentIndex) {
            final int documentIndex = index - currentIndex;
            final doc = filteredDocuments[documentIndex];
            final category = widget.categories;
            final category1 = doc.category;

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: size.otstup15),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 2, color: primaryButtonColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.title.getText(widget.currentLocale) ??
                            'Без названия',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (category1.title.getText(currentLocale) ==
                                  category[index].title.getText(
                                    currentLocale,
                                  )) {}
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => CategoryDetailPage(
                                        categories: widget.categories,
                                        category: category[index],
                                        docId: widget.documents[index].id,
                                        documents: widget.documents,
                                      ),
                                ),
                              );
                            },
                            // onTap: () {
                            //   final queryText =
                            //       category.title.getText(currentLocale) ?? '';
                            //   if (queryText.isNotEmpty) {
                            //     _addToSearchHistory(queryText);
                            //   }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder:
                            //         (context) => CategoryDetailPage(
                            //           categories: widget.categories,
                            //           category: category,
                            //           docId: widget.documents[index].id,
                            //           documents: widget.documents,
                            //         ),
                            //   ),
                            // );
                            // },
                            child: SizedBox(
                              width: size.screenWidth * 0.68,
                              child: textH2GreyTitle(
                                fontSize: 18,
                                category1 == category
                                    ? category[index].title.getText(
                                      widget.currentLocale,
                                    )
                                    : category1.title.getText(currentLocale) ??
                                        '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.otstup35),
              ],
            );
          }

          currentIndex += filteredDocuments.length;
        }

        if (hasDocuments && hasCategories && index == currentIndex) {
          return Column(
            children: [const Divider(), SizedBox(height: size.otstup15)],
          );
        }

        if (hasDocuments) {
          currentIndex += 1;
        }

        if (hasCategories && index == currentIndex) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "Категории",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          );
        }

        if (hasCategories) {
          currentIndex += 1;
          final int categoryIndex = index - currentIndex;
          if (categoryIndex < filteredCategories.length) {
            final category = filteredCategories[categoryIndex];

            return GestureDetector(
              onTap: () {
                final queryText = category.title.getText(currentLocale) ?? '';
                if (queryText.isNotEmpty) {
                  _addToSearchHistory(queryText);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CategoryDetailPage(
                          categories: widget.categories,
                          category: category,
                          docId: category.parentId!,
                          documents: widget.documents,
                        ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: size.otstup18),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 2, color: primaryButtonColor),
                      ),
                    ),
                    child: textWithH1Style(
                      category.title.getText(widget.currentLocale) ??
                          'Без названия',
                      fontsize: 16,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: size.otstup25),
                ],
              ),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
