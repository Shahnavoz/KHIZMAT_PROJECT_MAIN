import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/detail_info_row_widget.dart';

class ExpansionTileForElectronalSignaturesPage extends StatefulWidget {
  const ExpansionTileForElectronalSignaturesPage({
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
  State<ExpansionTileForElectronalSignaturesPage> createState() =>
      _ExpansionTileForElectronalSignaturesPageState();
}

class _ExpansionTileForElectronalSignaturesPageState
    extends State<ExpansionTileForElectronalSignaturesPage> {
  @override
  Widget build(BuildContext context) {
    final info = widget.docModel!.data;
    ;
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
              info!.pkiSignatures != null
                  ? Column(
                    children: [
                      buildCustomRow("Имя", info.name!),
                      buildCustomRow("Фамилия", "", fontsize: 15),
                      buildCustomRow(
                        "Серийный номер сертификата",
                        info.pkiSignatures!.serialNumber!,
                        fontsize: 15,
                      ),
                      buildCustomRow(
                        "Подпись",
                        info.pkiSignatures!.ru!,
                        fontsize: 15,
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
