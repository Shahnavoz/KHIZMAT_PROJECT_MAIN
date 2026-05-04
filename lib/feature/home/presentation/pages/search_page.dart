import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Category_detail_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/usluga_info_page.dart';
import 'package:khizmat_new/generated/l10n.dart';
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

  List<String> searchHistory = [];
  String searchQuery = '';

  static const int maxHistoryLength = 10;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextChanged);
    _loadSearchHistory();
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = controller.text.trim().toLowerCase();
    if (query != searchQuery) {
      setState(() => searchQuery = query);
    }
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

  void _selectHistoryQuery(String query) {
    controller.text = query;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);
    final size = AdaptiveSizes(context);
    final bool isSearching = searchQuery.isNotEmpty;
    final bool showHistory = searchQuery.isEmpty && searchHistory.isNotEmpty;

    final filteredDocuments = isSearching
        ? widget.documents.where((doc) {
            final t = doc.title;
            return (t.ru ?? '').toLowerCase().contains(searchQuery) ||
                   (t.en ?? '').toLowerCase().contains(searchQuery) ||
                   (t.tj ?? '').toLowerCase().contains(searchQuery);
          }).toList()
        : widget.documents;

    final filteredCategories = isSearching
        ? widget.categories.where((cat) {
            final t = cat.title;
            return (t.ru ?? '').toLowerCase().contains(searchQuery) ||
                   (t.en ?? '').toLowerCase().contains(searchQuery) ||
                   (t.tj ?? '').toLowerCase().contains(searchQuery);
          }).toList()
        : widget.categories;

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
                      hintText: S.of(context).search,
                      controller: controller,
                      onChanged: (value) {},
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        },
                        icon: Icon(Icons.cancel, color: greyTextFBorderColor),
                      ),
                    ),
                  ),
                  SizedBox(width: size.otstup10),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: textWithH1Style(S.of(context).cancel, fontsize: 15),
                  ),
                ],
              ),
              SizedBox(height: size.otstup10),
              Expanded(
                child: isSearching
                    ? _buildSearchResults(
                        size, currentLocale, filteredDocuments, filteredCategories)
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
        S.of(context).startSearching,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildSearchResults(
    AdaptiveSizes size,
    Locale currentLocale,
    List<UpdatedDateDocument> filteredDocuments,
    List<CategoryElement> filteredCategories,
  ) {
    final hasResults =
        filteredCategories.isNotEmpty || filteredDocuments.isNotEmpty;

    if (!hasResults) {
      return Center(
        child: Text(
          S.of(context).nothingFound,
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
                S.of(context).services,
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
                      GestureDetector(
                        onTap: () async {
                          final queryText = doc.title.getText(currentLocale);
                          if (queryText.isNotEmpty) _addToSearchHistory(queryText);
                          final nav = Navigator.of(context);
                          try {
                            final model = await ref.read(
                              combinedUslugaDataProvider(doc.categoryId).future,
                            );
                            final infoList = model.uslugaDetailInfo[doc.categoryId] ?? [];
                            final idx = infoList.indexWhere(
                              (u) => u.data.document.id == doc.id,
                            );
                            if (idx != -1 && mounted) {
                              nav.push(
                                MaterialPageRoute(
                                  builder: (_) => UslugaInfoPage(
                                    uslugaInfo: infoList[idx],
                                    specializations: [],
                                    requirements: [],
                                    index: idx,
                                    categoryId: doc.categoryId,
                                    doc: infoList[idx].data.document,
                                  ),
                                ),
                              );
                            }
                          } catch (_) {}
                        },
                        child: Text(
                          doc.title.getText(currentLocale),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              CategoryElement? matchedCategory;
                              try {
                                matchedCategory = widget.categories.firstWhere(
                                  (c) => c.id == doc.categoryId,
                                );
                              } catch (_) {}
                              if (matchedCategory == null) return;
                              final queryText = matchedCategory.title.getText(currentLocale);
                              if (queryText.isNotEmpty) _addToSearchHistory(queryText);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryDetailPage(
                                    categories: widget.categories,
                                    category: matchedCategory!,
                                    docId: doc.id,
                                    documents: widget.documents,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: size.screenWidth * 0.68,
                              child: textH2GreyTitle(
                                fontSize: 18,
                                doc.category.title.getText(currentLocale),
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
              S.of(context).categories,
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
                final queryText = category.title.getText(currentLocale);
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
                      category.title.getText(currentLocale),
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
