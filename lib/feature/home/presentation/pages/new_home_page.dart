import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/shimmers/home_page_shimmer.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/consts/themes/themes.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Notification_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/card_test_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/scan_qr_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/buttons_bar_titles.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/horizontal_scrollable_widget.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_page_popular_services.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/tab_bar_uvedomleniya_page.dart';

final queryProvider = StateProvider<String>((ref) => "");

class NewHomePage extends ConsumerStatefulWidget {
  const NewHomePage({super.key});

  @override
  ConsumerState<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends ConsumerState<NewHomePage> {
  var searchController = TextEditingController();
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> items = List.generate(10, (index) => 'Элемент $index');
  TextEditingController searchController1 = TextEditingController();
  List<Map<String, dynamic>> docColors = [
    {
      'color': LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFF6A9D9D)],
        stops: [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'text': 'Паспорт',
      "image": "assets/images/Group (9).svg",
      "iconImage": "assets/images/78f4dc6a-846f-4a41-8fcc-79804292491b 3.png",
    },
    {
      'color': LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFF5EB681)],
        stops: [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'text': 'Авто',
      "image": "assets/images/Group (6).svg",
      "iconImage": "assets/images/78f4dc6a-846f-4a41-8fcc-79804292491b 4.png",
    },
    {
      'color': LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFF015057)],
        stops: [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'text': 'Авто',
      "image": "assets/images/Group (10).svg",
      "iconImage": "assets/images/78f4dc6a-846f-4a41-8fcc-79804292491b 2.png",
    },
    {
      'color': LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFF6A9D9D)],
        stops: [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      'text': 'Все',
      "image": "assets/images/Group (9).svg",
      "iconImage": "assets/images/78f4dc6a-846f-4a41-8fcc-79804292491b 3.png",
    },
  ];
  final int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        isAppBarCollapsed =
            _scrollController.hasClients &&
            _scrollController.offset > (200 - kToolbarHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final asyncAllUpdatedDate = ref.watch(allUpdatedDateProvider);
    final currentLocale = ref.watch(localeProvider);
    final appThemeProvider = ref.watch(themeProvider);
    final query = ref.watch(queryProvider);

    return asyncAllUpdatedDate.when(
      data: (model) {
        final categories = model?.data.categories ?? [];
        final sortedCategories =
            categories.toList()
              ..sort((a, b) => a.position ?? 1.compareTo(b.position ?? 1));

        // final filtredCategories = categories.where((category) {
        //   final title = category.title.getText(currentLocale).toLowerCase();
        //   return title.contains(query);
        // }).toList();

        final documents = model!.data.documents ?? [];
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: appThemeProvider ? Colors.white : Colors.black,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: Image.asset(
                    appThemeProvider
                        ? "assets/images/image 17.png"
                        : "assets/images/DARK MAIN.png",
                    fit: BoxFit.cover,
                  ),
                ),
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                          isAppBarCollapsed ? Colors.white : Colors.transparent,
                      foregroundColor:
                          isAppBarCollapsed ? Colors.black : Colors.white,
                      pinned: true,
                      toolbarHeight: kToolbarHeight + 10,
                      expandedHeight: 200,
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration:
                              !isAppBarCollapsed
                                  ? BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFFFFFFF),
                                        const Color.fromARGB(0, 249, 247, 247),
                                      ],
                                      stops: [0.0, 0.7, 1.0],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(150),
                                  )
                                  : BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey[300]),
                              SizedBox(width: 15),
                              Text(
                                "Shahnavoz,салом",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationPage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.notifications),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     ref.read(themeProvider.notifier).state =
                            //         !ref.read(themeProvider.notifier).state;
                            //   },
                            //   icon: Icon(
                            //     appThemeProvider
                            //         ? Icons.dark_mode_outlined
                            //         : Icons.light_mode,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanQrPage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.qr_code),
                            ),
                            SizedBox(width: size.otstup10),
                          ],
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 80,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: size.otstup20,
                                  right: size.otstup20,
                                  bottom: size.otstup10,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    HorizontalScrollableWidget(
                                      borderColor: greyBorderColor,
                                      categories: categories,
                                      size: size,
                                      currentLocale: currentLocale,
                                      selectedIndex: selectedIndex,
                                      oneActiveColor: Colors.white,
                                      nonActiveColor: Colors.white,
                                      activeTextColor: Colors.black,
                                      nonActiveTextColor: Colors.black,
                                    ),
                                    MyTextFieldWithPrefix(
                                      width: size.screenWidth * 0.92,
                                      borderColor: greyTextFBorderColor,
                                      controller: searchController1,
                                      hintText: "Поиск вопросов",
                                      backGroundColor: Colors.white,
                                      onChanged: (value) {
                                        ref.read(queryProvider.notifier).state =
                                            value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size.screenWidth * 0.045,
                                      vertical: size.otstup20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Вкладки
                                        ButtonsBarTitles(size: size),
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Container(
                                            height: size.screenHeight * 0.29,
                                            decoration: BoxDecoration(
                                              gradient: const RadialGradient(
                                                radius: 1.3,
                                                center: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromARGB(
                                                    255,
                                                    244,
                                                    255,
                                                    254,
                                                  ),
                                                  Color(0xFFFFFFFF),
                                                  Color(0xFFFFFFFF),
                                                ],
                                                stops: [0.6, 0.8, 1.0],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                      20,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                            ),
                                            child: TabBarView(
                                              children: [
                                                // Вкладка "Уведомления"
                                                TabBarUvedomleniyaPage(
                                                  size: size,
                                                  categories: categories,
                                                  documents: documents,
                                                ),
                                                // Вкладка "Заявления"
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: size.otstup10,
                                                    vertical: size.otstup10,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CardTestPageForApplications(
                                                              categories:
                                                                  categories,
                                                              documents:
                                                                  documents,
                                                            ),
                                                      ),
                                                      Center(
                                                        child: My_Button(
                                                          width:
                                                              size.screenWidth *
                                                              0.815,
                                                          size: size,
                                                          borderRadius: 10,
                                                          backgroundColor:
                                                              primaryButtonColor,
                                                          borderColor:
                                                              primaryButtonColor,
                                                          onPressed: () {},
                                                          child: const Text(
                                                            "Все заявки",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.only(
                                      //   topLeft: Radius.circular(50),
                                      //   topRight: Radius.circular(10),
                                      // ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: size.otstup30),

                                        // MyDocumentsWidget(size: size, docColors: docColors),
                                        // SizedBox(height: size.otstup20),

                                        // LifeEvents(
                                        //   size: size,
                                        //   categories: categories,
                                        // ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.otstup15,
                                        vertical: size.otstup20,
                                      ),
                                      child: Column(
                                        children: [
                                          //SEARCH
                                          MainCategoryServicesPage(
                                            height: size.otstup30,
                                            itemCount: 5,
                                            size: size,
                                            categories: categories,
                                            documents: documents,
                                            leftWidget: textWithH1Style(
                                              "Категории услуг",
                                            ),
                                            rightWidget: Text(
                                              'Все категории',
                                              style: h2TitleNotSoBold,
                                            ),
                                          ),
                                          SizedBox(height: size.otstup20),
                                          MainPagePopularServices(
                                            size: size,
                                            categories: categories,
                                          ),
                                          SizedBox(height: size.otstup18),
                                          CarouselSlider.builder(
                                            itemCount: 3,
                                            itemBuilder: (
                                              context,
                                              index,
                                              newIndex,
                                            ) {
                                              return Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          borderLinearGradient,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.all(
                                                        3.3,
                                                      ),
                                                      width: double.infinity,

                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        gradient:
                                                            RadialGradient(
                                                              radius: 1.5,
                                                              colors: [
                                                                Color(
                                                                  0xFF015057,
                                                                ),

                                                                // Color(
                                                                //   0xFF000707,
                                                                // ),
                                                                Color(
                                                                  0xFF5EB681,
                                                                ),

                                                                Color(
                                                                  0xFF2BBA7D,
                                                                ),
                                                              ],
                                                              stops: [
                                                                0.0,
                                                                0.0,
                                                                1.0,
                                                              ],
                                                            ),
                                                      ),
                                                      height: 165,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.otstup20,
                                                              vertical:
                                                                  size.otstup20,
                                                            ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ContainerAsButton(
                                                              textColor:
                                                                  Colors.black,
                                                              size: size,
                                                              text: "Категория",
                                                              backGroundColor:
                                                                  // Color(
                                                                  //   0xFF2BBA7D,
                                                                  // ),
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.otstup20,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.screenWidth *
                                                                  0.7,
                                                              child: textWithH1Style(
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                "Государственная вакцинация населения",
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                fontsize: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                      child: Image.asset(
                                                        "assets/images/Vector (6).png",
                                                        width:
                                                            size.screenWidth *
                                                            0.43,
                                                      ),
                                                    ),
                                                  ),

                                                  Positioned(
                                                    bottom: 20,
                                                    right: 20,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size:
                                                            size.cancelIconSize50,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              viewportFraction: 1,
                                              aspectRatio: 2.2,
                                              enlargeCenterPage: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error:
          (error, st) => Center(child: Text("Qwwwee: ${error},Where: ${st}")),
      loading: () => HomePageShimmer(),
    );
  }
}

class MyDocumentsWidget extends StatelessWidget {
  const MyDocumentsWidget({
    super.key,
    required this.size,
    required this.docColors,
  });

  final AdaptiveSizes size;
  final List<Map<String, dynamic>> docColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.otstup20, bottom: size.otstup20),
          child: textWithH1Style("Мои документы"),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.otstup20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: greyTextFBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.otstup20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...docColors.map((item) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: item['color'],
                              borderRadius: BorderRadius.circular(
                                size.otstup10,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(item["image"]),
                            ),
                          ),

                          Positioned(
                            right: 0,
                            top: 5,
                            child: Image.asset(item["iconImage"]),
                          ),
                        ],
                      ),

                      textWithH1Style(
                        item['text'],
                        fontsize: 16,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
