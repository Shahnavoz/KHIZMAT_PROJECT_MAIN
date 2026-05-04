import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/shimmers/applications_shimmer.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_applications_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_application_provider.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_application_detail_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/steps_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/container_as_button.dart';
import 'package:khizmat_new/generated/l10n.dart';

class CardTestPageForApplications extends ConsumerStatefulWidget {
  final List<CategoryElement> categories;
  final List<UpdatedDateDocument> documents;

  const CardTestPageForApplications({
    super.key,
    required this.categories,
    required this.documents,
  });

  @override
  _CardTestPageState createState() => _CardTestPageState();
}

class _CardTestPageState extends ConsumerState<CardTestPageForApplications> {
  List<int> _indices = [];
  int _loadedLength = -1;
  int _dismissKey = 0;

  void _initIndices(int length) {
    if (length != _loadedLength) {
      _loadedLength = length;
      _indices = List.generate(length, (i) => i);
    }
  }

  void _moveTopToBottom() {
    setState(() {
      _dismissKey++;
      if (_indices.length < 2) return;
      final top = _indices.removeLast();
      _indices.insert(0, top);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final asyncApplications = ref.watch(applicationProvider);

    return asyncApplications.when(
      data: (model) {
        final apps = (model.data?.applicationList ?? []).take(3).toList();
        _initIndices(apps.length);

        if (apps.isEmpty) {
          return Center(
            child: Text(
              S.of(context).noApplication,
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          );
        }

        if (_indices.isEmpty || _indices.any((i) => i >= apps.length)) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.topCenter,
            children: _indices.asMap().entries.map((entry) {
              final stackIndex = entry.key;
              final appIndex = entry.value;
              final app = apps[appIndex];
              final isTop = stackIndex == _indices.length - 1;
              final verticalOffset = (_indices.length - 1 - stackIndex) * 10.0;

              final cardWidget = Transform.translate(
                offset: Offset(0, verticalOffset),
                child: _buildCard(app, size, currentLocale),
              );

              if (isTop) {
                return Dismissible(
                  movementDuration: const Duration(milliseconds: 10),
                  resizeDuration: const Duration(milliseconds: 2),
                  dragStartBehavior: DragStartBehavior.down,
                  key: ValueKey('top_$_dismissKey'),
                  direction: DismissDirection.vertical,
                  onDismissed: (_) => _moveTopToBottom(),
                  child: cardWidget,
                );
              }
              return cardWidget;
            }).toList(),
          ),
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const Center(child: ApplicationsShimmer()),
    );
  }

  Widget _buildCard(ApplicationItem app, AdaptiveSizes size, Locale locale) {
    final categoryTitle = app.category?.title?.getText(locale) ?? '';
    final docTitle = app.document?.getText(locale) ?? '';
    final statusText = app.status?.title?.getText(locale) ?? '';
    final dateStr = app.registrationDate?.split('T').first ?? '';
    final isCompleted = app.status?.isCompleted == true;

    return SizedBox(
      height: 140,
      child: GestureDetector(
        onTap: () {
          if (app.id == null) return;
          if (app.status?.isInProcess == true) {
            // Resume the form from the step where the user stopped.
            // docId is passed but not used by the resume flow (server drives state).
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StepsPage(
                  docId: app.documentId ?? 0,
                  index: 0,
                  resumeApplicationId: app.id,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyApplicationInReviewDetailPage(
                  id: app.id!,
                  currentLocale: locale,
                ),
              ),
            );
          }
        },
        child: Card(
          color: Colors.white,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: greyTextFBorderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup15,
              vertical: size.otstup10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ContainerAsButton(
                        size: size,
                        text: categoryTitle,
                        backGroundColor: const Color(0xFFEBFFF3),
                        textColor: primaryGreenColor,
                      ),
                    ),
                    if (app.registrationNumber != null)
                      textCWithH2GreyStyle(
                        '№${app.registrationNumber}',
                        fontweight: FontWeight.bold,
                        color: lightBlackTextColor,
                      ),
                  ],
                ),
                SizedBox(height: size.otstup10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      textAlign: TextAlign.start,
                      docTitle,
                      fontsize: 14,
                    ),
                    SizedBox(height: size.otstup10),
                    Row(
                      children: [
                        if (dateStr.isNotEmpty)
                          sameStyleDifColor(dateStr, color: greyDateColor),
                        if (dateStr.isNotEmpty && statusText.isNotEmpty) ...[
                          SizedBox(width: size.otstup5),
                          Container(width: 1, height: 13, color: Colors.grey),
                          SizedBox(width: size.otstup10),
                        ],
                        if (statusText.isNotEmpty)
                          SizedBox(
                            width: size.screenWidth * 0.4,
                            child: sameStyleDifColor(
                              statusText,
                              color: isCompleted
                                  ? const Color(0xFF26AC71)
                                  : const Color(0xFFE79800),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
