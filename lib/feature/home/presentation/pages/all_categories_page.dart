import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/bottomNavBar/presentation/pages/bottom_nav_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Gos_organizations_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/search_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';
import 'package:khizmat_new/generated/l10n.dart';

class AllCategoriesPage extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;
  const AllCategoriesPage({
    super.key,
    required this.categories,
    required this.documents,
  });

  @override
  ConsumerState<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends ConsumerState<AllCategoriesPage> {
  final searchController = TextEditingController();

  // final bool isActive = false;
  int currentIndex = 0;
  List<String> tabTexts = ["Все", "Физ.лицам", "Юр.лицам"];
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            textWithH1Style(
              S.of(context).categories,
              fontW: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 5),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavPage())),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
      ),
      body: StackWithBackgroundImage(
        mainChild: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup18,
              vertical: size.otstup35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFieldWithPrefix(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SearchPage(
                              categories: widget.categories,
                              documents: widget.documents,
                              currentLocale: currentLocale,
                            ),
                      ),
                    );
                  },
                  hintText: S.of(context).poisk_uslug,
                  controller: searchController,
                  onChanged: (value) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder:
                    //         (context) => SearchPage(
                    //           categories: widget.categories,
                    //           documents: widget.documents,
                    //           currentLocale: currentLocale,
                    //         ),
                    //   ),
                    // );
                  },
                ),
                SizedBox(height: size.otstup25),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GosOrganizationsPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: Color(0xFFF4F6F3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/Vector (5).svg",
                                  ),
                                ),
                              ),
                              SizedBox(width: size.otstup15),

                              SizedBox(
                                width: size.screenWidth * 0.5,
                                child: textWithH1Style(
                                  S.of(context).gosOrganizations,
                                  textAlign: TextAlign.start,
                                  fontsize: 16,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: primaryButtonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.otstup18),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.generate(tabTexts.length, (index) {
                //     return Padding(
                //       padding: EdgeInsets.all(6.0),
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             currentIndex = index;
                //           });
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color:
                //                 currentIndex == index
                //                     ? Colors.black
                //                     : Color(0xFFFAFAFA),
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(
                //               horizontal: size.otstup25,
                //               vertical: size.otstup10,
                //             ),
                //             child: textWithH1Style(
                //               tabTexts[index],
                //               fontsize: 16,
                //               color:
                //                   currentIndex == index
                //                       ? Colors.white
                //                       : Colors.black,
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   }),
                // ),
                SizedBox(height: size.otstup18),

                textWithH1Style(
                  S.of(context).serviceCategories,
                  fontsize: 18,
                  fontW: FontWeight.w500,
                ),

                currentIndex == 0
                    ? MainCategoryServicesPage(
                      itemCount: widget.categories.length,
                      height: size.otstup5,
                      size: size,
                      categories: widget.categories,
                      documents: widget.documents,
                    )
                    : currentIndex == 1
                    ? Column(
                      children: [
                        // startForm.when(
                        //   data: (data) {
                        //     final fizLitsoUslugi=data.application.data.
                        //   },
                        //   error:
                        //       (error, st) =>
                        //           Center(child: Text(error.toString())),
                        //   loading:
                        //       () => Center(child: CircularProgressIndicator()),
                        // ),
                      ],
                    )
                    : Column(children: []),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StackWithBackgroundImage extends StatelessWidget {
  const StackWithBackgroundImage({super.key, required this.mainChild});
  final Widget mainChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   child: Image.asset(
        //     "assets/images/WHITE MAINcut.png",
        //     fit: BoxFit.cover,
        //     width: double.infinity,
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
        ),
        mainChild,
      ],
    );
  }
}
