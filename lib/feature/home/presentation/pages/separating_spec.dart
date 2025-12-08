import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/methods/common_methods.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_requirement.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/steps_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/detail_info_row_widget.dart';

class UslugaInfoPage extends ConsumerStatefulWidget {
  final UslugaDetailInfo uslugaInfo;
  // final List<MySpecialization> specializations;
  // final List<Requirement> requirements;
  final int index;
  const UslugaInfoPage({
    super.key,
    required this.uslugaInfo,
    // required this.specializations,
    required this.index,
    // required this.requirements,
  });

  @override
  ConsumerState<UslugaInfoPage> createState() => _UslugaInfoPageState();
}

class _UslugaInfoPageState extends ConsumerState<UslugaInfoPage> {
  List<String> texts = [
    "Детальная информация",
    "Специализации",
    "Что такое eKhukumat",
  ];

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    final infoDoc = widget.uslugaInfo.data.document;
    final allInfo = widget.uslugaInfo.data;

    final asyncSpecialization = ref.watch(specializationProvider(infoDoc.id));
    // List<MySpecialization> specs = [];
    // if (widget.specializations.isNotEmpty &&
    //     widget.index < widget.specializations.length) {
    //   final item = widget.specializations[widget.index];
    //   specs = item.data.specializations ?? [];
    // }

    final List<Widget> expansionTiles = [];
    expansionTiles.add(
      MyExpansionTile(
        size: size,
        title: "Детальная информация",
        detailInfo: widget.uslugaInfo,
        currentLocale: currentLocale,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            textWithH1Style(
              "Назад",
              fontW: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 5),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: greyTextFBorderColor)),
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(10),
            left: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.otstup18,
            vertical: size.otstup20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWithH1Style("Стоимость:"),
                  textWithH1Style("${allInfo.serviceCost.toString()}c"),
                ],
              ),
              SizedBox(height: size.otstup20),
              My_Button(
                borderRadius: 50,
                width: double.infinity,
                size: size,
                backgroundColor: primaryButtonColor,
                borderColor: primaryButtonColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => StepsPage(
                            docId: widget.uslugaInfo.data.document.id,
                            index: widget.index,
                          ),
                    ),
                    // MaterialPageRoute(builder: (context) => WebviewPage()),
                  );
                },
                child: textWithH1Style(
                  "Получить услугу",
                  color: Colors.white,
                  fontsize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      body: asyncSpecialization.when(
        data: (data) {
          final specializations = data.uslugaSpecialization[infoDoc.id] ?? [];

          // if (specializations == null || specializations.isEmpty) {
          //   return const SizedBox.shrink();
          // }
          if (specializations.isNotEmpty) {
            final selectedSpec = specializations.first;
            final asyncRequirements = ref.watch(
              requirementsProvider((infoDoc.id, selectedSpec.id)),
            );

            return asyncRequirements.when(
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Ошибка'),
              data: (requirements) {
                if (specializations.isNotEmpty) {
                  Padding(
                    padding: EdgeInsets.only(top: size.otstup10),
                    child: SpecializationTile(
                      size: size,
                      title: "Специализации",
                      specializations: specializations,
                      currentLocale: currentLocale,
                    ),
                  );
                }

                if (requirements.isNotEmpty) {
                  Padding(
                    padding: EdgeInsets.only(top: size.otstup10),
                    child: RequirementTile(
                      size: size,
                      title: 'Требования',
                      requirements: requirements,
                      currentLocale: currentLocale,
                    ),
                  );
                }
                return Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/WHITE MAINcut.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.otstup20,
                                  vertical: size.otstup10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWithH1Style(
                                      infoDoc.title.getText(currentLocale),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: size.otstup35),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: greyTextFBorderColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.otstup20,
                                          vertical: size.otstup20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xFF90C0BD),
                                                      width: 2,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          6.0,
                                                        ),
                                                    child: Image.asset(
                                                      "assets/icons/image 15.png",
                                                      cacheWidth:
                                                          (size.screenWidth *
                                                                  0.1)
                                                              .toInt(),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.otstup15,
                                                          vertical:
                                                              size.otstup10,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        textWithH1Style(
                                                          "Срок оказания услуги: ",
                                                          fontsize: 15,
                                                        ),
                                                        textWithH1Style(
                                                          "${allInfo.reviewTime} дней",
                                                          fontsize: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textH2GreyTitle(
                                              "Уполномоченный орган",
                                            ),
                                            SizedBox(height: size.otstup5),
                                            textWithH1Style(
                                              allInfo.organization.getText(
                                                currentLocale,
                                              ),
                                              fontsize: 15,
                                              textAlign: TextAlign.start,
                                              fontW: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.otstup15,
                                  vertical: size.otstup15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyTypeContainer(
                                          size: size,
                                          typeName: infoDoc.typeTitle.getText(
                                            currentLocale,
                                          ),
                                          typeText: "Тип документа",
                                        ),
                                        MyTypeContainer(
                                          size: size,
                                          typeText: "Срок действия",
                                          typeName:
                                              "${allInfo.expiryDate.toString()} (год)",
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    Column(children: expansionTiles),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
      // asyncSpecialization.when(
      //   data: (data) {
      //     final specializations = data.uslugaSpecialization[infoDoc.id];

      //     if (specializations!.isNotEmpty) {
      //       expansionTiles.add(
      //         Padding(
      //           padding: EdgeInsets.only(top: size.otstup10),
      //           child: SpecializationTile(
      //             size: size,
      //             title: "Специализации",
      //             specializations: specializations,
      //             currentLocale: currentLocale,
      //           ),
      //         ),
      //       );
      //     }

      //     final selectedSpec = specializations.first;

      //     final allRequirements = ref.read(
      //       requirementsProvider((infoDoc.id, selectedSpec.id)),
      //     );

      //     if (allRequirements.isNotEmpty) {
      //       expansionTiles.add(
      //         Padding(
      //           padding: EdgeInsets.only(top: size.otstup10),
      //           child: RequirementTile(
      //             size: size,
      //             title: 'Требования',
      //             requirements: widget.requirements,
      //             currentLocale: currentLocale,
      //           ),
      //         ),
      //       );
      //     }

      //   },
      //   error: (error, st) => Center(child: Text("${error}")),
      //   loading: () => Center(child: CircularProgressIndicator()),
      // ),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile({
    super.key,
    required this.size,
    required this.title,
    required this.detailInfo,
    required this.currentLocale,
  });

  final AdaptiveSizes size;
  final String title;
  final UslugaDetailInfo detailInfo;
  final Locale currentLocale;

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final info = widget.detailInfo.data;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.size.otstup15),
      decoration: BoxDecoration(
        border: Border.all(color: greyTextFBorderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            iconColor: primaryButtonColor,
            collapsedIconColor: primaryButtonColor,
            tilePadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.only(left: 1),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            children: [
              buildCustomRow(
                "Заявители",
                info.applicantType.getText(widget.currentLocale),
              ),
              buildCustomRow(
                "Государственная пошлина",
                info.usageFee == false ? "Не имеется" : "",
                fontsize: 15,
              ),
              buildCustomRow(
                "Ежемесячный сбор",
                "Не применяется",
                fontsize: 15,
              ),
              buildCustomRow(
                "Подтверждающий документ",

                '${info.documentNumber ?? ""}(${info.documentDate.day}.${info.documentDate.month.toString().padLeft(2, "0")}.${info.documentDate.year})',
                fontsize: 15,
              ),
              GestureDetector(
                onTap: () {
                  openUrl(info.documentLink.toString());
                },
                child: buildCustomRow(
                  "Ссылка на подтверждающий документ",
                  info.documentLink.toString(),
                  fontsize: 15,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequirementTile extends ConsumerStatefulWidget {
  const RequirementTile({
    super.key,
    required this.size,
    required this.title,
    required this.requirements,
    required this.currentLocale,
  });

  final AdaptiveSizes size;
  final String title;
  final List<Requirement> requirements;
  final Locale currentLocale;

  @override
  ConsumerState<RequirementTile> createState() => _RequirementTileState();
}

class _RequirementTileState extends ConsumerState<RequirementTile> {
  int? _expandedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.size.otstup15),
      decoration: BoxDecoration(
        border: Border.all(color: greyTextFBorderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            iconColor: primaryButtonColor,
            collapsedIconColor: primaryButtonColor,
            tilePadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.only(left: 1),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.requirements.length,
                itemBuilder: (context, index) {
                  final requirement = widget.requirements[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryButtonColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: widget.size.screenWidth * 0.75,
                            child: Html(
                              data: requirement.content.getText(
                                widget.currentLocale,
                              ),
                              onLinkTap: (url, _, _) async {
                                if (url != null) {
                                  openUrl(url);
                                }
                              },
                              style: {
                                "p": Style(
                                  fontSize: FontSize(16),
                                  margin: Margins.symmetric(vertical: 2),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                "a": Style(
                                  color: Colors.blue,
                                  textDecoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                                "strong": Style(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                "em": Style(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[700],
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> openUrl(String url) async {
//   final uri = Uri.parse(url);
//   try {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } catch (e) {
//     print('Could not launch $url: $e');
//   }
// }

class SpecializationTile extends StatefulWidget {
  const SpecializationTile({
    super.key,
    required this.size,
    required this.title,
    required this.specializations,
    required this.currentLocale,
  });

  final AdaptiveSizes size;
  final String title;
  final List<MySpecialization> specializations;
  final Locale currentLocale;

  @override
  State<SpecializationTile> createState() => _SpecializationTileState();
}

class _SpecializationTileState extends State<SpecializationTile> {
  int? _expandedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.size.otstup15),
      decoration: BoxDecoration(
        border: Border.all(color: greyTextFBorderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            iconColor: primaryButtonColor,
            collapsedIconColor: primaryButtonColor,
            tilePadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.only(left: 1),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            children: [
              ...widget.specializations.asMap().entries.map((entry) {
                final index = entry.key;
                final spec = entry.value;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryButtonColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: widget.size.screenWidth * 0.7,
                          child: textWithH1Style(
                            spec.name.getText(widget.currentLocale) ?? "",
                            color: primaryButtonColor,
                            fontsize: 14,
                            maxLines: 5,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.size.otstup15),

                    textWithH1Style(
                      // "Услуга включает в себя присвоение, изменение или уточнение официального почтового адреса здания, помещения или земельного участка в соответствии с административно-территориальным делением.",
                      spec.description.getText(widget.currentLocale),
                      fontW: FontWeight.w400,
                      fontsize: 16,
                      maxLines: 10,
                      textAlign: TextAlign.start,
                      color: Color(0xFF686868),
                    ),
                    SizedBox(height: widget.size.otstup20),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTypeContainer extends StatelessWidget {
  const MyTypeContainer({
    super.key,
    required this.size,
    required this.typeText,
    required this.typeName,
  });

  final AdaptiveSizes size;
  final String typeText;
  final String typeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyTextFBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: size.otstup15,
          right: size.otstup65,
          top: size.otstup18,
          bottom: size.otstup20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWithH2BlackStyle(typeText, fontSize: 15),
            SizedBox(height: size.otstup5),
            textWithH2BlackStyle(
              typeName,
              fontSize: 16,
              color: primaryButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRow(String title, String value, {Color? color, double? fontsize}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontsize ?? 18,
              color: Colors.grey[600]!,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}



/*
return Stack(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/WHITE MAINcut.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup20,
                            vertical: size.otstup10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWithH1Style(
                                infoDoc.title.getText(currentLocale),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: size.otstup35),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: greyTextFBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.otstup20,
                                    vertical: size.otstup20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF90C0BD),
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                6.0,
                                              ),
                                              child: Image.asset(
                                                "assets/icons/image 15.png",
                                                cacheWidth:
                                                    (size.screenWidth * 0.1)
                                                        .toInt(),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.otstup15,
                                                vertical: size.otstup10,
                                              ),
                                              child: Row(
                                                children: [
                                                  textWithH1Style(
                                                    "Срок оказания услуги: ",
                                                    fontsize: 15,
                                                  ),
                                                  textWithH1Style(
                                                    "${allInfo.reviewTime} дней",
                                                    fontsize: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      textH2GreyTitle("Уполномоченный орган"),
                                      SizedBox(height: size.otstup5),
                                      textWithH1Style(
                                        allInfo.organization.getText(
                                          currentLocale,
                                        ),
                                        fontsize: 15,
                                        textAlign: TextAlign.start,
                                        fontW: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.otstup15,
                            vertical: size.otstup15,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyTypeContainer(
                                    size: size,
                                    typeName: infoDoc.typeTitle.getText(
                                      currentLocale,
                                    ),
                                    typeText: "Тип документа",
                                  ),
                                  MyTypeContainer(
                                    size: size,
                                    typeText: "Срок действия",
                                    typeName:
                                        "${allInfo.expiryDate.toString()} (год)",
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),

                              Column(children: expansionTiles),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );*/