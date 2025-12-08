import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/card_page_for_uvedomleni.dart';

class TabBarUvedomleniyaPage extends StatelessWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;
  const TabBarUvedomleniyaPage({
    super.key,
    required this.size,
    required this.categories,
    required this.documents,
  });

  final AdaptiveSizes size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.otstup10,
          vertical: size.otstup10,
        ),
        child: Column(
          children: [
            Expanded(
              child: CardPageForUvedomleni(categories: categories, documents: documents),
            ),
            // SizedBox(
            //   height: size.otstup35,
            // ),
            Center(
              child: My_Button(
                width: size.screenWidth * 0.815,
                size: size,
                borderRadius: 10,
                backgroundColor: primaryButtonColor,
                borderColor: primaryButtonColor,
                onPressed: () {},
                child: const Text(
                  "Все заявки",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // SizedBox(
            //   height: size.otstup65,
            // ),
          ],
        ),
      ),
      //  Column(
      //   mainAxisAlignment:
      //       MainAxisAlignment.center,
      //   children: [
      //     Image.asset(
      //       'assets/icons/Group 831885407.png',
      //       width: size.imageSize100,
      //     ),
      //     SizedBox(height: 20),
      //     SizedBox(
      //       child: Text(
      //         textAlign: TextAlign.center,
      //         "У вас нет новостей",
      //         style: h1Title,
      //         maxLines: 2,
      //       ),
      //     ),
      //     SizedBox(height: size.otstup20),
      //     SizedBox(
      //       width: size.screenWidth * 0.65,
      //       child: Text(
      //         textAlign: TextAlign.center,
      //         "Получайте доступ к услугам в одном приложении",
      //         style: h2TitleNotSoBold,
      //         maxLines: 4,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
