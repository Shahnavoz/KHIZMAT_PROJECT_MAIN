import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/Faq_page.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/footer_company_text.dart';
import 'package:khizmat_new/generated/l10n.dart';

class MainQuestionPage extends StatefulWidget {
  const MainQuestionPage({super.key});

  @override
  State<MainQuestionPage> createState() => _MainQuestionPageState();
}

class _MainQuestionPageState extends State<MainQuestionPage> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      // appBar: AppBar(title: Text("Основные вопросы", style: h1RobotoTitle),toolbarHeight: 60,),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.otstup15, left: 5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Text("Основные вопросы", style: h1RobotoTitle),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: size.otstup20),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.screenWidth * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWithH1Style("Основные вопросы"),
                        SizedBox(height: size.screenHeight * 0.015),
                        textH2GreyTitle(
                          textColor: lightBlackTextColor,
                          "Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.Для доступа в мобильное приложение, произвеите вход при помощи сервиса ИМЗО.",
                        ),
                        SizedBox(height: size.screenHeight * 0.02),
                        //BA TEXTFIELD KARDAN DARKOR
                        MyTextFieldWithPrefix(
                          controller: searchController,
                          hintText: 'Поиск вопросов',
                          onChanged: (p0) {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.screenHeight * 0.04),

                  Divider(),
                  //FAQPAGE
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.screenWidth * 0.03,
                      vertical: size.screenHeight * 0.012,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWithH1Style(S.of(context).osnovniye_voprosi),
                        SizedBox(
                          height: size.screenHeight * 0.45,
                          child: FaqPage(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.screenWidth * 0.02,
                  vertical: 6,
                ),
                child: FooterCompanyText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFieldWithPrefix extends StatelessWidget {
  final String hintText;
  final double? width;
  final Color borderColor;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final Color backGroundColor;
  final void Function(String)? onChanged;
  const MyTextFieldWithPrefix({
    super.key,
    required this.hintText,
    this.width,
    this.borderColor = greyTextFBorderColor,
    this.prefixIcon,
    required this.controller,
    this.obsecureText = false,
    this.validator,
    this.backGroundColor = greyButtonBorderColor,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor,
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10),
            borderRadius: BorderRadius.circular(10),

            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor),
          ),
          prefixIcon:
              prefixIcon ?? Icon(Icons.search, color: greyIconColor),
          hintText: hintText,
          hintStyle: TextStyle(color: primaryGreyTextColor),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
