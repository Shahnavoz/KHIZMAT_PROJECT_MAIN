import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/detail_info_row_widget.dart';
import 'package:khizmat_new/generated/l10n.dart';

class ExpansionTileForDocumentsPage extends StatefulWidget {
  const ExpansionTileForDocumentsPage({
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
  final MyDocumentDetailInfoModel? docModel;
  final int index;

  @override
  State<ExpansionTileForDocumentsPage> createState() =>
      _ExpansionTileForDocumentsPageState();
}

class _ExpansionTileForDocumentsPageState
    extends State<ExpansionTileForDocumentsPage> {
  @override
  Widget build(BuildContext context) {
    final info = widget.docModel!.data;
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
                S.of(context).status,
                info!.status!.title!.getText(widget.currentLocale),
              ),
              buildCustomRow(
                S.of(context).licenseeName,
                info.name ?? "", //field?
                fontsize: 15,
              ),
              buildCustomRow(
                S.of(context).address, //field?
                info.address ?? '',
                fontsize: 15,
              ),
              buildCustomRow(S.of(context).licenseeTin, info.tin!, fontsize: 15),
              buildCustomRow(S.of(context).docNumber, info.number!, fontsize: 15),
              buildCustomRow(
                S.of(context).numberInReestr,

                info.registerNumber!,
                fontsize: 15,
              ),
              buildCustomRow(
                S.of(context).registrationDate,

                info.registrationDate.toString(),
                fontsize: 15,
              ),
              buildCustomRow(
                S.of(context).validUntill,

                info.registrationDate.toString(),
                fontsize: 15,
              ),
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
