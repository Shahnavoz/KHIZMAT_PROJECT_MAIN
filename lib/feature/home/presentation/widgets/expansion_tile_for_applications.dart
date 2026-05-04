import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';

class ExpansionTileForApplications extends StatefulWidget {
  const ExpansionTileForApplications({
    super.key,
    required this.size,
    required this.title,
    required this.currentLocale,
    required this.index,
    required this.applications,
  });

  final AdaptiveSizes size;
  final String title;
  final Locale currentLocale;
  final int index;
  final List<Application> applications;

  @override
  State<ExpansionTileForApplications> createState() =>
      _ExpansionTileForApplicationsState();
}

class _ExpansionTileForApplicationsState
    extends State<ExpansionTileForApplications> {
  @override
  Widget build(BuildContext context) {
    // final info = widget.docModel!.data;
    final size = AdaptiveSizes(context);
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
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.applications.length,
                    itemBuilder: (context, index) {
                      final document = widget.applications[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: size.otstup10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.screenWidth * 0.86,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryGreenColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textWithH2BlackStyle(
                                              "Тип заявки",
                                              fontWeight: FontWeight.normal,
                                            ),
                                            textWithH1Style(
                                              document.applicationType!.title!
                                                  .getText(
                                                    widget.currentLocale,
                                                  ),
                                              fontsize: 15,
                                            ),
                                            textWithH2BlackStyle(
                                              "Номер заявки",
                                              fontWeight: FontWeight.normal,
                                            ),
                                            textWithH1Style(
                                              "№ ${document.applicantTin}",
                                              fontsize: 16,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: primaryGreenColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: textWithH1Style(
                                              document.status!.title!.getText(
                                                widget.currentLocale,
                                              ),
                                              fontsize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
