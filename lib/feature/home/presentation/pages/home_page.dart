import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/card_test_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/buttons_bar_titles.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/life_events.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_page_popular_services.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/my_sliver_app_bar1.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/my_sliver_app_bar2.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/tab_bar_uvedomleniya_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var searchController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> items = List.generate(10, (index) => 'Элемент $index');

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final asyncAllUpdatedDate = ref.watch(allUpdatedDateProvider);

    return asyncAllUpdatedDate.when(
      data: (model) {
        final categories = model?.data.categories ?? [];
        final documents = model?.data.documents ?? [];
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                MySliverAppBar1(size: size),
                MySliverAppBar2(
                  size: size,
                  searchController: searchController,
                  categories: categories,
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
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
                          stops: [0.0,0.19,2.0]
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.otstup20),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ButtonsBarTitles(size: size),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.otstup20,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // gradient: borderLinearGradient,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      // margin: EdgeInsets.all(2),
                                      height: 320,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                          //UVEDOMLENIYA
                                          TabBarUvedomleniyaPage(size: size),

                                          //ZAYAVKI

                                          // CardTestPage()
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: size.otstup10,
                                                  left: size.otstup10,
                                                  right: size.otstup5,
                                                  // bottom: size.otstup20,
                                                ),

                                                //kak sdelat tak chtobi pri scroll ne udalyalsya element a poshol nazad vsekh ostalnikh
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    textWithH1Style(
                                                      "Последние заявки",
                                                    ),
                                                    textWithH2GreyStyle(
                                                      textAlign:
                                                          TextAlign.start,
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

                                              // TabBarZayavkiListView(size: size),
                                              Center(
                                                child: My_Button(
                                                  width: size.screenWidth * 0.7,
                                                  size: size,
                                                  borderRadius: 50,
                                                  backgroundColor:
                                                      primaryButtonColor,
                                                  borderColor:
                                                      primaryButtonColor,
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
                                ),
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
