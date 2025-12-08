import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_modal_bottom_sheet.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_or_container_with_two_parts.dart';

class Language {
  final String asset;
  final String code;

  const Language({required this.asset, required this.code});
}

class Dropdownmodal extends ConsumerStatefulWidget {
  const Dropdownmodal({super.key});

  @override
  ConsumerState<Dropdownmodal> createState() => _DropdownmodalState();
}

class _DropdownmodalState extends ConsumerState<Dropdownmodal> {
  final List<Language> languages = const [
    Language(asset: 'assets/icons/image 1 (8).png', code: "Тоҷикӣ"),
    Language(asset: 'assets/icons/image 1 (8).png', code: "Русский"),
    Language(asset: 'assets/icons/image 1 (8).png', code: "English"),
  ];
  final List<Locale> locales = const [Locale('fr'), Locale('ru'), Locale('en')];

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider); // selected language

    return Container(
      // color: Colors.white,
      width: double.infinity,
      height: size.screenHeight * 0.40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ModalAppBar(mainText: "Выберите язык"),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.screenWidth * 0.03,vertical: size.screenHeight*0.02),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final locale = locales[index];

                return ButtonOrContainerWithTwoParts(
                  size: size,
                  horizontalPadPartOne: 8,
                  backGroundColor: Colors.white,
                  oneSideBorderColor: greyBorderColor,

                  /// Левая часть — флаг
                  partOneWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      language.asset,
                      width: 30,
                      // height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Правая часть — Nazvanie + Radio
                  partTwoWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(width: 10),
                      Text(_getLanguageName(locale.languageCode), style: h1Title),
                      SizedBox(width: size.screenWidth*0.4,),
                      Radio<Locale>(
                        value: locale, // unikalnoe znachenie
                        groupValue: currentLocale, // selected language
                        onChanged: (newLocale) {
                          ref
                              .read(localeProvider.notifier)
                              .setLocale(newLocale!);

                              Navigator.pop(context);
                        },
                        activeColor: primaryButtonColor,

                      ),
                    ],
                  ),
                );
              },
              separatorBuilder:
                  (_, __) => SizedBox(height: size.screenHeight * 0.015),
            ),
          ),
        ],
      ),
    );
  }
}


String _getLanguageName(String code) {
  switch (code) {
    case 'ru':
      return 'Русский';
    case 'en':
      return 'English';
    case 'fr':
      return 'Тоҷикӣ';
    default:
      return "";
  }
}
// String _getLanguageImage(String code) {
//   switch (code) {
//     case 'ru':
//       return 'assets/icons/image 1 (8).png';
//     case 'en':
//       return 'assets/icons/Vector (5).png';
//     case 'fr':
//       return 'Тоҷикӣ';
//     default:
//       return "";
//   }
// }
