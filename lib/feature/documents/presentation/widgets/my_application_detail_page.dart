import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_applications_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/application_detail_info_provider.dart';

import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/expansion_tile_for_applicant_info.dart';

class MyApplicationDetaillPage extends ConsumerStatefulWidget {
  final MyApplicationsModel docModel;
  final int index;
  final int id;
  final Locale currentLocale;
  const MyApplicationDetaillPage({
    super.key,
    required this.docModel,
    required this.index,
    required this.id,
    required this.currentLocale,
  });

  @override
  ConsumerState<MyApplicationDetaillPage> createState() =>
      _MyDocumentDetailPageState();
}

class _MyDocumentDetailPageState
    extends ConsumerState<MyApplicationDetaillPage> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final info = widget.docModel.data;
    final index = widget.index;
    final appId = widget.id;

    final asyncApplicationsDetailInfo = ref.watch(
      applicationDetailInfoProvider(appId),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: CustomAppbar(title: "Назад"),
      body: asyncApplicationsDetailInfo.when(
        data: (data) {
          final detailInfo = data.data;
          final steps = detailInfo.steps;
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
                    info!.applicationList[widget.index].category!.title!
                        .getText(currentLocale),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: size.otstup35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: darkPrimaryGreenColor,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Icon(
                      //       Icons.remove_red_eye_outlined,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: size.otstup15,
                      //   ),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: darkPrimaryGreenColor,
                      //       borderRadius: BorderRadius.circular(size.otstup35),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.downloading_rounded,
                      //             color: Colors.white,
                      //           ),
                      //           SizedBox(width: size.otstup10),
                      //           textWithH1Style(
                      //             "Сохранить",
                      //             color: Colors.white,
                      //             fontsize: 16,
                      //             fontW: FontWeight.normal,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: darkPrimaryGreenColor,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Icon(Icons.send, color: Colors.white),
                      //   ),
                      // ),
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
                                      "Номер заявки",
                                      fontW: FontWeight.normal,
                                      fontsize: 15,
                                    ),
                                    textWithH1Style(
                                      detailInfo.registrationNumber,
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
                                      detailInfo.status.title.getText(
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
                                      "Дата заявки:",
                                      fontsize: 15,
                                      fontW: FontWeight.normal,
                                    ),
                                    textWithH1Style(
                                      "",
                                    //  " detailInfo.actionLog[index].date",
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
                  ExpansionTileForApplicantInfoPage(
                    size: size,
                    title: "Данные заявления",
                    currentLocale: currentLocale,
                    docModel: steps,
                    index: steps.length,
                  ),
                  SizedBox(height: size.otstup15),
                  // data.data.pkiSignatures != null
                  //     ? Column(
                  //       children: [
                  //         ExpansionTileForElectronalSignaturesPage(
                  //           currentLocale: currentLocale,
                  //           size: size,
                  //           title: "Электронная подпись документа",
                  //           docModel: data,
                  //           index: index,
                  //         ),
                  //         SizedBox(height: size.otstup15),
                  //       ],
                  //     )
                  //     : SizedBox.shrink(),

                  // data.data!.attachments!.isNotEmpty
                  //     ? Column(
                  //       children: [
                  //         ExpansionTileForTakenDocuments(
                  //           size: size,
                  //           title: "Приложенные документы",
                  //           currentLocale: currentLocale,
                  //           index: index,
                  //           attachments: data.data!.attachments!,
                  //         ),
                  //         SizedBox(height: size.otstup15),
                  //       ],
                  //     )
                  //     : SizedBox.shrink(),

                  // data.data!.payments!.isNotEmpty
                  //     ? Column(
                  //       children: [
                  //         ExpansionTileForPayments(
                  //           size: size,
                  //           title: "Платежи",
                  //           currentLocale: currentLocale,
                  //           index: index,
                  //           payments: data.data!.payments!,
                  //         ),
                  //         SizedBox(height: size.otstup15),
                  //       ],
                  //     )
                  //     : SizedBox.shrink(),

                  // data.data!.applications!.isNotEmpty
                  //     ? ExpansionTileForApplications(
                  //       size: size,
                  //       title: "Все заявки",
                  //       currentLocale: currentLocale,
                  //       index: index,
                  //       applications: data.data!.applications!,
                  //     )
                  //     : SizedBox.shrink(),
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
