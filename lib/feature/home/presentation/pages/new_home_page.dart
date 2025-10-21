import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/card_test_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/scan_qr_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/buttons_bar_titles.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/horizontal_scrollable_widget.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/life_events.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_page_popular_services.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/tab_bar_uvedomleniya_page.dart';

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
    {'color': Color(0xFF5FB889), 'text': 'Паспорт'},
    {'color': Color(0xFF015057), 'text': 'Авто'},
    {'color': Color(0xFF98FF88), 'text': 'Авто'},
    {'color': Color(0xFF90C0BD), 'text': 'Все'},
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

    return asyncAllUpdatedDate.when(
      data: (model) {
        final categories = model?.data.categories ?? [];
        final documents = model?.data.documents ?? [];
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/WHITE MAINcut.png",
                    fit: BoxFit.cover,
                  ),
                ),
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                          isAppBarCollapsed
                              ? Colors
                                  .white
                              : Colors.transparent, 
                      foregroundColor:
                          isAppBarCollapsed
                              ? Colors
                                  .black 
                              : Colors.white,
                      pinned: true,
                      toolbarHeight: kToolbarHeight + 10,
                      expandedHeight: 200,
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 4,
                          ),
                          decoration:
                              !isAppBarCollapsed
                                  ? BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFFFFFFF),
                                        const Color.fromARGB(0, 249, 247, 247),
                                      ],
                                      stops: [0.0,0.7, 1.0],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(150),
                                  )
                                  : BoxDecoration(),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                              ),
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanQrPage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.qr_code, color: Colors.white),
                            ),
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
                                      categories: categories,
                                      size: size,
                                      currentLocale: currentLocale,
                                      selectedIndex: selectedIndex,
                                      oneActiveColor: secondaryColorForScroll,
                                      nonActiveColor: secondaryColorForScroll,
                                      activeTextColor: Colors.white,
                                      nonActiveTextColor: Colors.white,
                                    ),
                                    MyTextFieldWithPrefix(
                                      width: size.screenWidth * 0.92,
                                      borderColor: greyTextFBorderColor,
                                      controller: searchController1,
                                      hintText: "Поиск вопросов",
                                      backGroundColor: Colors.white,
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
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        size.screenWidth *
                                        0.06,
                                    vertical: size.otstup20,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        color: Colors.grey[300]!,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
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
                                          height:
                                              size.screenHeight *
                                              0.42, 
                                          decoration: BoxDecoration(
                                            gradient: const RadialGradient(
                                              radius: 1.3,
                                              center: Alignment.bottomRight,
                                              colors: [
                                                Color.fromARGB(
                                                  255,
                                                  188,
                                                  226,
                                                  224,
                                                ),
                                                Color(0xFFFFFFFF),
                                                // Color(0xFFFFFFFF),
                                                Color(0xFFFFFFFF),
                                              ],
                                              stops: [
                                                0.6,
                                                0.8,
                                                1.0,
                                              ], 
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    20,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    20,
                                                  ),
                                                ),
                                          ),
                                          child: TabBarView(
                                            children: [
                                              // Вкладка "Уведомления"
                                              TabBarUvedomleniyaPage(
                                                size: size,
                                              ),
                                              // Вкладка "Заявления"
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.otstup10,
                                                  vertical: size.otstup10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // textWithH1Style(
                                                    //   "Последние заявки",
                                                    // ),
                                                    textWithH2GreyStyle(
                                                      textAlign:
                                                          TextAlign.start,
                                                      "Электронная доверенность на право управления транспортным средством",
                                                    ),
                                                    Expanded(
                                                      child: CardTestPage(
                                                        categories: categories,
                                                        documents: documents,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.otstup25,
                                                    ),
                                                    Center(
                                                      child: My_Button(
                                                        width:
                                                            size.screenWidth *
                                                            0.7,
                                                        size: size,
                                                        borderRadius: 50,
                                                        backgroundColor:
                                                            primaryButtonColor,
                                                        borderColor:
                                                            primaryButtonColor,
                                                        onPressed: () {},
                                                        child: const Text(
                                                          "Все заявки",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.otstup25,
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
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: size.otstup30),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: size.otstup20,
                                              bottom: size.otstup20,
                                            ),
                                            child: textWithH1Style(
                                              "Мои документы",
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: size.otstup20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: greyTextFBorderColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: size.otstup20,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ...docColors.map((item) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                          ),
                                                          width: 70,
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                item['color'],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  size.otstup20,
                                                                ),
                                                          ),
                                                        ),
                                                        textWithH1Style(
                                                          item['text'],
                                                          fontsize: 16,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.otstup20),
                                      LifeEvents(
                                        size: size,
                                        categories: categories,
                                      ),
                                      MainPagePopularServices(
                                        size: size,
                                        categories: categories,
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.otstup15,
                                      vertical: size.otstup15,
                                    ),
                                    child: Column(
                                      children: [
                                        MainCategoryServicesPage(
                                          size: size,
                                          categories: categories,
                                        ),
                                        SizedBox(height: size.otstup15),
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
                                                    margin: EdgeInsets.all(3.3),
                                                    width: double.infinity,

                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      gradient: RadialGradient(
                                                        radius: 1.5,
                                                        colors: [
                                                          Color(0xFF015057),
                                                          Color(0xFF000707),
                                                          Color(0xFF2BBA7D),
                                                        ],
                                                        stops: [0.0, 0.0, 1.0],
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
                                                            size: size,
                                                            text: "Категория",
                                                            backGroundColor:
                                                                Color(
                                                                  0xFF2BBA7D,
                                                                ),
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
                                                                  Colors.white,
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, st) => Center(child: Text("${error}")),
      loading:
          () => Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
