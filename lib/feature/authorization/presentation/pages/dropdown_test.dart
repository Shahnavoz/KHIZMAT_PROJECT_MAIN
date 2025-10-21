import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_or_container_with_two_parts.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/dropDownModal.dart';

class Language {
  final String asset;

  const Language(this.asset);
}

class LanguageDropdown extends ConsumerStatefulWidget {
  const LanguageDropdown({super.key});

  @override
  ConsumerState<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends ConsumerState<LanguageDropdown> {
  final List<Language> languages = const [
    Language('assets/icons/image 1 (8).png'),
    Language('assets/icons/image 1 (8).png'),
    Language('assets/icons/image 1 (8).png'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocal = ref.watch(localeProvider);
    final size = AdaptiveSizes(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Dropdownmodal();
          },
        );
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: ButtonOrContainerWithTwoParts(
          borderRadius: 8,
          horizontalPadPartOne: 8,
          size: size,
          partOneWidget: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              currentLocal.countryCode == "RU"
                  ? languages[0].asset
                  : currentLocal.countryCode == "EN"
                  ? languages[1].asset
                  : languages[2].asset,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
          partTwoWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _getLanguageName(currentLocal.languageCode),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backGroundColor: Colors.transparent,
          // oneSideBorderColor: Colors.grey,
          oneSideBorderColor: greyButtonbackColor,
        ),
        //  Row(
        //   children: [

        // ClipRRect(
        //   borderRadius: BorderRadius.circular(4),
        //   child: Image.asset(
        //     currentLocal.countryCode == "RU"
        //         ? languages[0].asset
        //         : currentLocal.countryCode == "EN"
        //         ? languages[1].asset
        //         : languages[2].asset,
        //     width: 20,
        //     height: 20,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // Text("RU")
        //   ],
        // ),
        // DropdownButton<Locale>(
        //   elevation: 0,
        //   value: currentLocal,
        //   underline: const SizedBox(),
        //   dropdownColor: Colors.white,
        //   borderRadius: BorderRadius.circular(12),
        //   icon: SizedBox.shrink(),
        //   items:
        //       S.delegate.supportedLocales.map((locale) {
        //         return DropdownMenuItem<Locale>(
        //           value: locale,
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(4),
        //   child: Image.asset(
        //     currentLocal.countryCode == "RU"
        //         ? languages[0].asset
        //         : currentLocal.countryCode == "EN"
        //         ? languages[1].asset
        //         : languages[2].asset,
        //     width: 20,
        //     height: 20,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        //                 const SizedBox(width: 6),
        //                 SizedBox(
        //                   height: 10,
        //                   child: const VerticalDivider(
        //                     color: Colors.grey,
        //                     thickness: 1,
        //                     width: 1,
        //                   ),
        //                 ),
        //                 const SizedBox(width: 6),
        //                 Text(
        //                   getLanguageName(locale.languageCode, context),
        //                   style: const TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 10,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //   onChanged: (Locale? newLocale) {
        //     if (newLocale != null) {
        //       ref.read(localeProvider.notifier).setLocale(newLocale);
        //     }
        //   },
        // ),
      ),
    );
  }
}



String _getLanguageName(String code) {
  switch (code) {
    case 'ru':
      return 'RU';
    case 'en':
      return 'EN';
    case 'fr':
      return 'TJ';
    default:
      return "";
  }
}