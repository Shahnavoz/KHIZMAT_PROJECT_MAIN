// import 'dart:ui';

import 'dart:typed_data';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/core/config/app_config.dart';
import 'package:khizmat_new/feature/documents/data/models/my_application_detail_info_model.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/document_opener.dart';
import 'package:khizmat_new/generated/l10n.dart';

class ApplicationView extends ConsumerStatefulWidget {
  final List<Step> steps;
  final int applicationId;

  const ApplicationView({
    super.key,
    required this.steps,
    required this.applicationId,
  });

  @override
  ConsumerState<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends ConsumerState<ApplicationView> {
  final _storage = const FlutterSecureStorage();

  Future<void> _downloadAttachedFile(
      BuildContext context, int fileId) async {
    try {
      final token = await _storage.read(key: 'token');
      final url = AppConfig.fileDownload(fileId, widget.applicationId);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/octet-stream',
        },
      );
      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        throw Exception('Сервер вернул ${response.statusCode}');
      }
      final fileName = 'file_${fileId}_${DateTime.now().millisecondsSinceEpoch}';
      // Determine extension from content-type
      final ct = response.headers['content-type'] ?? '';
      final ext = ct.contains('pdf')
          ? '.pdf'
          : ct.contains('png')
              ? '.png'
              : ct.contains('jpeg') || ct.contains('jpg')
                  ? '.jpg'
                  : '';
      await savePdfToDownloads(
          response.bodyBytes, '$fileName$ext', context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка скачивания: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);

    final sortedSteps = [...widget.steps]
      ..sort((a, b) => a.position.compareTo(b.position));

    return Column(
      children:
          sortedSteps
              .map((step) => _buildStep(step, currentLocale, size))
              .toList(),
    );
  }

  Widget _buildStep(Step step, Locale currentLocale, AdaptiveSizes size) {
    final stepTitle = step.title.getText(currentLocale).trim();

    final hasVisibleContent = step.groups.any(
      (group) => group.fields.isNotEmpty,
    );
    if (!hasVisibleContent) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (stepTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Text(
                stepTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryGreenColor,
                ),
              ),
            ),

          Builder(
            builder: (context) {
              switch (step.type) {
                case "FORM":
                  return _buildFormStep(step, currentLocale, size);
                case "REQUIREMENTS":
                  return _buildRequirementsStep(step, currentLocale);
                case "PAYMENT":
                  return _buildPaymentStep(step, currentLocale);
                default:
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Неизвестный тип шага: ${step.type}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormStep(Step step, Locale currentLocale, AdaptiveSizes size) {
    final sortedGroups = [...step.groups]
      ..sort((a, b) => a.position.compareTo(b.position));

    final visibleGroups =
        sortedGroups.where((g) => g.fields.isNotEmpty).toList();

    if (visibleGroups.isEmpty) return const SizedBox.shrink();

    return Column(
      children:
          visibleGroups.map((group) {
            return _buildGroupAsExpansionTile(group, currentLocale, size);
          }).toList(),
    );
  }

  Widget _buildRequirementsStep(Step step, Locale currentLocale) {
    if (step.groups.isEmpty) return const SizedBox.shrink();

    final group = step.groups.first;
    final sortedFields = [...group.fields]
      ..sort((a, b) => a.position.compareTo(b.position));

    if (sortedFields.isEmpty) return const SizedBox.shrink();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          group.title.getText(currentLocale) ?? "Требования",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  sortedFields.asMap().entries.map((entry) {
                    final index = entry.key;
                    final field = entry.value;
                    final rawText = field.option?.getText(currentLocale) ?? '';
                    final cleanText =
                        rawText.replaceAll(RegExp(r'<[^>]*>'), '').trim();

                    if (cleanText.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}. ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              cleanText,
                              style: const TextStyle(fontSize: 15, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep(Step step, Locale currentLocale) {
    final stepTitle = step.title.getText(currentLocale);

    if (step.groups.isEmpty) {
      return SizedBox.shrink();
    }
    return const Text("Раздел оплаты в разработке");
  }

  String cleanHtmlText(String? html) {
    if (html == null) return '';
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  Widget _buildGroupAsExpansionTile(
    Group group,
    Locale currentLocale,
    AdaptiveSizes size,
  ) {
    final sortedFields = [...group.fields]
      ..sort((a, b) => a.position.compareTo(b.position));
    if (sortedFields.isEmpty) {
      return const SizedBox.shrink();
    }

    final groupTitleRaw = group.title.getText(currentLocale).trim();
    final displayTitle = groupTitleRaw.isNotEmpty ? groupTitleRaw : "";

    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        initiallyExpanded: true,
        title: Text(
          displayTitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  sortedFields
                      .map(
                        (field) => _buildField(
                          sortedFields,
                          field,
                          currentLocale,
                          size,
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildFieldValue(Field field, Locale locale, AdaptiveSizes size) {
  //   String? displayText;

  //   switch (field.type) {
  //     case TypeEnum.input:
  //       if (field.duplicableValues != null &&
  //           field.duplicableValues.isNotEmpty) {
  //         final values =
  //             field.duplicableValues
  //                 .map((dv) => dv.value?.trim() ?? '')
  //                 .where((v) => v.isNotEmpty)
  //                 .toList();

  //         if (values.isNotEmpty) {
  //           displayText = values.join(', ');
  //         }
  //       }
  //       displayText ??= field.value?.trim();
  //       break;

  //     case TypeEnum.dropDown:
  //     case TypeEnum.radioButton:
  //       displayText = field.option?.getText(locale)?.trim();
  //       break;

  //     case TypeEnum.switch_:
  //       displayText =
  //           (field.value == "1" || field.value == "true") ? "Да" : "Нет";
  //       break;

  //     case TypeEnum.file:
  //       displayText = field.title!.ru;
  //       break;

  //     default:
  //       displayText = field.value?.trim();
  //       break;
  //   }

  //   if (displayText == null || displayText.isEmpty) {
  //     return const Text(
  //       "-",
  //       textAlign: TextAlign.right,
  //       style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
  //     );
  //   }

  //   switch (field.type) {
  //     case TypeEnum.switch_:
  //       return Align(
  //         alignment: Alignment.centerRight,
  //         child: Text(
  //           displayText,
  //           style: const TextStyle(fontWeight: FontWeight.w600),
  //         ),
  //       );

  //     case TypeEnum.file:
  //       return Align(
  //         alignment: Alignment.centerRight,
  //         child: Text(
  //           displayText,
  //           style: const TextStyle(fontWeight: FontWeight.w600),
  //         ),
  //       );

  //     default:
  //       return Text(
  //         displayText,
  //         textAlign: TextAlign.right,
  //         style: const TextStyle(fontWeight: FontWeight.w600),
  //       );
  //   }
  // }

  Widget _buildFieldValue(Field field, Locale locale, AdaptiveSizes size) {
    String? displayText;

    switch (field.type) {
      case TypeEnum.input:
        if (field.duplicableValues != null &&
            field.duplicableValues.isNotEmpty) {
          final values =
              field.duplicableValues
                  .map((dv) => dv.value?.trim() ?? '')
                  .where((v) => v.isNotEmpty)
                  .toList();

          if (values.isNotEmpty) {
            displayText = values.join(', ');
          }
        }
        displayText ??= field.value?.trim();
        break;

      case TypeEnum.dropDown:
      case TypeEnum.radioButton:
        displayText = field.option?.getText(locale)?.trim();
        break;

      case TypeEnum.switch_:
        displayText =
            (field.value == "1" || field.value == "true") ? S.of(context).yes : S.of(context).no;
        break;

      case TypeEnum.file:
        if (field.value != null &&
            field.value!.trim().isNotEmpty &&
            field.value != "[]") {
          displayText = S.of(context).file;
        } else {
          displayText = S.of(context).noFile;
        }
        break;

      default:
        displayText = field.value?.trim();
        break;
    }

    if (displayText == null || displayText.isEmpty || displayText == '[]') {
      return SizedBox.shrink();
      // Text(
      //   "-",
      //   textAlign: TextAlign.right,
      //   style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
      // );
    }
    switch (field.type) {
      case TypeEnum.switch_:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            displayText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );

      case TypeEnum.file:
        return Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              final fileId = int.tryParse(field.value ?? '');
              if (fileId != null) {
                _downloadAttachedFile(context, fileId);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(S.of(context).fileIsNotAvailable)),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  displayText ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryGreenColor,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryGreenColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.download_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      default:
        return Text(
          displayText,
          textAlign: TextAlign.right,
          style: const TextStyle(fontWeight: FontWeight.w600),
        );
    }
  }

  bool isEmptyValue(dynamic val) {
    if (val == null) return true;
    if (val is String) return val.trim().isEmpty || val == "[]";
    return false;
  }

  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '') // убираем все теги
        .replaceAll(RegExp(r'\s+'), ' ') // лишние пробелы
        .trim();
  }

  Widget _buildField(
    List<Field> fields,
    Field field,
    Locale currentLocale,
    AdaptiveSizes size,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  field.type != TypeEnum.textBlock
                      ? Text(
                        field.title?.getText(currentLocale) ?? "",
                        style: const TextStyle(color: Colors.grey),
                      )
                      : SizedBox.shrink(child: Text("data")),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildFieldValue(field, currentLocale, size)),
          ],
        ),
        // const SizedBox(height: 8),
        field.type != TypeEnum.textBlock &&
                fields.length != 1 &&
                field != fields.last
            ? Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.5,
                dashLength: 4.0,
                dashColor: Colors.green[100]!,
                dashGapLength: 4.0,
                dashRadius: 5.0,
              ),
            )
            : SizedBox.shrink(),
      ],
    );
  }
}
