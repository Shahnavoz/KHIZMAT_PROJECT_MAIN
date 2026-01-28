import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/document_detail_info_provider.dart';
import 'package:khizmat_new/feature/documents/data/repos/my_document_detail_service.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_documents_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_electronal_signature.dart';
import 'package:pdfrx/pdfrx.dart';

class MyDocumentDetailPage extends ConsumerStatefulWidget {
  final MyDocumentsModel docModel;
  final int index;
  final int id;
  final Locale currentLocale;
  const MyDocumentDetailPage({
    super.key,
    required this.docModel,
    required this.index,
    required this.id,
    required this.currentLocale,
  });

  @override
  ConsumerState<MyDocumentDetailPage> createState() =>
      _MyDocumentDetailPageState();
}

class _MyDocumentDetailPageState extends ConsumerState<MyDocumentDetailPage> {
  // String? _filePath;
  // bool _isLoading = true;
  // String? _error;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadDocument();
  // }

  // final service = MyDocumentDetailService();
  // Future<void> _loadDocument() async {
  //   final path = await service.getCertificateUrl(
  //     widget.id,
  //     widget.currentLocale,
  //   );

  //   if (!mounted) return;

  //   setState(() {
  //     _isLoading = false;
  //     if (path != null) {
  //       _filePath = path;
  //     } else {
  //       _error = 'Не удалось загрузить документ';
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final info = widget.docModel.data;
    final index = widget.index;
    final appId = widget.id;

    final url = MyDocumentDetailService().getCertificateUrl(
      appId,
      currentLocale,
    );

    final asyncDocDetailInfo = ref.watch(documentDetailInfoProvider(appId));
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: CustomAppbar(title: "Назад"),
      body: asyncDocDetailInfo.when(
        data: (data) {
          final detailInfo = data.data;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup18,
              vertical: size.otstup18,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Document title
                  textWithH1Style(
                    info!.registers[index].document!.ru!,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: size.otstup15),
                  Center(
                    child: PdfViewer.uri(
                      Uri.parse(url),
                      params: PdfViewerParams(
                        errorBannerBuilder: (
                          context,
                          error,
                          stackTrace,
                          documentRef,
                        ) {
                          return Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Не удалось загрузить PDF',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  child: Text(
                                    error.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),

                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Повторить'),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.otstup35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkPrimaryGreenColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.otstup15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkPrimaryGreenColor,
                            borderRadius: BorderRadius.circular(size.otstup35),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.downloading_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: size.otstup10),
                                textWithH1Style(
                                  "Скачать",
                                  color: Colors.white,
                                  fontsize: 16,
                                  fontW: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkPrimaryGreenColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.otstup20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: greyTextFBorderColor),
                            borderRadius: BorderRadius.circular(size.otstup35),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: darkPrimaryGreenColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      "Тип документа",
                                      fontW: FontWeight.normal,
                                      fontsize: 15,
                                    ),
                                    textWithH1Style(
                                      detailInfo.typeTitle.ru,
                                      fontsize: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.otstup15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: greyTextFBorderColor),
                            borderRadius: BorderRadius.circular(size.otstup35),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: darkPrimaryGreenColor,
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.file_copy_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      "Статус",
                                      fontsize: 15,
                                      fontW: FontWeight.normal,
                                    ),
                                    textWithH1Style(
                                      detailInfo.status.status,
                                      fontsize: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.otstup25),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: greyTextFBorderColor),
                            borderRadius: BorderRadius.circular(size.otstup35),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: darkPrimaryGreenColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      "Номер документа",
                                      fontW: FontWeight.normal,
                                      fontsize: 13,
                                    ),
                                    textWithH1Style(
                                      detailInfo.number,
                                      fontsize: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.otstup15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: greyTextFBorderColor),
                            borderRadius: BorderRadius.circular(size.otstup35),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: darkPrimaryGreenColor,
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.file_copy_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      "Дата выдачи",
                                      fontsize: 15,
                                      fontW: FontWeight.normal,
                                    ),
                                    textWithH1Style(
                                      detailInfo.registrationDate,
                                      fontsize: 19,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.otstup25),
                  ExpansionTileForDocumentsPage(
                    size: size,
                    title: "Общая информация",
                    currentLocale: currentLocale,
                    docModel: data,
                    index: index,
                  ),
                  SizedBox(height: size.otstup15),
                  data.data.pkiSignatures != null
                      ? ExpansionTileForElectronalSignaturesPage(
                        currentLocale: currentLocale,
                        size: size,
                        title: "Электронная подпись документа",
                        docModel: data,
                        index: index,
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
        error: (error, st) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
