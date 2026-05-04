import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/documents/data/models/my_application_detail_info_model.dart';

class ExpansionTileForApplicantInfoPage extends ConsumerStatefulWidget {
  const ExpansionTileForApplicantInfoPage({
    super.key,
    required this.size,
    required this.title,
    required this.currentLocale,
    required this.docModel,
    required this.index,
    required this.data
  });

  final AdaptiveSizes size;
  final String title;
  final Locale currentLocale;
  final List<Step>? docModel;
  final int index;
  final Data data;

  @override
  ConsumerState<ExpansionTileForApplicantInfoPage> createState() =>
      _ExpansionTileForApplicantInfoPageState();
}

class _ExpansionTileForApplicantInfoPageState
    extends ConsumerState<ExpansionTileForApplicantInfoPage> {
  @override
  Widget build(BuildContext context) {
    final data=widget.data;
    final steps=widget.docModel;
    final index=widget.index;
    final currentLocale=ref.watch(localeProvider);
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
                  //RANGEERROR
                  // textCWithH2GreyStyle(
                    // steps![index]
                    //     .groups[widget.index]
                    //     .fields[widget.index]
                    //     .title!
                    //     .getText(widget.currentLocale),
                  // ),  
                ],
              ),
              // buildCustomRow(
              //   "Статус",
              //   data.status.title.getText(currentLocale )
              // ),
              // buildCustomRow(
              //   steps[index].groups[widget.index].fields[index].key!,
              //   steps[index].groups[widget.index].fields[index].value!,
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
