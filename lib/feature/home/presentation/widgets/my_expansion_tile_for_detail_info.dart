import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/methods/common_methods.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/detail_info_row_widget.dart';
import 'package:khizmat_new/generated/l10n.dart';

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
                S.of(context).applicants,
                info.applicantType.getText(widget.currentLocale),
              ),
              buildCustomRow(
                S.of(context).feeState,
                info.usageFee == false ? S.of(context).dontExist : "", //field?
                fontsize: 15,
              ),
              buildCustomRow(
                S.of(context).monthlyFee,
                S.of(context).dosntExist, //field?
                fontsize: 15,
              ),
              buildCustomRow(
                S.of(context).regulatingDocument,

                '${info.documentNumber ?? ""}(${info.documentDate.day}.${info.documentDate.month.toString().padLeft(2, "0")}.${info.documentDate.year})',
                fontsize: 15,
              ),
              GestureDetector(
                onTap: () {
                  openUrl(info.documentLink.toString());
                },
                child: buildCustomRow(
                  S.of(context).linkToDocument,
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