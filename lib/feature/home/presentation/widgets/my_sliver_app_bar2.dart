import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';

class MySliverAppBar2 extends ConsumerStatefulWidget {
  const MySliverAppBar2({
    super.key,
    required this.size,
    required this.searchController,
    required this.categories,
  });

  final AdaptiveSizes size;
  final TextEditingController searchController;
  final List<CategoryElement> categories;

  @override
  ConsumerState<MySliverAppBar2> createState() => _MySliverAppBar2State();
}

class _MySliverAppBar2State extends ConsumerState<MySliverAppBar2> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(255, 214, 246, 232),
      // pinned: true,
      expandedHeight: 115,
      toolbarHeight: 115,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 246, 232),
            gradient: RadialGradient(
                radius: 20.0,
                center: Alignment.topLeft,
                colors: [
                  Color(0xFF015057),
                  Color(0xFF26AC71),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.0, 0.12, 1.9],
              ),
            // gradient: RadialGradient(
            //   center: Alignment(0.00, 5.0),
            //   radius: 0.8,
            //   colors: [
            //     const Color(0xFF98FF88),
            //     const Color(0xFF5FB889),
            //     const Color(0xFF308470),
            //     const Color(0xFF015057),
            //   ],
            //   stops: [0.2,0.43,1.55,1.92]
            // ),
            // color: Color.fromARGB(255, 5, 66, 70),
            // color: Color(0xFF00191C),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(20),
            //     bottomRight: Radius.circular(20),
            //   ),
            // ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.size.otstup20,
              right: widget.size.otstup20,
              bottom: widget.size.otstup10,
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(widget.categories.length, (index) {
                      return Padding(
                        padding:
                            index != 0
                                ? EdgeInsets.only(left: 8)
                                : EdgeInsets.only(left: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: [
                            //     // Color(0xFF00191C),
                            //     // Color.fromARGB(248, 242, 242, 203), // 0%
                            //     Color.fromARGB(
                            //       255,
                            //       16,
                            //       64,
                            //       70,
                            //     ), // 50% (12% прозрачности)
                            //     Color.fromARGB(245, 71, 71, 59),
                            //     Color(0xFF00191C), // 50% (12% прозрачности)
                            //     // Color(0xFF00191C), // 50% (12% прозрачности)
                            //   ],
                            //   stops: [0.0, 1.0, 0.0],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3.3),
                            decoration: BoxDecoration(
                              color: primaryButtonColor,
                              // color: Color(0xFF000000),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.size.otstup20,
                                vertical: widget.size.horizontalPadding20,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      textWithH1Style(
                                        widget.categories[index].title.getText(
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
                SizedBox(height: widget.size.otstup15),
                MyTextFieldWithPrefix(
                  borderColor: greyTextFBorderColor,
                  controller: widget.searchController,
                  hintText: "Поиск вопросов",
                  backGroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
