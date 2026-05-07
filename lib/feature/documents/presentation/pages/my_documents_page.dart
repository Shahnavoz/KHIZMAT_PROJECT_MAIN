import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/deeplink/user_profile.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_application_provider.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_documents_provider.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_application_detail_page.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_document_detail_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/presentation/pages/steps_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/generated/l10n.dart';

class MyDocumentsPage extends ConsumerStatefulWidget {
  int selectedIndex;
  List<UpdatedDateDocument> document;
  MyDocumentsPage({
    super.key,
    required this.selectedIndex,
    required this.document,
  });

  @override
  ConsumerState<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends ConsumerState<MyDocumentsPage> {
  final TextEditingController controller = TextEditingController();
  String searchQuery = '';
  // int selectedIndex = 0;
  int statusSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        searchQuery = controller.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final asyncDocs = ref.watch(myDocumentsProvider);
    final asyncApplications = ref.watch(applicationProvider);
    final currentLocale = ref.watch(localeProvider);
    List<String> applicationsTabBars = [
      S.of(context).all,
      S.of(context).seenSuccessfully,
      S.of(context).naRasmotrenii,
      S.of(context).inFillingProcess,
      S.of(context).InPaymentProcess,
      S.of(context).rejected,
      S.of(context).reviewPeriodExpired,
      S.of(context).applicationWasWithdrawn,
    ];
    List<String> docsTabBars = [
      S.of(context).all,
      S.of(context).active,
      S.of(context).notAssigned,
      S.of(context).hasExpired,
    ];
    // List<String> tabBars = ["Все", "Активный", "Не подписанный"];
    List<Map<String, dynamic>> info = [
      {"count": "5", "text": "Сертификатов"},
      {"count": "12", "text": "Получено услуг"},
      {"count": "1", "text": "Истекло"},
    ];
    final profileData = ref.watch(userProfileProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: profileData?.firstname ?? "",
        leadingWidget: CircleAvatar(),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.otstup20,
                  vertical: size.otstup15,
                ),
                child: Column(
                  children: [
                    MyTextFieldWithPrefix(
                      hintText: S.of(context).searchDocsAndApplications,
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                        });
                      },
                      prefixIcon: Icon(Icons.search),
                    ),
                    SizedBox(height: size.otstup18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => widget.selectedIndex = index);
                              // Refresh data on every tab press so new entries appear.
                              if (index == 0) {
                                ref.invalidate(myDocumentsProvider);
                              } else {
                                ref.invalidate(applicationProvider);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.otstup10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      widget.selectedIndex == index
                                          ? primaryGreenColor
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color:
                                        widget.selectedIndex == index
                                            ? Colors.transparent
                                            : greyTextFBorderColor,
                                  ),
                                ),
                                child: Center(
                                  child: textWithH1Style(
                                    index == 0
                                        ? S.of(context).myDocuments
                                        : S.of(context).applications,
                                    fontsize: 16,
                                    color:
                                        widget.selectedIndex == index
                                            ? Colors.white
                                            : Color(0xFFA9A9A9),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: size.otstup10),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFF7F7F7),
                    //     border: Border.all(color: greyBorderColor),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: size.otstup10,
                    //       vertical: size.otstup15,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: List.generate(
                    //         3,
                    //         (index) => ContainerInDocPage(
                    //           size: size,
                    //           index: index,
                    //           info: info,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              // SizedBox(height: size.screenHeight * 0.05),
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: greyBorderColor)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child:
                    widget.selectedIndex == 0
                        ? asyncDocs.when(
                          data: (data) {
                            final document = data.data!.registers;
                            final docdetailData = data;
                            final filteredDocuments =
                                document.where((doc) {
                                  final titleRu =
                                      doc.document?.ru?.toLowerCase() ?? '';
                                  final categoryRu =
                                      doc.category?.title?.ru?.toLowerCase() ??
                                      '';
                                  return searchQuery.isEmpty ||
                                      titleRu.contains(searchQuery) ||
                                      categoryRu.contains(searchQuery);
                                }).toList();

                            final docsNonAsigned =
                                filteredDocuments
                                    .where(
                                      (e) => e.status?.isNotAsigned == true,
                                    )
                                    .toList();

                            final docsAsigned =
                                filteredDocuments
                                    .where((e) => e.status?.isActive == true)
                                    .toList();

                            final docsExpiredDate =
                                filteredDocuments
                                    .where((e) => e.status?.isExpired == true)
                                    .toList();
                            print('/////////////////////////');

                            for (var element in docsNonAsigned) {
                              print(element.document!.ru);
                            }
                            print('/////////////////////////');

                            final docs = data.data!.registers;
                            // for (var doc in docs) {
                            //   print(
                            //     "→ ${doc.status}   → ${doc.status.runtimeType}   → ${doc.document?.ru}",
                            //   );
                            // }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                                vertical: size.otstup15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    S.of(context).myDocuments,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: size.otstup18),
                                  Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: greyTextFBorderColor,
                                      // ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        // horizontal: size.otstup10,
                                        vertical: size.otstup5,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: List.generate(docsTabBars.length, (
                                            index,
                                          ) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    index != 0
                                                        ? size.otstup10
                                                        : 0,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    statusSelectedIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          statusSelectedIndex ==
                                                                  index
                                                              ? greyBorderColor
                                                              : greyTextFBorderColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    color:
                                                        statusSelectedIndex ==
                                                                index
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical:
                                                              size.otstup10,
                                                          horizontal:
                                                              size.otstup15,
                                                        ),
                                                    child: textWithH1Style(
                                                      docsTabBars[index],
                                                      fontsize: 16,
                                                      color:
                                                          statusSelectedIndex ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.otstup15),

                                  filteredDocuments.isEmpty
                                      ? Center(child: Text("Нет документов"))
                                      : statusSelectedIndex == 0
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category =
                                              filteredDocuments[index].category;
                                          final documents =
                                              filteredDocuments[index].document;
                                          final id = docs[index].id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyDocumentDetailPage(
                                                            docModel:
                                                                docdetailData,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    documents!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textWithH2BlackStyle(
                                                            S
                                                                .of(context)
                                                                .filtereddocumentsindexregistrationdate(
                                                                  filteredDocuments[index]
                                                                          .registrationDate ??
                                                                      '',
                                                                ),

                                                            color:
                                                                greyBorderColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: ${document[index].registrationDate.name }",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          //   fontW:
                                                          //       FontWeight.w500,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  document[index]
                                                                          .status!
                                                                          .isActive
                                                                      ? primaryButtonColor
                                                                      : Color(
                                                                        0xFFF7EAEA,
                                                                      ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup15,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: SizedBox(
                                                                width:
                                                                    size.screenWidth *
                                                                    0.29,
                                                                child: textWithH1Style(
                                                                  filteredDocuments[index]
                                                                      .status!
                                                                      .title!
                                                                      .getText(
                                                                        currentLocale,
                                                                      ),
                                                                  fontsize: 13,
                                                                  color:
                                                                      filteredDocuments[index]
                                                                              .status!
                                                                              .isActive
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: filteredDocuments.length,
                                      )
                                      : statusSelectedIndex == 1
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category1 =
                                              docsAsigned[index].category;
                                          final document1 =
                                              docsAsigned[index].document;
                                          final id = docsAsigned[index].id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyDocumentDetailPage(
                                                            docModel:
                                                                docdetailData,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category1!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    document1!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category1
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0XffF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textWithH2BlackStyle(
                                                            S
                                                                .of(context)
                                                                .filtereddocumentsindexregistrationdate(
                                                                  filteredDocuments[index]
                                                                          .registrationDate ??
                                                                      '',
                                                                ),

                                                            color:
                                                                greyBorderColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  primaryButtonColor,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                docsAsigned[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: docsAsigned.length,
                                      )
                                      : statusSelectedIndex == 2
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              docsNonAsigned[index].category;
                                          final document2 =
                                              docsNonAsigned[index].document;
                                          final id = docsNonAsigned[index].id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyDocumentDetailPage(
                                                            docModel:
                                                                docdetailData,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textWithH2BlackStyle(
                                                            S
                                                                .of(context)
                                                                .filtereddocumentsindexregistrationdate(
                                                                  filteredDocuments[index]
                                                                          .registrationDate ??
                                                                      '',
                                                                ),

                                                            color:
                                                                greyBorderColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Color(
                                                                    0xFFF7EAEA,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                docsNonAsigned[index]
                                                                    .status!
                                                                    .title!
                                                                    .ru!,
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: docsNonAsigned.length,
                                      )
                                      : ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index1) {
                                          final category2 =
                                              docsExpiredDate[index1].category;
                                          final document2 =
                                              docsExpiredDate[index1].document;
                                          final id = docsExpiredDate[index1].id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyDocumentDetailPage(
                                                            docModel:
                                                                docdetailData,
                                                            index: index1,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    document2!
                                                                        .ru!,
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .ru!,
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textWithH2BlackStyle(
                                                            S
                                                                .of(context)
                                                                .filtereddocumentsindexregistrationdate(
                                                                  filteredDocuments[index1]
                                                                          .registrationDate ??
                                                                      '',
                                                                ),

                                                            color:
                                                                greyBorderColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Color(
                                                                    0xFFF7EAEA,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup15,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: SizedBox(
                                                                width:
                                                                    size.screenWidth *
                                                                    0.29,
                                                                child: textWithH1Style(
                                                                  maxLines: 1,
                                                                  docsExpiredDate[index1]
                                                                      .status!
                                                                      .title!
                                                                      .getText(
                                                                        currentLocale,
                                                                      ),
                                                                  fontsize: 13,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: docsExpiredDate.length,
                                      ),
                                ],
                              ),
                            );
                          },
                          error:
                              (error, st) => Center(
                                child: Text('Error: ${error} St: ${st}'),
                              ),
                          loading:
                              () => Center(child: CircularProgressIndicator()),
                        )
                        : asyncApplications.when(
                          data: (data) {
                            final applications = data.data!.applicationList;

                            final filteredApplications =
                                applications.where((app) {
                                  final titleRu =
                                      app.document?.ru?.toLowerCase() ?? '';
                                  final categoryRu =
                                      app.category?.title?.ru?.toLowerCase() ??
                                      '';
                                  return searchQuery.isEmpty ||
                                      titleRu.contains(searchQuery) ||
                                      categoryRu.contains(searchQuery);
                                }).toList();
                            final applicationsSuccessfullyCompleted =
                                filteredApplications
                                    .where((e) => e.status!.isCompleted == true)
                                    .toList();

                            final applicationsInFillingProcces =
                                filteredApplications
                                    .where((e) => e.status!.isInProcess)
                                    .toList();

                            final applicationsNaRasmotrenii =
                                filteredApplications
                                    .where((e) => e.status!.isUnderReview)
                                    .toList();

                            final applicationsInPaymentProcess =
                                filteredApplications
                                    .where((e) => e.status!.isInPaymentProcess)
                                    .toList();
                            final applicationsOtkazanoStatus =
                                filteredApplications
                                    .where((e) => e.status!.isDenied)
                                    .toList();
                            final applicationsSrokRassIstyok =
                                filteredApplications
                                    .where((e) => e.status!.isExpired)
                                    .toList();
                            final applicationsOtozvano =
                                filteredApplications
                                    .where((e) => e.status!.isCancelled)
                                    .toList();
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                                vertical: size.otstup15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    S.of(context).myApplications,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: size.otstup18),
                                  Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: greyTextFBorderColor,
                                      // ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        // horizontal: size.otstup10,
                                        vertical: size.otstup5,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                            applicationsTabBars.length,
                                            (index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      index != 0
                                                          ? size.otstup10
                                                          : 0,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      statusSelectedIndex =
                                                          index;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            statusSelectedIndex ==
                                                                    index
                                                                ? greyBorderColor
                                                                : greyTextFBorderColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color:
                                                          statusSelectedIndex ==
                                                                  index
                                                              ? Colors.black
                                                              : Colors
                                                                  .transparent,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical:
                                                                size.otstup10,
                                                            horizontal:
                                                                size.otstup15,
                                                          ),
                                                      child: textWithH1Style(
                                                        applicationsTabBars[index],
                                                        fontsize: 16,
                                                        color:
                                                            statusSelectedIndex ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: size.otstup15),

                                  statusSelectedIndex == 0
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category =
                                              filteredApplications[index]
                                                  .category;
                                          print(category!.title!.ru);
                                          final documents =
                                              filteredApplications[index]
                                                  .document;
                                          final id =
                                              filteredApplications[index].id!;
                                          print(documents!.ru);
                                          return GestureDetector(
                                            onTap: () {
                                              final app =
                                                  filteredApplications[index];
                                              if (app.status!.isInProcess) {
                                                // React: IN_PROCESS → resume the stepper
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => StepsPage(
                                                          docId: 0,
                                                          index: index,
                                                          resumeApplicationId:
                                                              app.id ?? 0,
                                                        ),
                                                  ),
                                                );
                                              } else {
                                                // All other statuses → open detail page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            MyApplicationInReviewDetailPage(
                                                              id: id,
                                                              currentLocale:
                                                                  currentLocale,
                                                            ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    documents
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    maxline: 2,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: ${document[index].registrationDate.name }",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          //   fontW:
                                                          //       FontWeight.w500,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  applications[index]
                                                                          .status!
                                                                          .isUnderReview
                                                                      ? Colors
                                                                          .blue[100]
                                                                      : applications[index]
                                                                          .status!
                                                                          .isCompleted
                                                                      ? Colors
                                                                          .green[100]
                                                                      : applications[index]
                                                                          .status!
                                                                          .isInProcess
                                                                      ? Colors
                                                                          .orange[100]
                                                                      : Colors
                                                                          .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                "${filteredApplications[index].status!.title!.getText(currentLocale)} ${filteredApplications[index].status!.isInProcess == true ? ": Шаг ${filteredApplications[index].step!.position} из ${filteredApplications[index].step!.count}" : ""} ",
                                                                fontsize: 13,
                                                                color:
                                                                    filteredApplications[index]
                                                                            .status!
                                                                            .isUnderReview
                                                                        ? Colors
                                                                            .blue
                                                                        : applications[index]
                                                                            .status!
                                                                            .isCompleted
                                                                        ? Colors
                                                                            .green
                                                                        : applications[index]
                                                                            .status!
                                                                            .isInProcess
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: filteredApplications.length,
                                      )
                                      : statusSelectedIndex == 1
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category1 =
                                              applicationsSuccessfullyCompleted[index]
                                                  .category;
                                          final document1 =
                                              applicationsSuccessfullyCompleted[index]
                                                  .document;
                                          final id =
                                              applicationsSuccessfullyCompleted[index]
                                                  .id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category1!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document1!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    category1
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0XffF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          //   fontW:
                                                          //       FontWeight.w300,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .green[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsSuccessfullyCompleted[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsSuccessfullyCompleted
                                                .length,
                                      )
                                      : statusSelectedIndex == 2
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsNaRasmotrenii[index]
                                                  .category;
                                          final document2 =
                                              applicationsNaRasmotrenii[index]
                                                  .document;
                                          final id =
                                              applicationsNaRasmotrenii[index]
                                                  .id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .blue[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsNaRasmotrenii[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsNaRasmotrenii.length,
                                      )
                                      : statusSelectedIndex == 3
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsInFillingProcces[index]
                                                  .category;
                                          final document2 =
                                              applicationsInFillingProcces[index]
                                                  .document;

                                          print("Index ${index}");

                                          // React: statusKey === IN_PROCESS && cabinet_type === FRONT_OFFICE
                                          //   → history.push(`/application/${id}`)
                                          //   → useProcess({ resumeOnload: true, applicationId })
                                          return GestureDetector(
                                            onTap: () {
                                              final appId =
                                                  applicationsInFillingProcces[index]
                                                      .id ??
                                                  0;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => StepsPage(
                                                        docId:
                                                            0, // not used when resuming
                                                        index: index,
                                                        resumeApplicationId:
                                                            appId,
                                                      ),
                                                ),
                                              );
                                            },

                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                "${applicationsInFillingProcces[index].status!.title!.getText(currentLocale)} ${applicationsInFillingProcces[index].status!.isInProcess == true ? S.of(context).inFillingProcessStep(applicationsInFillingProcces[index].step!.position ?? 0, applicationsInFillingProcces[index].step!.count ?? 0) : ""} ",
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsInFillingProcces.length,
                                      )
                                      : statusSelectedIndex == 4
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsInPaymentProcess[index]
                                                  .category;
                                          final document2 =
                                              applicationsInPaymentProcess[index]
                                                  .document;
                                          final id =
                                              applicationsInPaymentProcess[index]
                                                  .id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsInPaymentProcess[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsInPaymentProcess.length,
                                      )
                                      : statusSelectedIndex == 5
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsOtkazanoStatus[index]
                                                  .category;
                                          final document2 =
                                              applicationsOtkazanoStatus[index]
                                                  .document;
                                          final id =
                                              applicationsOtkazanoStatus[index]
                                                  .id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsOtkazanoStatus[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsOtkazanoStatus.length,
                                      )
                                      : statusSelectedIndex == 6
                                      ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsSrokRassIstyok[index]
                                                  .category;
                                          final document2 =
                                              applicationsSrokRassIstyok[index]
                                                  .document;
                                          final id =
                                              applicationsSrokRassIstyok[index]
                                                  .id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsSrokRassIstyok[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount:
                                            applicationsSrokRassIstyok.length,
                                      )
                                      : ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category2 =
                                              applicationsOtozvano[index]
                                                  .category;
                                          final document2 =
                                              applicationsOtozvano[index]
                                                  .document;
                                          final id =
                                              applicationsOtozvano[index].id;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          MyApplicationInReviewDetailPage(
                                                            docModel: data,
                                                            index: index,
                                                            id: id!,
                                                            currentLocale:
                                                                currentLocale,
                                                          ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greyBorderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup15,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.imageSize100,
                                                              child:
                                                                  Image.network(
                                                                    category2!
                                                                        .iconId!,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.otstup15,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH2BlackStyle(
                                                                    document2!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontSize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    color:
                                                                        primaryGreenColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width:
                                                                      size.screenWidth *
                                                                      0.6,
                                                                  child: textWithH1Style(
                                                                    category2
                                                                        .title!
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    fontsize:
                                                                        16,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       decoration: BoxDecoration(
                                                        //         border: Border.all(
                                                        //           color:
                                                        //               greyBorderColor,
                                                        //         ),
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(
                                                        //               5,
                                                        //             ),
                                                        //       ),
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //               6.0,
                                                        //             ),
                                                        //         child: Center(
                                                        //           child: Icon(
                                                        //             Icons
                                                        //                 .arrow_forward_ios,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color:
                                                              greyBorderColor,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      color: Color(0xFFF6FFFA),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.otstup15,
                                                            vertical:
                                                                size.otstup15,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // textWithH1Style(
                                                          //   "Дата выдачи: 01.12.25",
                                                          //   fontsize: 14,
                                                          //   color:
                                                          //       greyBorderColor,
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .orange[100],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.otstup30,
                                                                vertical:
                                                                    size.otstup10,
                                                              ),
                                                              child: textWithH1Style(
                                                                applicationsOtozvano[index]
                                                                    .status!
                                                                    .title!
                                                                    .getText(
                                                                      currentLocale,
                                                                    ),
                                                                fontsize: 13,
                                                                color:
                                                                    Colors
                                                                        .orange,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                SizedBox(height: size.otstup10),
                                        itemCount: applicationsOtozvano.length,
                                      ),
                                ],
                              ),
                            );
                          },
                          error:
                              (error, st) =>
                                  Center(child: Text(error.toString())),
                          loading:
                              () => Center(child: CircularProgressIndicator()),
                        ),
              ),

              // asyncDocs.when(
              //   data: (data) {
              //     final document = data.data.registers;
              //     final docsNonAsigned =
              //         document
              //             .where(
              //               (e) => e.status.status == StatusEnum.NOT_SIGNED,
              //             )
              //             .toList();
              //     final docsAsigned =
              //         document
              //             .where((e) => e.status.status == StatusEnum.ACTIVE)
              //             .toList();
              //     print('/////////////////////////');

              //     for (var element in docsAsigned) {
              //       print(element.document.ru);
              //     }
              //     print('/////////////////////////');

              //     final docs = data.data.registers;
              //     for (var doc in docs) {
              //       print(
              //         "→ ${doc.status}   → ${doc.status.runtimeType}   → ${doc.document?.ru}",
              //       );
              //     }

              //     return Container(
              //       decoration: BoxDecoration(
              //         border: Border(top: BorderSide(color: greyBorderColor)),
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white
              //       ),
              //       child:
              //           selectedIndex == 0
              //               ? Padding(
              //                 padding: EdgeInsets.symmetric(
              //                   horizontal: size.otstup20,
              //                   vertical: size.otstup15,
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     textWithH1Style(
              //                       "Мои документы",
              //                       textAlign: TextAlign.start,
              //                     ),
              //                     SizedBox(height: size.otstup18),
              //                     Container(
              //                       decoration: BoxDecoration(
              //                         border: Border.all(
              //                           color: greyTextFBorderColor,
              //                         ),
              //                         borderRadius: BorderRadius.circular(8),
              //                       ),
              //                       child: Padding(
              //                         padding: EdgeInsets.symmetric(
              //                           horizontal: size.otstup10,
              //                           vertical: size.otstup5,
              //                         ),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: List.generate(tabBars.length, (
              //                             index,
              //                           ) {
              //                             return Padding(
              //                               padding: EdgeInsets.symmetric(
              //                                 // horizontal: size.otstup5,
              //                               ),
              //                               child: GestureDetector(
              //                                 onTap: () {
              //                                   setState(() {
              //                                     statusSelectedIndex = index;
              //                                   });
              //                                 },
              //                                 child: Container(
              //                                   decoration: BoxDecoration(
              //                                     border: Border.all(
              //                                       color:
              //                                           statusSelectedIndex ==
              //                                                   index
              //                                               ? greyBorderColor
              //                                               : greyTextFBorderColor,
              //                                     ),
              //                                     borderRadius:
              //                                         BorderRadius.circular(5),
              //                                     color:
              //                                         statusSelectedIndex ==
              //                                                 index
              //                                             ? Colors.black
              //                                             : Colors.transparent,
              //                                   ),
              //                                   child: Padding(
              //                                     padding: EdgeInsets.symmetric(
              //                                       vertical: size.otstup10,
              //                                       horizontal: size.otstup15,
              //                                     ),
              //                                     child: textWithH1Style(
              //                                       tabBars[index],
              //                                       fontsize: 16,
              //                                       color:
              //                                           statusSelectedIndex ==
              //                                                   index
              //                                               ? Colors.white
              //                                               : Colors.black,
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             );
              //                           }),
              //                         ),
              //                       ),
              //                     ),

              //                     SizedBox(height: size.otstup15),

              //                     statusSelectedIndex == 0
              //                         ? ListView.separated(
              //                           shrinkWrap: true,
              //                           physics: NeverScrollableScrollPhysics(),
              //                           itemBuilder: (context, index) {
              //                             final category =
              //                                 document[index].category;
              //                             final documents =
              //                                 document[index].document;
              //                             return Container(
              //                               decoration: BoxDecoration(
              //                                 border: Border.all(
              //                                   color: greyBorderColor,
              //                                 ),
              //                                 borderRadius:
              //                                     BorderRadius.circular(5),
              //                               ),
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: EdgeInsets.symmetric(
              //                                       horizontal: size.otstup15,
              //                                       vertical: size.otstup15,
              //                                     ),
              //                                     child: Row(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceBetween,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             SizedBox(
              //                                               width:
              //                                                   size.imageSize100,
              //                                               child:
              //                                                   Image.network(
              //                                                     category
              //                                                         .iconId,
              //                                                   ),
              //                                             ),
              //                                             SizedBox(
              //                                               width:
              //                                                   size.otstup15,
              //                                             ),
              //                                             Column(
              //                                               crossAxisAlignment:
              //                                                   CrossAxisAlignment
              //                                                       .start,
              //                                               children: [
              //                                                 textWithH1Style(
              //                                                   category
              //                                                       .title
              //                                                       .ru,
              //                                                   fontsize: 16,
              //                                                 ),
              //                                                 SizedBox(
              //                                                   width:
              //                                                       size.screenWidth *
              //                                                       0.6,
              //                                                   child: textWithH2BlackStyle(
              //                                                     documents.ru,
              //                                                     fontSize: 16,
              //                                                     textAlign:
              //                                                         TextAlign
              //                                                             .start,
              //                                                     color:
              //                                                         primaryGreenColor,
              //                                                     fontWeight:
              //                                                         FontWeight
              //                                                             .w400,
              //                                                     maxline: 2,
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                         Row(
              //                                           children: [
              //                                             Container(
              //                                               decoration: BoxDecoration(
              //                                                 border: Border.all(
              //                                                   color:
              //                                                       greyBorderColor,
              //                                                 ),
              //                                                 borderRadius:
              //                                                     BorderRadius.circular(
              //                                                       5,
              //                                                     ),
              //                                               ),
              //                                               child: Padding(
              //                                                 padding:
              //                                                     const EdgeInsets.all(
              //                                                       6.0,
              //                                                     ),
              //                                                 child: Center(
              //                                                   child: Icon(
              //                                                     Icons
              //                                                         .arrow_forward_ios,
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),

              //                                   Container(
              //                                     decoration: BoxDecoration(
              //                                       border: Border(
              //                                         top: BorderSide(
              //                                           color: greyBorderColor,
              //                                         ),
              //                                       ),
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                             5,
              //                                           ),
              //                                       color: Color(0xFFF6FFFA),
              //                                     ),
              //                                     child: Padding(
              //                                       padding:
              //                                           EdgeInsets.symmetric(
              //                                             horizontal:
              //                                                 size.otstup15,
              //                                             vertical:
              //                                                 size.otstup15,
              //                                           ),
              //                                       child: Row(
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment.end,
              //                                         children: [
              //                                           // textWithH1Style(
              //                                           //   "Дата выдачи: ${document[index].registrationDate.name }",
              //                                           //   fontsize: 14,
              //                                           //   color:
              //                                           //       greyBorderColor,
              //                                           //   fontW:
              //                                           //       FontWeight.w500,
              //                                           // ),
              //                                           Container(
              //                                             decoration: BoxDecoration(
              //                                               color:
              //                                                   document[index]
              //                                                               .status
              //                                                               .status
              //                                                               .index ==
              //                                                           0
              //                                                       ? Color(
              //                                                         0xFF53CDE5,
              //                                                       )
              //                                                       : Color(
              //                                                         0xFFF7EAEA,
              //                                                       ),
              //                                               borderRadius:
              //                                                   BorderRadius.circular(
              //                                                     5,
              //                                                   ),
              //                                             ),
              //                                             child: Padding(
              //                                               padding: EdgeInsets.symmetric(
              //                                                 horizontal:
              //                                                     size.otstup30,
              //                                                 vertical:
              //                                                     size.otstup10,
              //                                               ),
              //                                               child: textWithH1Style(
              //                                                 document[index]
              //                                                     .status
              //                                                     .title
              //                                                     .ru,
              //                                                 fontsize: 13,
              //                                                 color:
              //                                                     document[index]
              //                                                                 .status
              //                                                                 .status
              //                                                                 .index ==
              //                                                             0
              //                                                         ? Colors
              //                                                             .white
              //                                                         : Colors
              //                                                             .black,
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           },
              //                           separatorBuilder:
              //                               (context, index) =>
              //                                   SizedBox(height: size.otstup10),
              //                           itemCount: document.length,
              //                         )
              //                         : statusSelectedIndex == 1
              //                         ? ListView.separated(
              //                           shrinkWrap: true,
              //                           physics: NeverScrollableScrollPhysics(),
              //                           itemBuilder: (context, index) {
              //                             final category1 =
              //                                 docsAsigned[index].category;
              //                             final document1 =
              //                                 docsAsigned[index].document;
              //                             return Container(
              //                               decoration: BoxDecoration(
              //                                 border: Border.all(
              //                                   color: greyBorderColor,
              //                                 ),
              //                                 borderRadius:
              //                                     BorderRadius.circular(5),
              //                               ),
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: EdgeInsets.symmetric(
              //                                       horizontal: size.otstup15,
              //                                       vertical: size.otstup15,
              //                                     ),
              //                                     child: Row(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceBetween,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             SizedBox(
              //                                               width:
              //                                                   size.imageSize100,
              //                                               child:
              //                                                   Image.network(
              //                                                     category1
              //                                                         .iconId,
              //                                                   ),
              //                                             ),
              //                                             SizedBox(
              //                                               width:
              //                                                   size.otstup15,
              //                                             ),
              //                                             Column(
              //                                               crossAxisAlignment:
              //                                                   CrossAxisAlignment
              //                                                       .start,
              //                                               children: [
              //                                                 textWithH1Style(
              //                                                   category1
              //                                                       .title
              //                                                       .ru,
              //                                                   fontsize: 16,
              //                                                 ),
              //                                                 SizedBox(
              //                                                   width:
              //                                                       size.screenWidth *
              //                                                       0.6,
              //                                                   child: textWithH2BlackStyle(
              //                                                     document1.ru,
              //                                                     fontSize: 16,
              //                                                     textAlign:
              //                                                         TextAlign
              //                                                             .start,
              //                                                     color:
              //                                                         primaryGreenColor,
              //                                                     fontWeight:
              //                                                         FontWeight
              //                                                             .w400,
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                         Row(
              //                                           children: [
              //                                             Container(
              //                                               decoration: BoxDecoration(
              //                                                 border: Border.all(
              //                                                   color:
              //                                                       greyBorderColor,
              //                                                 ),
              //                                                 borderRadius:
              //                                                     BorderRadius.circular(
              //                                                       5,
              //                                                     ),
              //                                               ),
              //                                               child: Padding(
              //                                                 padding:
              //                                                     const EdgeInsets.all(
              //                                                       6.0,
              //                                                     ),
              //                                                 child: Center(
              //                                                   child: Icon(
              //                                                     Icons
              //                                                         .arrow_forward_ios,
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),

              //                                   Container(
              //                                     decoration: BoxDecoration(
              //                                       border: Border(
              //                                         top: BorderSide(
              //                                           color: greyBorderColor,
              //                                         ),
              //                                       ),
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                             5,
              //                                           ),
              //                                       color: Color(0XffF6FFFA),
              //                                     ),
              //                                     child: Padding(
              //                                       padding:
              //                                           EdgeInsets.symmetric(
              //                                             horizontal:
              //                                                 size.otstup15,
              //                                             vertical:
              //                                                 size.otstup15,
              //                                           ),
              //                                       child: Row(
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment.end,
              //                                         children: [
              //                                           // textWithH1Style(
              //                                           //   "Дата выдачи: 01.12.25",
              //                                           //   fontsize: 14,
              //                                           //   color:
              //                                           //       greyBorderColor,
              //                                           //   fontW:
              //                                           //       FontWeight.w300,
              //                                           // ),
              //                                           Container(
              //                                             decoration: BoxDecoration(
              //                                               color: Color(
              //                                                 0xFF53CDE5,
              //                                               ),
              //                                               borderRadius:
              //                                                   BorderRadius.circular(
              //                                                     5,
              //                                                   ),
              //                                             ),
              //                                             child: Padding(
              //                                               padding: EdgeInsets.symmetric(
              //                                                 horizontal:
              //                                                     size.otstup30,
              //                                                 vertical:
              //                                                     size.otstup10,
              //                                               ),
              //                                               child: textWithH1Style(
              //                                                 docsAsigned[index]
              //                                                     .status
              //                                                     .title
              //                                                     .ru,
              //                                                 fontsize: 13,
              //                                                 color:
              //                                                     Colors.white,
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           },
              //                           separatorBuilder:
              //                               (context, index) =>
              //                                   SizedBox(height: size.otstup10),
              //                           itemCount: docsAsigned.length,
              //                         )
              //                         : ListView.separated(
              //                           shrinkWrap: true,
              //                           physics: NeverScrollableScrollPhysics(),
              //                           itemBuilder: (context, index) {
              //                             final category2 =
              //                                 docsNonAsigned[index].category;
              //                             final document2 =
              //                                 docsNonAsigned[index].document;
              //                             return Container(
              //                               decoration: BoxDecoration(
              //                                 border: Border.all(
              //                                   color: greyBorderColor,
              //                                 ),
              //                                 borderRadius:
              //                                     BorderRadius.circular(5),
              //                               ),
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: EdgeInsets.symmetric(
              //                                       horizontal: size.otstup15,
              //                                       vertical: size.otstup15,
              //                                     ),
              //                                     child: Row(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceBetween,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             SizedBox(
              //                                               width:
              //                                                   size.imageSize100,
              //                                               child:
              //                                                   Image.network(
              //                                                     category2
              //                                                         .iconId,
              //                                                   ),
              //                                             ),
              //                                             SizedBox(
              //                                               width:
              //                                                   size.otstup15,
              //                                             ),
              //                                             Column(
              //                                               crossAxisAlignment:
              //                                                   CrossAxisAlignment
              //                                                       .start,
              //                                               children: [
              //                                                 textWithH1Style(
              //                                                   category2
              //                                                       .title
              //                                                       .ru,
              //                                                   fontsize: 16,
              //                                                 ),
              //                                                 SizedBox(
              //                                                   width:
              //                                                       size.screenWidth *
              //                                                       0.6,
              //                                                   child: textWithH2BlackStyle(
              //                                                     document2.ru,
              //                                                     fontSize: 16,
              //                                                     textAlign:
              //                                                         TextAlign
              //                                                             .start,
              //                                                     color:
              //                                                         primaryGreenColor,
              //                                                     fontWeight:
              //                                                         FontWeight
              //                                                             .w400,
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                         Row(
              //                                           children: [
              //                                             Container(
              //                                               decoration: BoxDecoration(
              //                                                 border: Border.all(
              //                                                   color:
              //                                                       greyBorderColor,
              //                                                 ),
              //                                                 borderRadius:
              //                                                     BorderRadius.circular(
              //                                                       5,
              //                                                     ),
              //                                               ),
              //                                               child: Padding(
              //                                                 padding:
              //                                                     const EdgeInsets.all(
              //                                                       6.0,
              //                                                     ),
              //                                                 child: Center(
              //                                                   child: Icon(
              //                                                     Icons
              //                                                         .arrow_forward_ios,
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),

              //                                   Container(
              //                                     decoration: BoxDecoration(
              //                                       border: Border(
              //                                         top: BorderSide(
              //                                           color: greyBorderColor,
              //                                         ),
              //                                       ),
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                             5,
              //                                           ),
              //                                       color: Color(0xFFF6FFFA),
              //                                     ),
              //                                     child: Padding(
              //                                       padding:
              //                                           EdgeInsets.symmetric(
              //                                             horizontal:
              //                                                 size.otstup15,
              //                                             vertical:
              //                                                 size.otstup15,
              //                                           ),
              //                                       child: Row(
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment.end,
              //                                         children: [
              //                                           // textWithH1Style(
              //                                           //   "Дата выдачи: 01.12.25",
              //                                           //   fontsize: 14,
              //                                           //   color:
              //                                           //       greyBorderColor,
              //                                           // ),
              //                                           Container(
              //                                             decoration: BoxDecoration(
              //                                               color: Color(
              //                                                 0xFFF7EAEA,
              //                                               ),
              //                                               borderRadius:
              //                                                   BorderRadius.circular(
              //                                                     5,
              //                                                   ),
              //                                             ),
              //                                             child: Padding(
              //                                               padding: EdgeInsets.symmetric(
              //                                                 horizontal:
              //                                                     size.otstup30,
              //                                                 vertical:
              //                                                     size.otstup10,
              //                                               ),
              //                                               child: textWithH1Style(
              //                                                 docsNonAsigned[index]
              //                                                     .status
              //                                                     .title
              //                                                     .ru,
              //                                                 fontsize: 13,
              //                                                 color:
              //                                                     Colors.black,
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           },
              //                           separatorBuilder:
              //                               (context, index) =>
              //                                   SizedBox(height: size.otstup10),
              //                           itemCount: docsNonAsigned.length,
              //                         ),
              //                   ],
              //                 ),
              //               )
              //               : Column(),
              //     );
              //   },
              //   error: (error, st) => Center(child: Text("error: ${error} StackTr:$st")),
              //   loading: () => Center(child: CircularProgressIndicator()),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerInDocPage extends StatelessWidget {
  const ContainerInDocPage({
    super.key,
    required this.size,
    required this.index,
    required this.info,
  });

  final AdaptiveSizes size;
  final int index;
  final List<Map<String, dynamic>> info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.screenWidth * 0.28,
      decoration: BoxDecoration(
        border: Border.all(color: greyBorderColor),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.otstup5),
                  child: Text(
                    info[index]['count'].toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: size.screenWidth * 0.273,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: greyBorderColor)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info[index]['text'],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
