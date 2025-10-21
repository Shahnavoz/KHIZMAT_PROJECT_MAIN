import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';

class LifeEvents extends ConsumerStatefulWidget {
  const LifeEvents({super.key, required this.size, required this.categories});
  final AdaptiveSizes size;
  final List<CategoryElement> categories;

  @override
  ConsumerState<LifeEvents> createState() => _LifeEventsState();
}

class _LifeEventsState extends ConsumerState<LifeEvents> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    return Container(
      width: double.infinity,
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
          vertical: size.otstup15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWithH1Style("Жизненные случаи"),
            SizedBox(height: size.otstup35),
            SizedBox(
              height: size.screenHeight * 0.17,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: size.otstup25),
                    child: Container(
                      width: 120,
                      // height: 200,
                      decoration: BoxDecoration(
                        // border: Border.all(color: greyTextFBorderColor),
                        borderRadius: BorderRadius.circular(12),
                        gradient: RadialGradient(
                          // center: Alignment.center,
                          radius: 0.9,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                            Color.fromARGB(255, 236, 236, 236),
                          ],
                          stops: [ 0.0, 0.6, 3.0],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.otstup15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/Group 831885407.png"),
                            SizedBox(height: size.otstup15),
                            textWithH1Style(
                              'Родился ребенок',
                              fontW: FontWeight.w500,
                              fontsize: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // GridView.builder(
              //   itemCount: widget.categories.length,
              //   scrollDirection: Axis.horizontal,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 1,
              //     mainAxisSpacing: size.otstup20,
              //     crossAxisSpacing: 10,
              //     childAspectRatio: 0.7,
              //   ),
              //   itemBuilder: (context, index) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         gradient: borderLinearGradient,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Container(
              //         margin: EdgeInsets.all(3.3),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //             horizontal: size.otstup15,
              //             vertical: size.otstup15,
              //           ),
              //           child: Column(
              //             children: [
              //               widget.categories[index].iconId != null
              //                   ? Container(
              //                     padding: EdgeInsets.all(8),
              //                     decoration: BoxDecoration(
              //                       // border: Border.all(),
              //                       shape: BoxShape.circle,
              //                       color: primaryButtonColor,
              //                     ),

              //                     child: Image.network(
              //                       widget.categories[index].iconId!,
              //                       width: size.imageSize100,
              //                       color: Colors.white,
              //                     ),
              //                   )
              //                   : Container(
              //                     padding: EdgeInsets.all(8),
              //                     decoration: BoxDecoration(
              //                       // border: Border.all(),
              //                       shape: BoxShape.circle,
              //                       color: primaryButtonColor,
              //                     ),
              //                     child: Image.asset(
              //                       "assets/icons/Group 831885407.png",
              //                     ),
              //                   ),
              //               SizedBox(height: size.otstup15),
              //               SizedBox(
              //                 width: size.screenWidth,
              //                 child: Text(
              //                   overflow: TextOverflow.ellipsis,
              //                   widget.categories[index].description.getText(
              //                     currentLocale,
              //                   ),
              //                   style: categoryTextRobotoTitle,
              //                   maxLines: 3,
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
