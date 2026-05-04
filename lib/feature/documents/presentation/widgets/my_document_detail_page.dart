import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/document_detail_info_provider.dart';
import 'package:khizmat_new/feature/documents/data/repos/my_document_detail_service.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/document_opener.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_forTaken_documents.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_applications.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_documents_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_electronal_signature.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_payments.dart';
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
  PdfViewerController? _pdfController;
  bool _isPdfLoading = true;
  String? _pdfError;
  int _currentPage = 1;
  int _totalPages = 0;
  // Not final — allows the retry button to recreate the future.
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
    // Create the future once — FutureBuilder must not recreate it on rebuild.
    _pdfFuture = MyDocumentDetailService()
        .getCertificateUrl(widget.id, widget.currentLocale);
  }
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

  Uint8List? _pdfBytes;

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final info = widget.docModel.data;
    final index = widget.index;
    final appId = widget.id;

    final testUrl =
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
    print(testUrl);

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
                    detailInfo!.document!.ru!,
                    // info!.registers[index].document!.ru!,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: size.otstup15),
                  Container(
                    height: size.screenHeight * 0.45,
                    child: FutureBuilder<Uint8List>(
                      future: _pdfFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Не удалось загрузить документ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  snapshot.error.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Повторить'),
                                  onPressed: () => setState(() {
                                    _pdfFuture = MyDocumentDetailService()
                                        .getCertificateUrl(
                                            widget.id, widget.currentLocale);
                                  }),
                                ),
                              ],
                            ),
                          );
                        }

                        final bytes = snapshot.data;
                        if (bytes == null || bytes.isEmpty) {
                          return const Center(child: Text("Документ пустой"));
                        }

                        // Store bytes for the save button without triggering
                        // an extra rebuild — assign directly since we are
                        // already inside the builder (no setState needed here).
                        _pdfBytes = bytes;

                        return DocumentOpenerWithBytes(pdfBytes: bytes);
                      },
                    ),
                  ),
                  SizedBox(height: size.otstup35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_pdfBytes != null && _pdfBytes!.isNotEmpty) {
                            final fileName =
                                "certificate_${widget.id}_${DateTime.now().millisecondsSinceEpoch}.pdf";
                            await savePdfToDownloads(
                              _pdfBytes!,
                              fileName,
                              context,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Документ ещё не загружен или пустой",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkPrimaryGreenColor,
                            borderRadius: BorderRadius.circular(
                              size.otstup35,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.downloading_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: size.otstup10),
                                textWithH1Style(
                                  "Сохранить",
                                  color: Colors.white,
                                  fontsize: 16,
                                  fontW: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.otstup15),
                      GestureDetector(
                        onTap: () async {
                          if (_pdfBytes != null && _pdfBytes!.isNotEmpty) {
                            final fileName =
                                "certificate_${widget.id}.pdf";
                            await SharePlus.instance.share(
                              ShareParams(
                                files: [
                                  XFile.fromData(
                                    _pdfBytes!,
                                    name: fileName,
                                    mimeType: 'application/pdf',
                                  )
                                ],
                                subject: fileName,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Документ ещё не загружен или пустой",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: darkPrimaryGreenColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.otstup20),
                  Column(
                    children: [
                      Container(
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
                              SizedBox(width: size.otstup15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    "Тип документа",
                                    fontW: FontWeight.normal,
                                    fontsize: 15,
                                  ),
                                  textWithH1Style(
                                    detailInfo!.typeTitle!.getText(
                                      currentLocale,
                                    ),
                                    fontsize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.otstup15),
                      Container(
                        decoration: BoxDecoration(
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
                                    detailInfo.status!.title!.getText(
                                      currentLocale,
                                    ),
                                    fontsize: 16,
                                  ),
                                ],
                              ),
                            ],
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
                                      detailInfo.number!,
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
                                      "Дата выдачи",
                                      fontsize: 15,
                                      fontW: FontWeight.normal,
                                    ),
                                    textWithH1Style(
                                      detailInfo.registrationDate!,
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
                  ExpansionTileForDocumentsPage(
                    size: size,
                    title: "Общая информация",
                    currentLocale: currentLocale,
                    docModel: data,
                    index: index,
                  ),
                  SizedBox(height: size.otstup15),
                  data.data!.pkiSignatures != null
                      ? Column(
                        children: [
                          ExpansionTileForElectronalSignaturesPage(
                            currentLocale: currentLocale,
                            size: size,
                            title: "Электронная подпись документа",
                            docModel: data,
                            index: index,
                          ),
                          SizedBox(height: size.otstup15),
                        ],
                      )
                      : SizedBox.shrink(),

                  data.data!.attachments!.isNotEmpty
                      ? Column(
                        children: [
                          ExpansionTileForTakenDocuments(
                            size: size,
                            title: "Приложенные документы",
                            currentLocale: currentLocale,
                            index: index,
                            attachments: data.data!.attachments!,
                          ),
                          SizedBox(height: size.otstup15),
                        ],
                      )
                      : SizedBox.shrink(),

                  data.data!.payments!.isNotEmpty
                      ? Column(
                        children: [
                          ExpansionTileForPayments(
                            size: size,
                            title: "Платежи",
                            currentLocale: currentLocale,
                            index: index,
                            payments: data.data!.payments!,
                          ),
                          SizedBox(height: size.otstup15),
                        ],
                      )
                      : SizedBox.shrink(),

                  data.data!.applications!.isNotEmpty
                      ? ExpansionTileForApplications(
                        size: size,
                        title: "Все заявки",
                        currentLocale: currentLocale,
                        index: index,
                        applications: data.data!.applications!,
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
