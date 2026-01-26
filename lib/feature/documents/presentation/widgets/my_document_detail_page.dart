import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/document_detail_info_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/separating_spec.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_documents_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/my_expansion_tile_for_detail_info.dart';

class MyDocumentDetailPage extends ConsumerStatefulWidget {
  final MyDocumentsModel docModel;
  final int index;
  final int id;
  const MyDocumentDetailPage({
    super.key,
    required this.docModel,
    required this.index,
    required this.id,
  });

  @override
  ConsumerState<MyDocumentDetailPage> createState() =>
      _MyDocumentDetailPageState();
}

class _MyDocumentDetailPageState extends ConsumerState<MyDocumentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final info = widget.docModel.data;
    final index = widget.index;
    final id = widget.id;

    final asyncDocDetailInfo = ref.watch(documentDetailInfoProvider(id));
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
                children: [
                  //Document title
                  textWithH1Style(
                    info.registers[index].document.ru,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: size.otstup15),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          width: size.screenHeight * 0.4,
                          height: size.screenWidth * 0.8,
                        ),
                      ],
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
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(size.otstup35),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup18),
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
                                      fontsize: 19,
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
                            border: Border.all(),
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
                                      "Статус",
                                      fontsize: 15,
                                      fontW: FontWeight.normal,
                                    ),
                                    textWithH1Style(
                                      detailInfo.status.status,
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(size.otstup35),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.otstup18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      "Номер документа",
                                      fontW: FontWeight.normal,
                                      fontsize: 15,
                                    ),
                                    textWithH1Style(
                                      detailInfo.number,
                                      fontsize: 19,
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
                            border: Border.all(),
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
                    docModel: widget.docModel,
                    index: index,
                  ),
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
