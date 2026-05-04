import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_applications_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/application_detail_info_provider.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/test_widget.dart';

import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';

class MyApplicationInReviewDetailPage extends ConsumerStatefulWidget {
  final int id;
  final Locale currentLocale;
  // Legacy params — kept for backward compat but no longer required
  final MyApplicationsModel? docModel;
  final int? index;
  const MyApplicationInReviewDetailPage({
    super.key,
    required this.id,
    required this.currentLocale,
    this.docModel,
    this.index,
  });

  @override
  ConsumerState<MyApplicationInReviewDetailPage> createState() =>
      _MyDocumentDetailPageState();
}

class _MyDocumentDetailPageState
    extends ConsumerState<MyApplicationInReviewDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
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
          // Category title comes from the detail response — no list index needed.
          // React equivalent: ApplicationModule.Components.View fetches by id directly.
          final categoryTitle = detailInfo.category.title.getText(currentLocale);
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
                    categoryTitle,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: size.otstup20),
                  Column(
                    children: [
                      Container(
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
                              SizedBox(width: size.otstup15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithH1Style(
                                    "Номер заявки",
                                    fontW: FontWeight.normal,
                                    fontsize: 15,
                                  ),
                                  textWithH1Style(
                                    detailInfo.id.toString(),
                                    fontsize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.otstup15),
                      Container(
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
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: size.otstup15),
                      Container(
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
                                    "Дата заявки",
                                    fontsize: 15,
                                    fontW: FontWeight.normal,
                                  ),
                                  textWithH1Style(
                                    "${detailInfo.registrationDate}",
                                    fontsize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.otstup25),
                  SizedBox(height: size.otstup15),

                  ApplicationView(steps: steps, applicationId: appId,)
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
