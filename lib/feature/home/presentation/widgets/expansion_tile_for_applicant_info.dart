import 'package:flutter/material.dart' hide Step;
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_application_detail_info_page.dart';

class ExpansionTileForApplicantInfoPage extends StatefulWidget {
  const ExpansionTileForApplicantInfoPage({
    super.key,
    required this.size,
    required this.title,
    required this.currentLocale,
    required this.docModel,
    required this.index,
  });

  final AdaptiveSizes size;
  final String title;
  final Locale currentLocale;
  final List<Step>? docModel;
  final int index;

  @override
  State<ExpansionTileForApplicantInfoPage> createState() =>
      _ExpansionTileForApplicantInfoPageState();
}

class _ExpansionTileForApplicantInfoPageState
    extends State<ExpansionTileForApplicantInfoPage> {
  @override
  Widget build(BuildContext context) {
    final step = widget.docModel![widget.index];
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
              Row(
                children: [
                  textCWithH2GreyStyle(
                    step
                        .groups[widget.index]
                        .fields[widget.index]
                        .title!
                        .getText(widget.currentLocale),
                  ),
                ],
              ),
              // buildCustomRow(
              //   "Статус",
              //   info!.status!.title!.getText(widget.currentLocale),
              // ),
              // buildCustomRow(
              //   "Наименование лицензиата",
              //   info.name!, //field?
              //   fontsize: 15,
              // ),
              // buildCustomRow(
              //   "Адрес", //field?
              //   info.address ?? '',
              //   fontsize: 15,
              // ),
              // buildCustomRow("ИНН лицензиата", info.tin!, fontsize: 15),
              // buildCustomRow("Номер документа", info.number!, fontsize: 15),
              // buildCustomRow(
              //   "Номер в реестре",

              //   info.registerNumber!,
              //   fontsize: 15,
              // ),
              // buildCustomRow(
              //   "Дата выдачи",

              //   info.registrationDate.toString(),
              //   fontsize: 15,
              // ),
              // buildCustomRow(
              //   "Действует до",

              //   info.registrationDate.toString(),
              //   fontsize: 15,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     openUrl(info.documentLink.toString());
              //   },
              //   child: buildCustomRow(
              //     "Ссылка на подтверждающий документ",
              //     info.documentLink.toString(),
              //     fontsize: 15,
              //     color: Colors.blue,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
