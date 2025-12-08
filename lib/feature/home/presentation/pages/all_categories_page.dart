import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/main_category_services_page.dart';

class AllCategoriesPage extends StatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;
  const AllCategoriesPage({
    super.key,
    required this.categories,
    required this.documents,
  });

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            textWithH1Style(
              "Категории",
              fontW: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 5),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
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
                textWithH1Style("Категории услуг"),
                MainCategoryServicesPage(
                  itemCount: widget.categories.length,
                  height: size.otstup10,
                  size: size,
                  categories: widget.categories,
                  documents: widget.documents,
                ),
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
        Container(
          child: Image.asset(
            "assets/images/WHITE MAINcut.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
        ),
        mainChild
      ],
    );
  }
}
