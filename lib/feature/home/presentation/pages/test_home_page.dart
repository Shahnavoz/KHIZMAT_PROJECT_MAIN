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
import 'package:khizmat_new/feature/home/presentation/widgets/life_events.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_page_popular_services.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/tab_bar_uvedomleniya_page.dart';

class TestHomePage extends ConsumerStatefulWidget {
  const TestHomePage({super.key});

  @override
  ConsumerState<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends ConsumerState<TestHomePage> {
  var searchController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> items = List.generate(10, (index) => 'Элемент $index');
  TextEditingController searchController1 = TextEditingController();

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
            // backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                // SliverAppBar(
                //   backgroundColor: Colors.grey,
                //   foregroundColor: Colors.white,
                //   pinned: true,
                //   expandedHeight: 750,
                //   automaticallyImplyLeading: false,
                //   title: Padding(
                //     padding: const EdgeInsets.only(left: 15),
                //     child: Row(
                //       children: [
                //         CircleAvatar(
                //           backgroundColor: Colors.white.withOpacity(
                //             0.8,
                //           ), // Полупрозрачный фон
                //         ),
                //         SizedBox(width: 15),
                //         Text(
                //           "Shahnavoz",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   actions: [
                //     Row(
                //       children: [
                //         IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.notifications_none_outlined,
                //             color: Colors.white,
                //           ),
                //         ),
                //         IconButton(
                //           onPressed: () async {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => ScanQrPage(),
                //               ),
                //             );
                //           },
                //           icon: Icon(Icons.qr_code, color: Colors.white),
                //         ),
                //       ],
                //     ),
                //   ],
                //   flexibleSpace: FlexibleSpaceBar(
                //     collapseMode: CollapseMode.parallax,
                //     background: Stack(
                //       fit: StackFit.expand,
                //       children: [
                //         Image.asset(
                //           "assets/images/WHITE MAINcut.png",
                //           fit: BoxFit.cover,
                //           width: double.infinity,
                //           // height: 200,
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //             gradient: LinearGradient(
                //               begin: Alignment.topCenter,
                //               end: Alignment.bottomCenter,
                //               colors: [
                //                 Colors.black.withOpacity(0.3),
                //                 Colors.transparent,
                //               ],
                //             ),
                //           ),
                //         ),
                //         Positioned(
                //           bottom: 50,
                //           left: 0,
                //           right: 0,
                //           child: Padding(
                //             padding: EdgeInsets.only(
                //               left: size.otstup20,
                //               right: size.otstup20,
                //               bottom: size.otstup10,
                //             ),
                //             child: Column(
                //               children: [
                //                 SizedBox(height: 20),
                //                 SingleChildScrollView(
                //                   scrollDirection: Axis.horizontal,
                //                   child: Row(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: List.generate(10, (index) {
                //                       return Padding(
                //                         padding:
                //                             index != 0
                //                                 ? EdgeInsets.only(left: 8)
                //                                 : EdgeInsets.only(left: 0),
                //                         child: Container(
                //                           decoration: BoxDecoration(
                //                             borderRadius: BorderRadius.only(
                //                               topLeft: Radius.circular(13),
                //                               topRight: Radius.circular(13),
                //                             ),
                //                           ),
                //                           child: Container(
                //                             margin: EdgeInsets.all(3.3),
                //                             decoration: BoxDecoration(
                //                               color: primaryButtonColor,
                //                               borderRadius: BorderRadius.only(
                //                                 topLeft: Radius.circular(10),
                //                                 topRight: Radius.circular(10),
                //                               ),
                //                             ),
                //                             child: Padding(
                //                               padding: EdgeInsets.symmetric(
                //                                 horizontal: size.otstup20,
                //                                 vertical:
                //                                     size.horizontalPadding20,
                //                               ),
                //                               child: Column(
                //                                 children: [
                //                                   Row(
                //                                     children: [
                //                                       textWithH1Style(
                //                                         categories[index].title
                //                                             .getText(
                //                                               currentLocale,
                //                                             ),
                //                                         color: Colors.white,
                //                                         fontsize: 16,
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       );
                //                     }),
                //                   ),
                //                 ),
                //                 SizedBox(height: size.otstup15),
                //                 MyTextFieldWithPrefix(
                //                   width: size.screenWidth * 0.9,
                //                   borderColor: greyTextFBorderColor,
                //                   controller: searchController1,
                //                   hintText: "Поиск вопросов",
                //                   backGroundColor: Colors.white,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),

                //         Positioned(
                //           bottom: 50,
                //           child: Column(
                //             children: [
                //               ButtonsBarTitles(size: size),
                //               Padding(
                //                 padding: EdgeInsets.symmetric(
                //                   horizontal: size.otstup20,
                //                 ),
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     // gradient: borderLinearGradient,
                //                     borderRadius: BorderRadius.only(
                //                       bottomLeft: Radius.circular(10),
                //                       bottomRight: Radius.circular(10),
                //                     ),
                //                   ),
                //                   child: Container(
                //                     // margin: EdgeInsets.all(2),
                //                     height: 320,
                //                     decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       gradient: RadialGradient(
                //                         radius: 1.3,
                //                         center: Alignment.bottomRight,
                //                         colors: [
                //                           Color(0xFF98FF88),
                //                           Color(0xFF92FA8E),
                //                           Color(0xFAA2F3FF),
                //                           Color(0xFFFFFF00),
                //                           Color(0xFFFFFFFF),
                //                         ],
                //                         stops: [0.0, 0.0, 0.6, 0.0, 0.11],
                //                       ),
                //                       borderRadius: BorderRadius.only(
                //                         bottomLeft: Radius.circular(10),
                //                         bottomRight: Radius.circular(10),
                //                       ),
                //                     ),
                //                     child: TabBarView(
                //                       children: [
                //                         //UVEDOMLENIYA
                //                         TabBarUvedomleniyaPage(size: size),

                //                         //ZAYAVKI

                //                         // CardTestPage()
                //                         Column(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Padding(
                //                               padding: EdgeInsets.only(
                //                                 top: size.otstup10,
                //                                 left: size.otstup10,
                //                                 right: size.otstup5,
                //                                 // bottom: size.otstup20,
                //                               ),

                //                               //kak sdelat tak chtobi pri scroll ne udalyalsya element a poshol nazad vsekh ostalnikh
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 children: [
                //                                   textWithH1Style(
                //                                     "Последние заявки",
                //                                   ),
                //                                   textWithH2GreyStyle(
                //                                     textAlign: TextAlign.start,
                //                                     "Электронная доверенность на право управления транспортным средством",
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),

                //                             Expanded(
                //                               child: CardTestPage(
                //                                 categories: categories,
                //                                 documents: documents,
                //                               ),
                //                             ),
                //                             SizedBox(height: size.otstup50),

                //                             // TabBarZayavkiListView(size: size),
                //                             Center(
                //                               child: My_Button(
                //                                 width: size.screenWidth * 0.7,
                //                                 size: size,
                //                                 borderRadius: 50,
                //                                 backgroundColor:
                //                                     primaryButtonColor,
                //                                 borderColor: primaryButtonColor,
                //                                 onPressed: () {},
                //                                 child: Text(
                //                                   "Все заявки",
                //                                   style: TextStyle(
                //                                     color: Colors.white,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                             SizedBox(height: size.otstup25),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                pinned: true,
                expandedHeight: 570,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Shahnavoz",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                    // fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/WHITE MAINcut.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        // height: 250,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0, 
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            ButtonsBarTitles(size: size),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                              ),
                              child: Container(
                                height: 320,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  gradient: RadialGradient(
                                    radius: 1.3,
                                    center: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF98FF88),
                                      Color(0xFF92FA8E),
                                      Color(0xFAA2F3FF),
                                      Color(0xFFFFFF00),
                                      Color(0xFFFFFFFF),
                                    ],
                                    stops: [0.0, 0.0, 0.6, 0.0, 0.11],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: TabBarView(
                                  children: [
                                    TabBarUvedomleniyaPage(size: size),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.otstup10,
                                            left: size.otstup10,
                                            right: size.otstup5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textWithH1Style(
                                                "Последние заявки",
                                              ),
                                              textWithH2GreyStyle(
                                                textAlign: TextAlign.start,
                                                "Электронная доверенность на право управления транспортным средством",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: CardTestPage(
                                            categories: categories,
                                            documents: documents,
                                          ),
                                        ),
                                        SizedBox(height: size.otstup50),
                                        Center(
                                          child: My_Button(
                                            width: size.screenWidth * 0.7,
                                            size: size,
                                            borderRadius: 50,
                                            backgroundColor: primaryButtonColor,
                                            borderColor: primaryButtonColor,
                                            onPressed: () {},
                                            child: Text(
                                              "Все заявки",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.otstup25),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: List.generate(10, (index) {
                                    return Padding(
                                      padding: index != 0
                                          ? EdgeInsets.only(left: 8)
                                          : EdgeInsets.only(left: 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(13),
                                            topRight: Radius.circular(13),
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(3.3),
                                          decoration: BoxDecoration(
                                            color: primaryButtonColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.otstup20,
                                              vertical:
                                                  size.horizontalPadding20,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    textWithH1Style(
                                                      categories[index]
                                                          .title
                                                          .getText(
                                                            currentLocale,
                                                          ),
                                                      color: Colors.white,
                                                      fontsize: 16,
                                                    ),
                                                  ],
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
                              SizedBox(height: size.otstup15),
                              MyTextFieldWithPrefix(
                                width: size.screenWidth * 0.9,
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
                    // physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      // decoration: BoxDecoration(color:Colors.red,borderRadius: BorderRadius.circular(50),border: Border.all()),
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 214, 246, 232),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFEBFFF6),
                            Color(0xFFEEF5F2),
                          ],
                          stops: [0.0, 0.19, 2.0],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                // ButtonsBarTitles(size: size),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //     horizontal: size.otstup20,
                                //   ),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       // gradient: borderLinearGradient,
                                //       borderRadius: BorderRadius.only(
                                //         bottomLeft: Radius.circular(10),
                                //         bottomRight: Radius.circular(10),
                                //       ),
                                //     ),
                                //     child: Container(
                                //       // margin: EdgeInsets.all(2),
                                //       height: 320,
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         gradient: RadialGradient(
                                //           radius: 1.3,
                                //           center: Alignment.bottomRight,
                                //           colors: [
                                //             Color(0xFF98FF88),
                                //             Color(0xFF92FA8E),
                                //             Color(0xFAA2F3FF),
                                //             Color(0xFFFFFF00),
                                //             Color(0xFFFFFFFF),
                                //           ],
                                //           stops: [0.0, 0.0, 0.6, 0.0, 0.11],
                                //         ),
                                //         borderRadius: BorderRadius.only(
                                //           bottomLeft: Radius.circular(10),
                                //           bottomRight: Radius.circular(10),
                                //         ),
                                //       ),
                                //       child: TabBarView(
                                //         children: [
                                //           //UVEDOMLENIYA
                                //           TabBarUvedomleniyaPage(size: size),

                                //           //ZAYAVKI

                                //           // CardTestPage()
                                //           Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               Padding(
                                //                 padding: EdgeInsets.only(
                                //                   top: size.otstup10,
                                //                   left: size.otstup10,
                                //                   right: size.otstup5,
                                //                   // bottom: size.otstup20,
                                //                 ),

                                //                 //kak sdelat tak chtobi pri scroll ne udalyalsya element a poshol nazad vsekh ostalnikh
                                //                 child: Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     textWithH1Style(
                                //                       "Последние заявки",
                                //                     ),
                                //                     textWithH2GreyStyle(
                                //                       textAlign:
                                //                           TextAlign.start,
                                //                       "Электронная доверенность на право управления транспортным средством",
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),

                                //               Expanded(
                                //                 child: CardTestPage(
                                //                   categories: categories,
                                //                   documents: documents,
                                //                 ),
                                //               ),
                                //               SizedBox(height: size.otstup50),

                                //               // TabBarZayavkiListView(size: size),
                                //               Center(
                                //                 child: My_Button(
                                //                   width: size.screenWidth * 0.7,
                                //                   size: size,
                                //                   borderRadius: 50,
                                //                   backgroundColor:
                                //                       primaryButtonColor,
                                //                   borderColor:
                                //                       primaryButtonColor,
                                //                   onPressed: () {},
                                //                   child: Text(
                                //                     "Все заявки",
                                //                     style: TextStyle(
                                //                       color: Colors.white,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //               SizedBox(height: size.otstup25),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: size.otstup50),

                                // SizedBox(
                                //   height: 300,
                                //   width: 300,
                                //   child: ListView.separated(
                                //     shrinkWrap: true,
                                //     scrollDirection: Axis.horizontal,
                                //     itemBuilder: (context, index) {
                                //       return Container(
                                //         width: 200,
                                //         height: 200,
                                //         color: Colors.amber,
                                //         child: Column(
                                //           children: [
                                //             Image.asset("assets/icons/Group 831885407.png"),

                                //           ],
                                //         ),
                                //       );
                                //     },
                                //     separatorBuilder:
                                //         (context, index) =>
                                //             SizedBox(height: size.otstup10),
                                //     itemCount: 5,
                                //   ),
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
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

                                        // Column(
                                        //   children: [
                                        //     MainPageCategoryServices(
                                        //       size: size,
                                        //     ),

                                        //     My_Button(
                                        //       borderRadius: 5,
                                        //       width: double.infinity,
                                        //       size: size,
                                        //       backgroundColor: Color(
                                        //         0xFF002629,
                                        //       ),
                                        //       borderColor: Color(0xFF002629),
                                        //       onPressed: () {
                                        //         Navigator.push(
                                        //           context,
                                        //           MaterialPageRoute(
                                        //             builder:
                                        //                 (context) =>
                                        //                     AllCategoriesPage(),
                                        //           ),
                                        //         );
                                        //       },
                                        //       child: textWithH1Style(
                                        //         "Смотреть все",
                                        //         color: Colors.white,
                                        //         fontsize: 16,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
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
                                                    // border: Border.all(),
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
                                                      // border: Border.all(),
                                                      // color: Colors.white,
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
                  ),
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
