import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/button_modal_bottom_sheet.dart';

class SupportModal extends ConsumerStatefulWidget {
  const SupportModal({super.key});

  @override
  ConsumerState<SupportModal> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends ConsumerState<SupportModal> {
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
            return SupportCard(
              size: size,
              widget: ButtonModalBottomSheet(size: size),
            );
          },
        );
      },
    );
  }
}
