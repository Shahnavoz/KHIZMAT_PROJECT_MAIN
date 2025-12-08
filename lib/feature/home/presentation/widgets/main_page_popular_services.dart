import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';

class MainPagePopularServices extends ConsumerStatefulWidget {
  const MainPagePopularServices({
    super.key,
    required this.size,
    required this.categories,
  });
  final AdaptiveSizes size;
  final List<CategoryElement> categories;

  @override
  ConsumerState<MainPagePopularServices> createState() =>
      _MainPagePopularServicesState();
}

class _MainPagePopularServicesState
    extends ConsumerState<MainPagePopularServices> {
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
          // horizontal: size.otstup15,
          vertical: size.otstup15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWithH1Style("Популярные услуги"),
            SizedBox(height: size.otstup35),
            SizedBox(
              height: size.screenHeight * 0.215,
              child: GridView.builder(
                itemCount: widget.categories.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: size.otstup20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3.3),
                    decoration: BoxDecoration(
                      gradient: backGroundContainersGradient,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.otstup15,
                        vertical: size.otstup15,
                      ),
                      child: Column(
                        children: [
                          widget.categories[index].iconId != null
                              ? Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  // border: Border.all(),
                                  // shape: BoxShape.circle,
                                  // color: primaryButtonColor,
                                ),
                  
                                child: Image.asset(
                                  "assets/icons/Group 831885407.png",
                                  // widget.categories[index].iconId!,
                                  width: size.imageSize100,
                                  // color: Colors.white,
                                ),
                              )
                              : Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  // border: Border.all(),
                                  shape: BoxShape.circle,
                                  color: primaryButtonColor,
                                ),
                                child: Image.asset(
                                  "assets/icons/Group 831885407.png",
                                ),
                              ),
                          SizedBox(height: size.otstup15),
                          SizedBox(
                            width: size.screenWidth,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              widget.categories[index].description.getText(
                                currentLocale,
                              ),
                              style: categoryTextRobotoTitle,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
