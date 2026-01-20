import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/masks/field_masks.dart';
import 'package:khizmat_new/consts/methods/common_methods.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/providers/category_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/controllers_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/drop_down_params_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/steps_provider.dart';
import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';
import 'package:khizmat_new/feature/home/presentation/pages/Gos_organizations_page.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/_build_dropdown_skeleton.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/font_setting_container.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/info_content_dialog.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/input_text_field.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/radio_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/requirement_step.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/switch_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final currentStepProvider = StateProvider<int>((ref) => 0);
final myStep = StateProvider<StepInfo>(
  (ref) => StepInfo(
    id: 1,
    position: 1,
    title: Description(tj: "tj", ru: "ru", en: "en"),
    type: "type",
  ),
);
final selectedValueProvider = StateProvider<String>((ref) => "");
final actionIdValueProvider = StateProvider<String>((ref) => "");

class StepsPage extends ConsumerStatefulWidget {
  final int docId;
  final int index;
  const StepsPage({super.key, required this.docId, required this.index});

  @override
  ConsumerState<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends ConsumerState<StepsPage> {
  List<String> text = [
    "Сертификат",
    "Оплата",
    "Генерация",
    "Сертификат",
    "Оплата",
    "Генерация",
  ];
  final _formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  bool isActive = false;
  PlatformFile? _pickedFile;
  final _focusNode = FocusNode();
  bool _isFocused = false;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final asyncSteps = ref.watch(shagiProvider(widget.docId));
    final currentStep = ref.watch(currentStepProvider);
    final formFamilyProviderWatch = ref.watch(formProviderFamily(widget.docId));
    final formFamilyProviderRead = ref.read(formProviderFamily(widget.docId));
    final currentLocale = ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: "Назад",
        actionWidget: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: FontSettingContainer(size: size),
        ),
      ),

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     border: Border(top: BorderSide(color: greyTextFBorderColor)),
      //     borderRadius: BorderRadius.horizontal(
      //       right: Radius.circular(10),
      //       left: Radius.circular(10),
      //     ),
      //     color: Colors.white,
      //   ),
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: size.otstup18,
      //       vertical: size.otstup20,
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         My_Button(
      //           width: double.infinity,
      //           size: size,
      //           backgroundColor: Colors.white,
      //           borderColor: greyTextFBorderColor,
      //           borderRadius: 10,
      //           onPressed: () {},
      //           child: textWithH1Style(
      //             "Сохранить как черновик",
      //             fontsize: 15,
      //             // color: Colors.white,
      //           ),
      //         ),
      //         My_Button(
      //           width: double.infinity,
      //           size: size,
      //           backgroundColor: primaryButtonColor,
      //           borderColor: primaryButtonColor,
      //           borderRadius: 10,
      //           onPressed: () {
      //             _onContinuePressed(asyncSteps, currentStep);
      //           },
      //           child: textWithH1Style(
      //             "Продoлжить",
      //             fontsize: 15,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // body: Stack(
      //   children: [
      //     Container(
      //       child: Image.asset(
      //         "assets/images/WHITE MAINcut.png",
      //         fit: BoxFit.cover,
      //         width: double.infinity,
      //         height: 130,
      //       ),
      //     ),
      //     Container(
      //       decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
      //     ),

      //     Positioned(
      //       bottom: 10,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           border: Border(top: BorderSide(color: greyTextFBorderColor)),
      //           borderRadius: BorderRadius.horizontal(
      //             right: Radius.circular(10),
      //             left: Radius.circular(10),
      //           ),
      //           color: Colors.white,
      //         ),
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(
      //             horizontal: size.otstup18,
      //             vertical: size.otstup20,
      //           ),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               My_Button(
      //                 width: double.infinity,
      //                 size: size,
      //                 backgroundColor: Colors.white,
      //                 borderColor: greyTextFBorderColor,
      //                 borderRadius: 10,
      //                 onPressed: () {},
      //                 child: textWithH1Style(
      //                   "Сохранить как черновик",
      //                   fontsize: 15,
      //                   // color: Colors.white,
      //                 ),
      //               ),
      //               My_Button(
      //                 width: double.infinity,
      //                 size: size,
      //                 backgroundColor: primaryButtonColor,
      //                 borderColor: primaryButtonColor,
      //                 borderRadius: 10,
      //                 onPressed: () {
      //                   _onContinuePressed(asyncSteps, currentStep);
      //                 },
      //                 child: textWithH1Style(
      //                   "Продoлжить",
      //                   fontsize: 15,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),

      //     SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(color: Colors.transparent),
      //             child: Padding(
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: 0,
      //                 vertical: size.otstup25,
      //               ),
      //               child: asyncSteps.when(
      //                 data: (allStepsInfo) {
      //                   final applicationId = allStepsInfo.applicationId;
      //                   final stepsAndFields = allStepsInfo.stepsInfo[0].data;
      //                   final steps = stepsAndFields.steps;
      //                   final stepRequirement =
      //                       allStepsInfo.stepRequirement.data.requirements;
      //                   final sortedSteps =
      //                       steps.toList()..sort(
      //                         (a, b) => a.position!.compareTo(b.position!),
      //                       );
      //                   if (sortedSteps.isEmpty ||
      //                       currentStep < 0 ||
      //                       currentStep >= sortedSteps.length) {
      //                     return null;
      //                   }

      //                   final dropDownList = allStepsInfo.dropDownOptions;

      //                   final fieldGroups = stepsAndFields.fieldGroups;
      //                   final currentStepGroups =
      //                       fieldGroups
      //                           .where(
      //                             (fieldGroup) =>
      //                                 fieldGroup.stepId ==
      //                                 sortedSteps[currentStep].id,
      //                           )
      //                           .toList();
      //                   for (var group in fieldGroups) {
      //                     group.fields.sort(
      //                       (a, b) => a.position.compareTo(b.position),
      //                     );
      //                     if (sortedSteps.isEmpty ||
      //                         currentStep < 0 ||
      //                         currentStep >= sortedSteps.length) {
      //                       return null;
      //                     }

      //                     final currentStepGroups =
      //                         fieldGroups
      //                             .where(
      //                               (fieldGroup) =>
      //                                   fieldGroup.stepId ==
      //                                   sortedSteps[currentStep].id,
      //                             )
      //                             .toList();

      //                     final currentStepKeys = currentStepGroups.expand(
      //                       (fieldGroup) =>
      //                           fieldGroup.fields
      //                               .where(
      //                                 (field) => field.type != 'TEXT_BLOCK',
      //                               )
      //                               .map((field) => field.key)
      //                               .toList(),
      //                     );
      //                   }
      //                   return Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       Padding(
      //                         padding: EdgeInsets.symmetric(
      //                           horizontal: size.otstup20,
      //                         ),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 textWithH1Style(
      //                                   "Шаг № ${currentStep + 1}",
      //                                 ),
      //                                 textWithH1Style(" / "),
      //                                 textWithH1Style(
      //                                   (steps.length.toString()),
      //                                 ),
      //                               ],
      //                             ),
      //                             textWithH1Style(
      //                               sortedSteps[currentStep].title.getText(
      //                                 currentLocale,
      //                               ),
      //                               color: primaryButtonColor,
      //                               textAlign: TextAlign.start,
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       SizedBox(height: size.otstup30),
      //                       SingleChildScrollView(
      //                         scrollDirection: Axis.horizontal,
      //                         child: Padding(
      //                           padding: EdgeInsets.symmetric(
      //                             horizontal: size.otstup20,
      //                             // vertical: size.otstup15,
      //                           ),
      //                           child: Column(
      //                             children: [
      //                               Row(
      //                                 children: List.generate(steps.length, (
      //                                   index,
      //                                 ) {
      //                                   setState(() {
      //                                     currentIndex = index;
      //                                     isActive = !isActive;
      //                                   });
      //                                   return Padding(
      //                                     padding: EdgeInsets.only(
      //                                       left:
      //                                           index != 0 ? size.otstup15 : 0,
      //                                     ),
      //                                     child: GestureDetector(
      //                                       onTap: () {
      //                                         ref
      //                                             .read(
      //                                               currentStepProvider
      //                                                   .notifier,
      //                                             )
      //                                             .state = index;
      //                                       },
      //                                       child: Row(
      //                                         children: [
      //                                           Container(
      //                                             width: 30,
      //                                             height: 30,
      //                                             decoration: BoxDecoration(
      //                                               color:
      //                                                   currentIndex ==
      //                                                               currentStep ||
      //                                                           currentIndex <
      //                                                               currentStep
      //                                                       ? primaryButtonColor
      //                                                       : Colors.white,
      //                                               shape: BoxShape.circle,
      //                                               border: Border.all(
      //                                                 width: 2,
      //                                                 color:
      //                                                     currentIndex ==
      //                                                                 currentStep ||
      //                                                             currentIndex <
      //                                                                 currentStep
      //                                                         ? primaryButtonColor
      //                                                         : greyTextFBorderColor,
      //                                               ),
      //                                             ),
      //                                             child:
      //                                                 currentIndex < currentStep
      //                                                     ? Icon(
      //                                                       Icons.done,
      //                                                       size: 20,
      //                                                       color: Colors.white,
      //                                                     )
      //                                                     : Center(
      //                                                       child: textWithH1Style(
      //                                                         fontsize: 16,
      //                                                         color:
      //                                                             currentIndex ==
      //                                                                     currentStep
      //                                                                 ? Colors
      //                                                                     .white
      //                                                                 : Colors
      //                                                                     .black,
      //                                                         (index + 1)
      //                                                             .toString(),
      //                                                       ),
      //                                                     ),
      //                                           ),
      //                                           Container(
      //                                             width:
      //                                                 size.screenWidth * 0.25,
      //                                             height: 5,
      //                                             decoration: BoxDecoration(
      //                                               color:
      //                                                   currentIndex ==
      //                                                               currentStep ||
      //                                                           currentIndex <
      //                                                               currentStep
      //                                                       ? primaryButtonColor
      //                                                       : greyTextFBorderColor,
      //                                               borderRadius:
      //                                                   BorderRadius.only(
      //                                                     topRight:
      //                                                         Radius.circular(
      //                                                           10,
      //                                                         ),
      //                                                     bottomRight:
      //                                                         Radius.circular(
      //                                                           10,
      //                                                         ),
      //                                                   ),
      //                                             ),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   );
      //                                 }),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: size.otstup18),
      //                       Container(
      //                         decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.only(
      //                             topLeft: Radius.circular(10),
      //                             topRight: Radius.circular(10),
      //                           ),
      //                         ),
      //                         child: Padding(
      //                           padding: EdgeInsets.symmetric(
      //                             horizontal: size.otstup20,
      //                             vertical: size.otstup18,
      //                           ),
      //                           child: buildStepContent(
      //                             currentLocale: currentLocale,
      //                             size: size,
      //                             step: sortedSteps[currentStep],
      //                             groups: currentStepGroups,
      //                             formFamilyProviderRead:
      //                                 formFamilyProviderRead,
      //                             formFamilyProviderWatch:
      //                                 formFamilyProviderWatch,
      //                             docId: widget.docId,
      //                             requirements: stepRequirement,
      //                             applicationId: applicationId,
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //                 error:
      //                     (error, st) => Center(child: Text(error.toString())),
      //                 loading: () => Center(child: CircularProgressIndicator()),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      //////////////////////
      body: Stack(
        children: [
          // Фон + изображение (как было)
          Container(
            child: Image.asset(
              "assets/images/WHITE MAINcut.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
          ),

          // Скроллируемый контент
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: size.otstup25,
                    ),
                    child: asyncSteps.when(
                      data: (allStepsInfo) {
                        final applicationId = allStepsInfo.applicationId;
                        final stepsAndFields = allStepsInfo.stepsInfo[0].data;
                        final steps = stepsAndFields.steps;
                        final stepRequirement =
                            allStepsInfo.stepRequirement.data.requirements;
                        final sortedSteps =
                            steps.toList()..sort(
                              (a, b) => a.position!.compareTo(b.position!),
                            );

                        if (sortedSteps.isEmpty ||
                            currentStep < 0 ||
                            currentStep >= sortedSteps.length) {
                          return const SizedBox.shrink();
                        }

                        final dropDownList = allStepsInfo.dropDownOptions;
                        final fieldGroups = stepsAndFields.fieldGroups;

                        // Сортируем поля ОДИН РАЗ (убрал дублирующий for)
                        for (var group in fieldGroups) {
                          group.fields.sort(
                            (a, b) => a.position.compareTo(b.position),
                          );
                        }
                        final currentStepGroups =
                            fieldGroups
                                .where(
                                  (fieldGroup) =>
                                      fieldGroup.stepId ==
                                      sortedSteps[currentStep].id,
                                )
                                .toList();

                        final currentStepKeys = currentStepGroups.expand(
                          (fieldGroup) => fieldGroup.fields
                              .where((field) => field.type != 'TEXT_BLOCK')
                              .map((field) => field.key),
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Заголовок шага
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      textWithH1Style(
                                        "Шаг № ${currentStep + 1}",
                                      ),
                                      textWithH1Style(" / "),
                                      textWithH1Style(steps.length.toString()),
                                    ],
                                  ),
                                  textWithH1Style(
                                    sortedSteps[currentStep].title.getText(
                                      currentLocale,
                                    ),
                                    color: primaryButtonColor,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.otstup30),

                            // Прогресс-бар (ИСПРАВЛЕН! без Column и setState)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.otstup20,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(steps.length, (index) {
                                  final isActiveStep = index == currentStep;
                                  final isCompleted = index < currentStep;
                                  final color =
                                      isActiveStep || isCompleted
                                          ? primaryButtonColor
                                          : greyTextFBorderColor;
                                  final textColor =
                                      isActiveStep
                                          ? Colors.white
                                          : Colors.black;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: index != 0 ? size.otstup15 : 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(currentStepProvider.notifier)
                                            .state = index;
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Кружок
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  isActiveStep || isCompleted
                                                      ? primaryButtonColor
                                                      : Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 2,
                                                color: color,
                                              ),
                                            ),
                                            child:
                                                isCompleted
                                                    ? Icon(
                                                      Icons.done,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )
                                                    : Center(
                                                      child: textWithH1Style(
                                                        fontsize: 16,
                                                        color: textColor,
                                                        (index + 1).toString(),
                                                      ),
                                                    ),
                                          ),
                                          // Линия (только не для последнего)
                                          if (index < steps.length - 1)
                                            Container(
                                              width:
                                                  80, // фиксированная ширина вместо screenWidth*0.25
                                              height: 5,
                                              margin: EdgeInsets.only(left: 4),
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: size.otstup18),

                            // Контент шага
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
                                  horizontal: size.otstup20,
                                  vertical: size.otstup18,
                                ),
                                child: buildStepContent(
                                  currentLocale: currentLocale,
                                  size: size,
                                  step: sortedSteps[currentStep],
                                  groups: currentStepGroups,
                                  formFamilyProviderRead:
                                      formFamilyProviderRead,
                                  formFamilyProviderWatch:
                                      formFamilyProviderWatch,
                                  docId: widget.docId,
                                  requirements: stepRequirement,
                                  applicationId: applicationId,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                            ), // запас под фиксированные кнопки
                          ],
                        );
                      },
                      error:
                          (error, st) => Center(child: Text(error.toString())),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ФИКСИРОВАННЫЕ КНОПКИ ВНУТРИ asyncSteps ДАННЫХ (доступ ко всем переменным!)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              // ← Builder дает доступ к ref и asyncSteps
              builder: (context) {
                return asyncSteps.when(
                  data: (allStepsInfo) {
                    final stepsAndFields = allStepsInfo.stepsInfo[0].data;
                    final steps =
                        stepsAndFields.steps.toList()
                          ..sort((a, b) => a.position!.compareTo(b.position!));
                    final currentStepIdx = ref.watch(currentStepProvider);

                    final step = steps.map((s) => s.type).toList();

                    // final step = steps[currentStepIdx];

                    if (steps.isEmpty ||
                        currentStepIdx < 0 ||
                        currentStepIdx >= steps.length) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: greyTextFBorderColor),
                        ),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                          left: Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.otstup18,
                        vertical: size.otstup20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          My_Button(
                            width: double.infinity,
                            size: size,
                            backgroundColor: Colors.white,
                            borderColor: greyTextFBorderColor,
                            borderRadius: 10,
                            onPressed: () {
                              // Полный доступ к steps, currentStepIdx, allStepsInfo!
                              print(
                                "Сохранить черновик: шаг ${currentStepIdx + 1}/${steps.length}",
                              );
                              // Твоя логика сохранения: saveDraft(steps, currentStepIdx, allStepsInfo);
                            },
                            child: textWithH1Style(
                              step[currentStep] == 'PAYMENT'
                                  ? "Заполнить заново"
                                  : "Сохранить как черновик",
                              fontsize: 15,
                            ),
                          ),
                          SizedBox(height: 12),
                          My_Button(
                            width: double.infinity,
                            size: size,
                            backgroundColor: primaryButtonColor,
                            borderColor: primaryButtonColor,
                            borderRadius: 10,
                            onPressed: () {
                              step[currentStep] == 'PAYMENT'
                                  ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => GosOrganizationsPage(),
                                    ),
                                  )
                                  : Container();
                              // Доступ ко всем данным для _onContinuePressed
                              // _onContinuePressed(allStepsInfo, currentStepIdx);
                              // Или: ref.read(currentStepProvider.notifier).state = currentStepIdx + 1;
                            },
                            child: textWithH1Style(
                              step[currentStep] == 'PAYMENT'
                                  ? "Перейти к оплате"
                                  : "Продолжить",
                              fontsize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (error, st) => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],

        // body: Stack(
        //   children: [
        //     Container(
        //       child: Image.asset(
        //         "assets/images/WHITE MAINcut.png",
        //         fit: BoxFit.cover,
        //         width: double.infinity,
        //         height: 130,
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
        //     ),

        //     SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(color: Colors.transparent),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: 0,
        //                 vertical: size.otstup25,
        //               ),
        //               child: asyncSteps.when(
        //                 data: (allStepsInfo) {
        //                   final applicationId = allStepsInfo.applicationId;
        //                   final stepsAndFields = allStepsInfo.stepsInfo[0].data;
        //                   final steps = stepsAndFields.steps;

        //                   final stepRequirement =
        //                       allStepsInfo.stepRequirement.data.requirements;
        //                   final sortedSteps =
        //                       steps.toList()..sort(
        //                         (a, b) => a.position!.compareTo(b.position!),
        //                       );
        //                   if (sortedSteps.isEmpty ||
        //                       currentStep < 0 ||
        //                       currentStep >= sortedSteps.length) {
        //                     return null;
        //                   }

        //                   final dropDownList = allStepsInfo.dropDownOptions;

        //                   final fieldGroups = stepsAndFields.fieldGroups;
        //                   final currentStepGroups =
        //                       fieldGroups
        //                           .where(
        //                             (fieldGroup) =>
        //                                 fieldGroup.stepId ==
        //                                 sortedSteps[currentStep].id,
        //                           )
        //                           .toList();
        //                   for (var group in fieldGroups) {
        //                     group.fields.sort(
        //                       (a, b) => a.position.compareTo(b.position),
        //                     );
        //                     if (sortedSteps.isEmpty ||
        //                         currentStep < 0 ||
        //                         currentStep >= sortedSteps.length) {
        //                       return null;
        //                     }

        //                     final currentStepGroups =
        //                         fieldGroups
        //                             .where(
        //                               (fieldGroup) =>
        //                                   fieldGroup.stepId ==
        //                                   sortedSteps[currentStep].id,
        //                             )
        //                             .toList();

        //                     final currentStepKeys = currentStepGroups.expand(
        //                       (fieldGroup) =>
        //                           fieldGroup.fields
        //                               .where(
        //                                 (field) => field.type != 'TEXT_BLOCK',
        //                               )
        //                               .map((field) => field.key)
        //                               .toList(),
        //                     );
        //                   }
        //                   return Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       Padding(
        //                         padding: EdgeInsets.symmetric(
        //                           horizontal: size.otstup20,
        //                         ),
        //                         child: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Row(
        //                               children: [
        //                                 textWithH1Style(
        //                                   "Шаг № ${currentStep + 1}",
        //                                 ),
        //                                 textWithH1Style(" / "),
        //                                 textWithH1Style(
        //                                   (steps.length.toString()),
        //                                 ),
        //                               ],
        //                             ),
        //                             textWithH1Style(
        //                               sortedSteps[currentStep].title.getText(
        //                                 currentLocale,
        //                               ),
        //                               color: primaryButtonColor,
        //                               textAlign: TextAlign.start,
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(height: size.otstup30),
        //                       SingleChildScrollView(
        //                         scrollDirection: Axis.horizontal,
        //                         child: Padding(
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: size.otstup20,
        //                             // vertical: size.otstup15,
        //                           ),
        //                           child: Column(
        //                             children: [
        //                               Row(
        //                                 children: List.generate(steps.length, (
        //                                   index,
        //                                 ) {
        //                                   setState(() {
        //                                     currentIndex = index;
        //                                     isActive = !isActive;
        //                                   });
        //                                   return Padding(
        //                                     padding: EdgeInsets.only(
        //                                       left:
        //                                           index != 0 ? size.otstup15 : 0,
        //                                     ),
        //                                     child: GestureDetector(
        //                                       onTap: () {
        //                                         ref
        //                                             .read(
        //                                               currentStepProvider
        //                                                   .notifier,
        //                                             )
        //                                             .state = index;
        //                                       },
        //                                       child: Row(
        //                                         children: [
        //                                           Container(
        //                                             width: 30,
        //                                             height: 30,
        //                                             decoration: BoxDecoration(
        //                                               color:
        //                                                   currentIndex ==
        //                                                               currentStep ||
        //                                                           currentIndex <
        //                                                               currentStep
        //                                                       ? primaryButtonColor
        //                                                       : Colors.white,
        //                                               shape: BoxShape.circle,
        //                                               border: Border.all(
        //                                                 width: 2,
        //                                                 color:
        //                                                     currentIndex ==
        //                                                                 currentStep ||
        //                                                             currentIndex <
        //                                                                 currentStep
        //                                                         ? primaryButtonColor
        //                                                         : greyTextFBorderColor,
        //                                               ),
        //                                             ),
        //                                             child:
        //                                                 currentIndex < currentStep
        //                                                     ? Icon(
        //                                                       Icons.done,
        //                                                       size: 20,
        //                                                       color: Colors.white,
        //                                                     )
        //                                                     : Center(
        //                                                       child: textWithH1Style(
        //                                                         fontsize: 16,
        //                                                         color:
        //                                                             currentIndex ==
        //                                                                     currentStep
        //                                                                 ? Colors
        //                                                                     .white
        //                                                                 : Colors
        //                                                                     .black,
        //                                                         (index + 1)
        //                                                             .toString(),
        //                                                       ),
        //                                                     ),
        //                                           ),
        //                                           Container(
        //                                             width:
        //                                                 size.screenWidth * 0.25,
        //                                             height: 5,
        //                                             decoration: BoxDecoration(
        //                                               color:
        //                                                   currentIndex ==
        //                                                               currentStep ||
        //                                                           currentIndex <
        //                                                               currentStep
        //                                                       ? primaryButtonColor
        //                                                       : greyTextFBorderColor,
        //                                               borderRadius:
        //                                                   BorderRadius.only(
        //                                                     topRight:
        //                                                         Radius.circular(
        //                                                           10,
        //                                                         ),
        //                                                     bottomRight:
        //                                                         Radius.circular(
        //                                                           10,
        //                                                         ),
        //                                                   ),
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   );
        //                                 }),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(height: size.otstup18),
        //                       Container(
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.only(
        //                             topLeft: Radius.circular(10),
        //                             topRight: Radius.circular(10),
        //                           ),
        //                         ),
        //                         child: Padding(
        //                           padding: EdgeInsets.symmetric(
        //                             horizontal: size.otstup20,
        //                             vertical: size.otstup18,
        //                           ),
        //                           child: buildStepContent(
        //                             currentLocale: currentLocale,
        //                             size: size,
        //                             step: sortedSteps[currentStep],
        //                             groups: currentStepGroups,
        //                             formFamilyProviderRead:
        //                                 formFamilyProviderRead,
        //                             formFamilyProviderWatch:
        //                                 formFamilyProviderWatch,
        //                             docId: widget.docId,
        //                             requirements: stepRequirement,
        //                             applicationId: applicationId,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   );
        //                 },
        //                 error:
        //                     (error, st) => Center(child: Text(error.toString())),
        //                 loading: () => Center(child: CircularProgressIndicator()),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 180),
        //         ],
        //       ),
        //     ),

        //     Positioned(
        //       bottom: 0,
        //       left: 0,
        //       right: 0,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           border: Border(top: BorderSide(color: greyTextFBorderColor)),
        //           borderRadius: BorderRadius.horizontal(
        //             right: Radius.circular(10),
        //             left: Radius.circular(10),
        //           ),
        //           color: Colors.white,
        //           // boxShadow: [
        //           //   BoxShadow(
        //           //     color: Colors.black.withOpacity(0.1),
        //           //     blurRadius: 8,
        //           //     offset: Offset(0, -2),
        //           //   ),
        //           // ],
        //         ),
        //         padding: EdgeInsets.symmetric(
        //           horizontal: size.otstup18,
        //           vertical: size.otstup20,
        //         ),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             My_Button(
        //               width: double.infinity,
        //               size: size,
        //               backgroundColor: Colors.white,
        //               borderColor: greyTextFBorderColor,
        //               borderRadius: 10,
        //               onPressed: () {},
        //               child: textWithH1Style(
        //                 "Сохранить как черновик",
        //                 fontsize: 15,
        //               ),
        //             ),
        //             SizedBox(height: 12),
        //             My_Button(
        //               width: double.infinity,
        //               size: size,
        //               backgroundColor: primaryButtonColor,
        //               borderColor: primaryButtonColor,
        //               borderRadius: 10,
        //               onPressed: () {
        //                 _onContinuePressed(asyncSteps, currentStep);
        //               },
        //               child: textWithH1Style(
        //                 "Продoлжить",
        //                 fontsize: 15,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  void _onContinuePressed(
    AsyncValue<StepsInfoAndRequirement> asyncSteps,
    int currentStep,
  ) async {
    final asyncStepsData = asyncSteps.value;
    if (asyncStepsData == null) return;

    final stepsAndFields = asyncStepsData.stepsInfo[0].data;
    final steps = stepsAndFields.steps;
    final currentStepData = steps.firstWhere(
      (s) => s.position == currentStep + 1,
    );

    if (currentStepData.type != 'FORM') {
      if (currentStep < steps.length - 1) {
        ref.read(currentStepProvider.notifier).state++;
      }
      return;
    }

    // Валидация формы
    if (!_formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Заполните все обязательные поля")),
      // );
      return;
    }

    try {
      final fieldGroups =
          stepsAndFields.fieldGroups
              .where((g) => g.stepId == currentStepData.id)
              .toList();

      final List<FieldValueModel> stepFields = [];

      for (final group in fieldGroups) {
        for (final field in group.fields) {
          if (field.type == 'TEXT_BLOCK') continue;

          final value = ref
              .watch(formProviderFamily(widget.docId))
              .getValue(field.key);

          dynamic sendValue = value;
          if (value is ChoiceOption) {
            sendValue = value.code;
          } else if (value is DateTime) {
            sendValue = DateFormat('yyyy-MM-dd').format(value);
          } else if (value is bool) {
            sendValue = value.toString();
          }

          stepFields.add(
            FieldValueModel(key: field.key, value: sendValue.toString()),
          );
        }
      }

      await ShagiPolucheniyeUslugiService().updateFormBySteps(
        currentStepData.id!,
        asyncStepsData.applicationId,
        stepFields,
        context,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Шаг сохранён")));

      // if (currentStep < steps.length - 1) {
      //   ref.read(currentStepProvider.notifier).state++;
      //   _scrollToTop(); // опционально
      // }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Widget buildStepContent({
    required StepInfo step,
    required List<FieldGroup> groups,
    required FormProvider formFamilyProviderWatch,
    required FormProvider formFamilyProviderRead,
    required AdaptiveSizes size,
    required Locale currentLocale,
    required int docId,
    required List<Requirement> requirements,
    required int applicationId,
  }) {
    return step.type == 'FORM'
        ? Form(
          key: _formKey,
          child: Column(
            children: [
              ...groups.map((fieldGroups) {
                final file = ref.watch(uploadedFileProvider(applicationId));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      fieldGroups.title.getText(currentLocale),
                      textAlign: TextAlign.start,
                      fontsize: 17,
                      maxLines: 6,
                      color: Color(0xFF00505a),
                      fontW: FontWeight.w500,
                    ),
                    SizedBox(height: size.otstup15),
                    fieldGroups.groupDuplicate == false
                        ? Column(
                          children:
                              fieldGroups.fields.map((field) {
                                // final selectedItem = ref.watch(
                                //   selectedValueProvider,
                                // );
                                final _controller = formFamilyProviderWatch
                                    .getTextController(field.key);

                                switch (field.type) {
                                  case 'INPUT':
                                    final kalidiShahodatNomaPassword =
                                        formFamilyProviderWatch
                                            .getTextController(
                                              'APPLICANT_PASSWORD',
                                            );
                                    final kalidiShahodatNomaConfirm =
                                        formFamilyProviderWatch
                                            .getTextController(
                                              'APPLICANT_REPEATED_PASSWORD',
                                            );
                                    return InputTextField(
                                      field: field,
                                      keyboardType: TextInputType.name,
                                      onTap: () {},
                                      size: size,
                                      formKey: formFamilyProviderWatch
                                          .getFieldKey(field.key),
                                      labelText: field.title.getText(
                                        currentLocale,
                                      ),

                                      suffixIcon:
                                          field.key == 'DS_OWNER_NAME' ||
                                                  field.key ==
                                                      'APPLICANT_PASSWORD'
                                              ? IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                16,
                                                              ),
                                                        ),
                                                        child: SizedBox(
                                                          width:
                                                              size.screenWidth *
                                                              0.8,
                                                          child: InfoContentDialog(
                                                            data: field
                                                                .infoContent
                                                                .getText(
                                                                  currentLocale,
                                                                ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.quiz_outlined,
                                                  color: primaryGreenColor,
                                                  size: size.cancelIconSize30,
                                                ),
                                              )
                                              : SizedBox.shrink(),
                                      inputFormatters: [
                                        (field.key == "APPLICANT_TIN" ||
                                                field.key == "TRUSTED_TIN")
                                            ? innFormatter
                                            : MaskTextInputFormatter(),
                                      ],
                                      hintText:
                                          (field.key == "APPLICANT_TIN" ||
                                                  field.key == "TRUSTED_TIN")
                                              ? (field.placeholder
                                                          .getText(
                                                            currentLocale,
                                                          )
                                                          .isNotEmpty ==
                                                      true
                                                  ? field.placeholder.getText(
                                                    currentLocale,
                                                  )
                                                  : "___ ___ ___")
                                              : (field.type == "DATE" ||
                                                  field.type == "DATE_OF_BIRTH")
                                              ? (field.placeholder
                                                          .getText(
                                                            currentLocale,
                                                          )
                                                          .isNotEmpty ==
                                                      true
                                                  ? field.placeholder.getText(
                                                    currentLocale,
                                                  )
                                                  : "дд.мм.гггг")
                                              : field.placeholder.getText(
                                                currentLocale,
                                              ),
                                      controller: _controller,
                                      // onFieldSubmitted: (value) {
                                      //   // formFamilyProviderRead.setValue(
                                      //   //   field.key,
                                      //   //   value,
                                      //   // );
                                      // },
                                      onChanged: (value) {
                                        ref
                                            .read(formProviderFamily(docId))
                                            .setValue(field.key, value);
                                      },
                                      validator: (value) {
                                        if (field.required &&
                                            (value?.trim().isEmpty ?? true)) {
                                          return "Обязательное поле";
                                        }

                                        if (field.key == 'APPLICANT_TIN' ||
                                            field.key == 'TRUSTED_TIN') {
                                          if ((value?.length ?? 0) < 9) {
                                            return "ИНН должен содержать 9 символов";
                                          }
                                        }

                                        if (field.key == 'APPLICANT_PASSWORD') {
                                          if ((value?.length ?? 0) < 8) {
                                            return "Минимум 8 символов";
                                          }
                                        }

                                        // Самая важная проверка — только для поля подтверждения
                                        if (field.key ==
                                            'APPLICANT_REPEATED_PASSWORD') {
                                          final pass =
                                              kalidiShahodatNomaPassword.text;
                                          final confirm = value ?? '';

                                          if (confirm.isEmpty) {
                                            return "Подтвердите пароль";
                                          }
                                          if (pass != confirm) {
                                            return "Пароли не совпадают";
                                          }
                                        }

                                        if (field.key == 'DS_OWNER_NAME') {
                                          return validateCertificateOwner(
                                            value,
                                          );
                                        }

                                        return null;
                                      },
                                      // validator: (value) {
                                      //   if (field.required == true &&
                                      //           value == null ||
                                      //       value!.isEmpty) {
                                      //     return "Поле обязательно для заполнения";
                                      //   }
                                      //   if (field.key == 'APPLICANT_TIN' &&
                                      //       value.length < 9) {
                                      //     return "Введите минимальную длину";
                                      //   }
                                      //   if (field.key == "APPLICANT_PASSWORD" ||
                                      //       field.key ==
                                      //               "APPLICANT_REPEATED_PASSWORD" &&
                                      //           kalidiShahodatNomaPassword
                                      //                   .text !=
                                      //               kalidiShahodatNomaConfirm
                                      //                   .text) {
                                      //     return 'Пароли не совпадают';
                                      //   }
                                      //   if (kalidiShahodatNomaPassword.text ==
                                      //       kalidiShahodatNomaConfirm.text) {
                                      //     return null;
                                      //   }
                                      //   if (field.key == 'DS_OWNER_NAME') {
                                      //     return validateCertificateOwner(
                                      //       value,
                                      //     );
                                      //   }
                                      //   return null;
                                      // },
                                    );

                                  case 'TEXT_EDITOR':
                                  case 'DATE':
                                    final controller = ref.watch(
                                      formProviderFamily(docId).select(
                                        (p) => p.getTextController(field.key),
                                      ),
                                    );
                                    return field.visible == true
                                        ? InputTextField(
                                          field: field,
                                          inputFormatters: [dateFormatter],
                                          keyboardType: TextInputType.datetime,
                                          onTap: () {},
                                          size: size,
                                          formKey: ref.watch(
                                            formProviderFamily(docId).select(
                                              (form) =>
                                                  form.getFieldKey(field.key),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            ref
                                                .read(formProviderFamily(docId))
                                                .setValue(field.key, value);
                                          },
                                          labelText: field.title.getText(
                                            currentLocale,
                                          ),
                                          readOnly: field.readonly,
                                          hintText:
                                              (field.key == "APPLICANT_TIN" ||
                                                      field.key ==
                                                          "TRUSTED_TIN")
                                                  ? (field.placeholder
                                                              .getText(
                                                                currentLocale,
                                                              )
                                                              .isNotEmpty ==
                                                          true
                                                      ? field.placeholder
                                                          .getText(
                                                            currentLocale,
                                                          )
                                                      : "___ ___ ___")
                                                  : (field.type ==
                                                          "BIRTH_DATE" ||
                                                      field.type ==
                                                          "DATE_OF_BIRTH")
                                                  ? (field.placeholder
                                                              .getText(
                                                                currentLocale,
                                                              )
                                                              .isNotEmpty ==
                                                          true
                                                      ? field.placeholder
                                                          .getText(
                                                            currentLocale,
                                                          )
                                                      : "дд.мм.гггг")
                                                  : field.placeholder.getText(
                                                    currentLocale,
                                                  ),

                                          controller: controller,

                                          // onFieldSubmitted: (value) {},
                                          validator: (value) {},
                                          suffixIcon: IconButton(
                                            onPressed: () async {
                                              DateTime?
                                              datetime = await showDatePicker(
                                                // switchToCalendarEntryModeIcon: Icon(Icons.abc,size: 100,),
                                                context: context,
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2100),
                                                initialDate: DateTime.now(),
                                              );
                                              if (datetime != null) {
                                                final picked = DateFormat(
                                                  'dd-MM-yyyy',
                                                ).format(datetime);
                                                formFamilyProviderRead.setValue(
                                                  field.key,
                                                  picked,
                                                );
                                                _controller.text = picked;
                                              }
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: primaryButtonColor,
                                            ),
                                          ),
                                        )
                                        : SizedBox.shrink();

                                  case 'TEXT_BLOCK':
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color:
                                              field.textBlockColor == 'ORANGE'
                                                  ? Color(0xFFffefe3)
                                                  : field.textBlockColor ==
                                                      'BLUE'
                                                  ? Color(0xFFeaf5ff)
                                                  : Color(0xFFeafff3),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              field.title.getText(
                                                currentLocale,
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color:
                                                    field.textBlockColor ==
                                                            'ORANGE'
                                                        ? Color(0xFFF79B58)
                                                        : field.textBlockColor ==
                                                            'BLUE'
                                                        ? Color(0xFF4ca2f2)
                                                        : primaryButtonColor,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              field.textBlockContent.getText(
                                                currentLocale,
                                              ),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                  // case 'DROP_DOWN':
                                  //   return ActionSelect(
                                  //     applicationId: applicationId,
                                  //     name: field.title.getText(currentLocale),
                                  //     label: field.placeholder.getText(
                                  //       currentLocale,
                                  //     ),
                                  //     actionId: field.actionId!,
                                  //     actionKey: field.choiceOptionsAuto,
                                  //   );
                                  case 'DROP_DOWN':
                                    final stepsInfoAsync = ref.watch(
                                      shagiProvider(docId),
                                    );

                                    List<ChoiceOption> baseOptions =
                                        field.choiceOptions;
                                    print("FULL LIST////////////");

                                    print(baseOptions.map((e) => e.name.ru));

                                    return stepsInfoAsync.when(
                                      loading:
                                          () => buildDropdownSkeleton(
                                            field,
                                            isLoading: true,
                                          ),
                                      error:
                                          (err, stack) => buildDropdownSkeleton(
                                            field,
                                            error: err.toString(),
                                          ),
                                      data: (stepsInfo) {
                                        if (baseOptions.isEmpty &&
                                            field.actionId != null) {
                                          baseOptions =
                                              stepsInfo.dropDownOptions[field
                                                  .actionId] ??
                                              [];
                                        }
                                        final bool isDependent =
                                            field.actionKey == null &&
                                            field.choiceOptionsAuto != null;

                                        if (!isDependent) {
                                          return _buildDropdown(
                                            field: field,
                                            options: baseOptions,
                                            selectedValue:
                                                formFamilyProviderRead.getValue(
                                                      field.key,
                                                    )
                                                    as String?,
                                            onChanged: (String? newValue) {
                                              if (newValue == null) return;

                                              formFamilyProviderRead.setValue(
                                                field.key,
                                                newValue,
                                              );
                                              Future.microtask(() {
                                                ref
                                                    .read(
                                                      selectedValueProvider
                                                          .notifier,
                                                    )
                                                    .update(
                                                      (state) => newValue,
                                                    );
                                              });
                                            },
                                            size: size,
                                          );
                                        }
                                        final selectedParentCode = ref.watch(
                                          selectedValueProvider,
                                        );

                                        if (selectedParentCode.isEmpty) {
                                          return _buildDropdown(
                                            field: field,
                                            options: [],
                                            selectedValue: null,
                                            onChanged: (value) => null,
                                            size: size,
                                          );
                                        }

                                        print("ACTION ID/*******************");

                                        print(field.actionId);

                                        final dependentAsync = ref.watch(
                                          dependentDropdownProvider((
                                            applicationId:
                                                stepsInfo.applicationId,
                                            locale: currentLocale,
                                            actionKey: field.choiceOptionsAuto!,
                                            parentCode: selectedParentCode,
                                            parentActionId: 'REGION_ID',
                                          )),
                                        );

                                        return dependentAsync.when(
                                          loading:
                                              () => buildDropdownSkeleton(
                                                field,
                                                isLoading: true,
                                              ),
                                          error:
                                              (err, _) => buildDropdownSkeleton(
                                                field,
                                                error: err.toString(),
                                              ),
                                          data: (dataMap) {
                                            final dependentOptions =
                                                (dataMap[field.actionId] ??
                                                        <ChoiceOption>[])
                                                    .toSet()
                                                    .toList();

                                            String? currentValue =
                                                formFamilyProviderRead.getValue(
                                                      field.key,
                                                    )
                                                    as String?;

                                            if (currentValue != null &&
                                                !dependentOptions.any(
                                                  (opt) =>
                                                      opt.code == currentValue,
                                                )) {
                                              Future.microtask(() {
                                                formFamilyProviderRead.setValue(
                                                  field.key,
                                                  null,
                                                );
                                              });
                                              currentValue = null;
                                            }

                                            return _buildDropdown(
                                              field: field,
                                              options: dependentOptions,
                                              selectedValue: currentValue,
                                              onChanged: (String? newValue) {
                                                Future.microtask(() {
                                                  formFamilyProviderRead
                                                      .setValue(
                                                        field.key,
                                                        newValue,
                                                      );
                                                });
                                              },
                                              size: size,
                                            );
                                          },

                                          // data: (dataMap) {
                                          //   final dependentOptions =
                                          //       (dataMap[field.actionId] ??
                                          //               <ChoiceOption>[])
                                          //           .toSet()
                                          //           .toList();
                                          //   String? currentValue =
                                          //       formFamilyProviderRead.getValue(
                                          //             field.key,
                                          //           )
                                          //           as String?;
                                          //   if (currentValue != null &&
                                          //       !dependentOptions.any(
                                          //         (opt) =>
                                          //             opt.code == currentValue,
                                          //       )) {
                                          //     currentValue = null;
                                          //     formFamilyProviderRead.setValue(
                                          //       field.key,
                                          //       null,
                                          //     );
                                          //   }
                                          //   return _buildDropdown(
                                          //     field: field,
                                          //     options: dependentOptions,
                                          //     selectedValue: currentValue,
                                          //     onChanged: (String? newValue) {
                                          //       formFamilyProviderRead.setValue(
                                          //         field.key,
                                          //         newValue,
                                          //       );
                                          //     },
                                          //     size: size,
                                          //   );
                                          // },
                                        );
                                      },
                                    );
                                  case 'RADIO_BUTTON':
                                    // final radioValue = ref.watch(
                                    //   formProviderFamily(docId).select(
                                    //     (p) => p.getValue(field.key) ?? false,
                                    //   ),
                                    // );
                                    return FormField<ChoiceOption>(
                                      initialValue: formFamilyProviderWatch
                                          .getRadioChoiceValue(
                                            field.key,
                                            field.choiceOptions,
                                          ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Поле обязательное для заполнения';
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: field.title.getText(
                                                      currentLocale,
                                                    ),
                                                    style: TextStyle(
                                                      color: primaryButtonColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '* ',
                                                    style: TextStyle(
                                                      color: primaryButtonColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RadioButton(
                                              size: size,
                                              options: field.choiceOptions,
                                              choice: state.value,
                                              onChanged: (Object? value) {
                                                if (value is ChoiceOption) {
                                                  state.didChange(value);

                                                  // formFamilyProviderRead.setValue(
                                                  //   field.key,
                                                  //   value.code,
                                                  // );
                                                  print(
                                                    'Radio value changed: ${value.code}',
                                                  );
                                                }
                                              },
                                            ),
                                            if (state.hasError)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 1,
                                                ),
                                                child: Text(
                                                  state.errorText ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    );
                                  case 'SWITCH':
                                    final switchValue = ref.watch(
                                      formProviderFamily(docId).select(
                                        (p) => p.getValue(field.key) ?? false,
                                      ),
                                    );

                                    return SwitchWidget(
                                      content: field.title.getText(
                                        currentLocale,
                                      ),
                                      onToggle: (value) {
                                        ref
                                            .read(formProviderFamily(docId))
                                            .setValue(field.key, value);
                                      },
                                      size: size,
                                      isOn: switchValue,
                                      validator: (value) {
                                        if (value != true) {
                                          return "Поле обязательно для заполнения";
                                        }

                                        return null;
                                      },
                                    );
                                  case 'FILE':
                                    return Column(
                                      children: [
                                        InputTextField(
                                          field: field,
                                          onChanged: (value) {
                                            ref
                                                .read(formProviderFamily(docId))
                                                .setValue(field.key, value);
                                          },
                                          onTap: () async {
                                            final result =
                                                await FilePicker.platform
                                                    .pickFiles();

                                            if (result == null) return;

                                            final file = result.files.first;

                                            setState(() {
                                              _controller.text =
                                                  file.name ?? '';
                                            });
                                          },
                                          labelText: field.title.getText(
                                            currentLocale,
                                          ),
                                          hintText:
                                              field.placeholder.getText(
                                                currentLocale,
                                              ) ??
                                              'Выберите файл',
                                          controller: _controller,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Поле обязательно для заполнения";
                                            }
                                          },
                                          formKey: formFamilyProviderWatch
                                              .getFieldKey(field.key),
                                          size: size,
                                          suffixIcon:
                                              _controller.text.trim().isEmpty
                                                  ? IconButton(
                                                    onPressed: () async {
                                                      final result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles();

                                                      if (result == null)
                                                        return;

                                                      final file =
                                                          result.files.first;

                                                      setState(() {
                                                        _controller.text =
                                                            file.name ?? '';
                                                        _pickedFile = file;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .file_download_outlined,
                                                      color: primaryButtonColor,
                                                    ),
                                                  )
                                                  : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _controller.text = '';
                                                        _pickedFile = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: primaryButtonColor,
                                                    ),
                                                  ),
                                        ),
                                      ],
                                    );

                                  case 'TEXT_AREA':
                                    return InputTextField(
                                      field: field,
                                      onChanged: (value) {
                                        ref
                                            .read(formProviderFamily(docId))
                                            .setValue(field.key, value);
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLength: 3,
                                      labelText: field.title.getText(
                                        currentLocale,
                                      ),
                                      hintText: field.placeholder.getText(
                                        currentLocale,
                                      ),
                                      controller: _controller,
                                      // onFieldSubmitted: (value) {},
                                      validator: (value) {},
                                      formKey: formFamilyProviderWatch
                                          .getFieldKey(field.key),
                                      size: size,
                                      onTap: () {},
                                    );
                                  case 'TIME':
                                    return InputTextField(
                                      field: field,
                                      onChanged: (value) {
                                        ref
                                            .read(formProviderFamily(docId))
                                            .setValue(field.key, value);
                                      },
                                      // isFocused: _isFocused,
                                      // focusNode: _focusNode,
                                      labelText: field.title.getText(
                                        currentLocale,
                                      ),
                                      hintText: 'чч:мм',
                                      controller: _controller,
                                      // onFieldSubmitted: (value) {},
                                      validator: (value) {},
                                      formKey: formFamilyProviderWatch
                                          .getFieldKey(field.key),
                                      size: size,
                                      suffixIcon: Icon(
                                        Icons.av_timer,
                                        color: primaryButtonColor,
                                      ),
                                      onTap: () {},
                                    );

                                  default:
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: Text(
                                        "Неизвестный тип: ${field.type}",
                                      ),
                                    );
                                }
                              }).toList(),
                        )
                        : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: size.otstup10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),
                                            contentPadding:
                                                const EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            content: SizedBox(
                                              width: double.maxFinite,
                                              // height: size.screenHeight * 0.5,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    textWithH1Style(
                                                      fieldGroups.title.ru!,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontsize: 18,
                                                    ),
                                                    fieldGroups
                                                            .title
                                                            .ru!
                                                            .isNotEmpty
                                                        ? Divider(
                                                          color:
                                                              primaryGreenColor,
                                                        )
                                                        : SizedBox.shrink(),
                                                    SizedBox(
                                                      height: size.otstup10,
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children:
                                                          fieldGroups.fields.map((
                                                            field,
                                                          ) {
                                                            final selectedItem =
                                                                ref.watch(
                                                                  selectedValueProvider,
                                                                );
                                                            final _controller =
                                                                formFamilyProviderWatch
                                                                    .getTextController(
                                                                      field.key,
                                                                    );

                                                            switch (field
                                                                .type) {
                                                              case 'INPUT':
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            16,
                                                                      ),
                                                                  child: InputTextField(
                                                                    field:
                                                                        field,
                                                                    inputFormatters: [
                                                                      innFormatter,
                                                                    ],
                                                                    suffixIcon:
                                                                        field.key ==
                                                                                "TRUSTED_TIN"
                                                                            ? IconButton(
                                                                              onPressed: () {
                                                                                //METHOD SEARCH
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.search,
                                                                                color:
                                                                                    primaryGreenColor,
                                                                              ),
                                                                            )
                                                                            : SizedBox.shrink(),
                                                                    size: size,
                                                                    formKey: formFamilyProviderWatch
                                                                        .getFieldKey(
                                                                          field
                                                                              .key,
                                                                        ),
                                                                    labelText: field
                                                                        .title
                                                                        .getText(
                                                                          currentLocale,
                                                                        ),
                                                                    hintText:
                                                                        "",
                                                                    // (field.key ==
                                                                    //             "APPLICANT_TIN" ||
                                                                    //         field.key ==
                                                                    //             "TRUSTED_TIN")
                                                                    //     ? (field.placeholder
                                                                    //                 .getText(
                                                                    //                   currentLocale,
                                                                    //                 )
                                                                    //                 .isNotEmpty ==
                                                                    //             true
                                                                    //         ? ""
                                                                    //         // field.placeholder.getText(
                                                                    //         //   currentLocale,
                                                                    //         // )
                                                                    //         : "___ ___ ___")
                                                                    //     : (field.type ==
                                                                    //             "DATE" ||
                                                                    //         field.type ==
                                                                    //             "DATE_OF_BIRTH")
                                                                    //     ? (field.placeholder
                                                                    //                 .getText(
                                                                    //                   currentLocale,
                                                                    //                 )
                                                                    //                 .isNotEmpty ==
                                                                    //             true
                                                                    //         ? field.placeholder.getText(
                                                                    //           currentLocale,
                                                                    //         )
                                                                    //         : "дд.мм.гггг")
                                                                    //     : field.placeholder.getText(
                                                                    //       currentLocale,
                                                                    //     ),
                                                                    controller:
                                                                        _controller,
                                                                    onChanged: (
                                                                      value,
                                                                    ) {
                                                                      ref
                                                                          .read(
                                                                            formProviderFamily(
                                                                              docId,
                                                                            ),
                                                                          )
                                                                          .setValue(
                                                                            field.key,
                                                                            value,
                                                                          );
                                                                    },
                                                                    validator: (
                                                                      value,
                                                                    ) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return "Поле обязательно для заполнения";
                                                                      }
                                                                      if (field.key ==
                                                                              'APPLICANT_TIN' &&
                                                                          value.length <
                                                                              9) {
                                                                        return "Введите минимальную длину";
                                                                      }
                                                                      return null;
                                                                    },

                                                                    onTap:
                                                                        () {},
                                                                  ),
                                                                );

                                                              case 'DATE':
                                                                final controller = ref.watch(
                                                                  formProviderFamily(
                                                                    docId,
                                                                  ).select(
                                                                    (
                                                                      p,
                                                                    ) => p.getTextController(
                                                                      field.key,
                                                                    ),
                                                                  ),
                                                                );
                                                                return field.visible ==
                                                                        true
                                                                    ? InputTextField(
                                                                      field:
                                                                          field,
                                                                      inputFormatters: [
                                                                        dateFormatter,
                                                                      ],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .datetime,
                                                                      onTap:
                                                                          () {},
                                                                      size:
                                                                          size,
                                                                      formKey: ref.watch(
                                                                        formProviderFamily(
                                                                          docId,
                                                                        ).select(
                                                                          (
                                                                            form,
                                                                          ) => form.getFieldKey(
                                                                            field.key,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onChanged: (
                                                                        value,
                                                                      ) {
                                                                        ref
                                                                            .read(
                                                                              formProviderFamily(
                                                                                docId,
                                                                              ),
                                                                            )
                                                                            .setValue(
                                                                              field.key,
                                                                              value,
                                                                            );
                                                                      },
                                                                      labelText: field
                                                                          .title
                                                                          .getText(
                                                                            currentLocale,
                                                                          ),
                                                                      readOnly:
                                                                          field
                                                                              .readonly,
                                                                      hintText:
                                                                          (field.key ==
                                                                                      "APPLICANT_TIN" ||
                                                                                  field.key ==
                                                                                      "TRUSTED_TIN")
                                                                              ? (field.placeholder
                                                                                          .getText(
                                                                                            currentLocale,
                                                                                          )
                                                                                          .isNotEmpty ==
                                                                                      true
                                                                                  ? field.placeholder.getText(
                                                                                    currentLocale,
                                                                                  )
                                                                                  : "___ ___ ___")
                                                                              : (field.type ==
                                                                                      "BIRTH_DATE" ||
                                                                                  field.type ==
                                                                                      "DATE_OF_BIRTH")
                                                                              ? (field.placeholder
                                                                                          .getText(
                                                                                            currentLocale,
                                                                                          )
                                                                                          .isNotEmpty ==
                                                                                      true
                                                                                  ? field.placeholder.getText(
                                                                                    currentLocale,
                                                                                  )
                                                                                  : "дд.мм.гггг")
                                                                              : field.placeholder.getText(
                                                                                currentLocale,
                                                                              ),

                                                                      controller:
                                                                          controller,

                                                                      // onFieldSubmitted: (value) {},
                                                                      validator:
                                                                          (
                                                                            value,
                                                                          ) {},
                                                                      suffixIcon: IconButton(
                                                                        onPressed: () async {
                                                                          DateTime?
                                                                          datetime = await showDatePicker(
                                                                            // switchToCalendarEntryModeIcon: Icon(Icons.abc,size: 100,),
                                                                            context:
                                                                                context,
                                                                            firstDate: DateTime(
                                                                              1950,
                                                                            ),
                                                                            lastDate: DateTime(
                                                                              2100,
                                                                            ),
                                                                            initialDate:
                                                                                DateTime.now(),
                                                                          );
                                                                          if (datetime !=
                                                                              null) {
                                                                            final picked = DateFormat(
                                                                              'dd-MM-yyyy',
                                                                            ).format(
                                                                              datetime,
                                                                            );
                                                                            formFamilyProviderRead.setValue(
                                                                              field.key,
                                                                              picked,
                                                                            );
                                                                            _controller.text =
                                                                                picked;
                                                                          }
                                                                        },
                                                                        icon: Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          color:
                                                                              primaryButtonColor,
                                                                        ),
                                                                      ),
                                                                    )
                                                                    : SizedBox.shrink();
                                                              case 'RADIO_BUTTON':
                                                                // final radioValue = ref.watch(
                                                                //   formProviderFamily(docId).select(
                                                                //     (p) => p.getValue(field.key) ?? false,
                                                                //   ),
                                                                // );
                                                                return FormField<
                                                                  ChoiceOption
                                                                >(
                                                                  initialValue: formFamilyProviderWatch
                                                                      .getRadioChoiceValue(
                                                                        field
                                                                            .key,
                                                                        field
                                                                            .choiceOptions,
                                                                      ),
                                                                  validator: (
                                                                    value,
                                                                  ) {
                                                                    if (value ==
                                                                        null) {
                                                                      return 'Поле обязательное для заполнения';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  builder: (
                                                                    state,
                                                                  ) {
                                                                    return Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        RadioButton(
                                                                          size:
                                                                              size,
                                                                          options:
                                                                              field.choiceOptions,
                                                                          choice:
                                                                              state.value,
                                                                          onChanged: (
                                                                            Object?
                                                                            value,
                                                                          ) {
                                                                            if (value
                                                                                is ChoiceOption) {
                                                                              state.didChange(
                                                                                value,
                                                                              );

                                                                              // formFamilyProviderRead.setValue(
                                                                              //   field.key,
                                                                              //   value.code,
                                                                              // );
                                                                              print(
                                                                                'Radio value changed: ${value.code}',
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                        if (state
                                                                            .hasError)
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                              top:
                                                                                  0,
                                                                              bottom:
                                                                                  1,
                                                                            ),
                                                                            child: Text(
                                                                              state.errorText ??
                                                                                  '',
                                                                              style: const TextStyle(
                                                                                color:
                                                                                    Colors.red,
                                                                                fontSize:
                                                                                    12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );

                                                              case 'FILE':
                                                                return Padding(
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                  child: Column(
                                                                    children: [
                                                                      InputTextField(
                                                                        field:
                                                                            field,
                                                                        onChanged: (
                                                                          value,
                                                                        ) {
                                                                          ref
                                                                              .read(
                                                                                formProviderFamily(
                                                                                  docId,
                                                                                ),
                                                                              )
                                                                              .setValue(
                                                                                field.key,
                                                                                value,
                                                                              );
                                                                        },
                                                                        onTap: () async {
                                                                          final result =
                                                                              await FilePicker.platform.pickFiles();

                                                                          if (result ==
                                                                              null)
                                                                            return;

                                                                          final file =
                                                                              result.files.first;

                                                                          setState(() {
                                                                            _controller.text =
                                                                                file.name ??
                                                                                '';
                                                                          });
                                                                        },
                                                                        labelText: field
                                                                            .title
                                                                            .getText(
                                                                              currentLocale,
                                                                            ),
                                                                        hintText:
                                                                            field.placeholder.getText(
                                                                              currentLocale,
                                                                            ) ??
                                                                            'Выберите файл',
                                                                        controller:
                                                                            _controller,
                                                                        validator: (
                                                                          value,
                                                                        ) {
                                                                          if (value ==
                                                                                  null ||
                                                                              value.isEmpty) {
                                                                            return "Поле обязательно для заполнения";
                                                                          }
                                                                        },
                                                                        formKey: formFamilyProviderWatch.getFieldKey(
                                                                          field
                                                                              .key,
                                                                        ),
                                                                        size:
                                                                            size,
                                                                        suffixIcon:
                                                                            _controller.text.trim().isEmpty
                                                                                ? IconButton(
                                                                                  onPressed: () async {
                                                                                    final result =
                                                                                        await FilePicker.platform.pickFiles();

                                                                                    if (result ==
                                                                                        null)
                                                                                      return;

                                                                                    final file =
                                                                                        result.files.first;

                                                                                    //UPLOADING FILE
                                                                                    ////////////////
                                                                                    ///////////////

                                                                                    setState(
                                                                                      () async {
                                                                                        _controller.text =
                                                                                            file.name ??
                                                                                            '';
                                                                                        _pickedFile =
                                                                                            file;

                                                                                        // await ShagiPolucheniyeUslugiService().uploadFile(
                                                                                        //   applicationId,
                                                                                        // );

                                                                                        // await ShagiPolucheniyeUslugiService().getUploadedFileInfo(
                                                                                        //   applicationId,
                                                                                        // );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.file_download_outlined,
                                                                                    color:
                                                                                        primaryButtonColor,
                                                                                  ),
                                                                                )
                                                                                : IconButton(
                                                                                  onPressed: () {
                                                                                    setState(
                                                                                      () {
                                                                                        _controller.text = '';
                                                                                        _pickedFile =
                                                                                            null;
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.delete_outline,
                                                                                    color:
                                                                                        primaryButtonColor,
                                                                                  ),
                                                                                ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              case 'DROP_DOWN':
                                                                final stepsInfoAsync =
                                                                    ref.watch(
                                                                      shagiProvider(
                                                                        docId,
                                                                      ),
                                                                    );

                                                                List<
                                                                  ChoiceOption
                                                                >
                                                                baseOptions =
                                                                    field
                                                                        .choiceOptions;

                                                                return stepsInfoAsync.when(
                                                                  loading:
                                                                      () => buildDropdownSkeleton(
                                                                        field,
                                                                        isLoading:
                                                                            true,
                                                                      ),
                                                                  error:
                                                                      (
                                                                        err,
                                                                        stack,
                                                                      ) => buildDropdownSkeleton(
                                                                        field,
                                                                        error:
                                                                            err.toString(),
                                                                      ),
                                                                  data: (
                                                                    stepsInfo,
                                                                  ) {
                                                                    if (baseOptions
                                                                            .isEmpty &&
                                                                        field.actionId !=
                                                                            null) {
                                                                      baseOptions =
                                                                          stepsInfo
                                                                              .dropDownOptions[field
                                                                              .actionId] ??
                                                                          [];
                                                                    }
                                                                    final bool
                                                                    isDependent =
                                                                        field.actionKey ==
                                                                            null &&
                                                                        field.choiceOptionsAuto !=
                                                                            null;

                                                                    if (!isDependent) {
                                                                      return _buildDropdown(
                                                                        field:
                                                                            field,
                                                                        options:
                                                                            baseOptions,
                                                                        selectedValue:
                                                                            formFamilyProviderRead.getValue(
                                                                                  field.key,
                                                                                )
                                                                                as String?,
                                                                        onChanged: (
                                                                          String?
                                                                          newValue,
                                                                        ) {
                                                                          if (newValue ==
                                                                              null)
                                                                            return;

                                                                          formFamilyProviderRead.setValue(
                                                                            field.key,
                                                                            newValue,
                                                                          );
                                                                          Future.microtask(() {
                                                                            ref
                                                                                .read(
                                                                                  selectedValueProvider.notifier,
                                                                                )
                                                                                .update(
                                                                                  (
                                                                                    state,
                                                                                  ) =>
                                                                                      newValue,
                                                                                );
                                                                          });
                                                                        },
                                                                        size:
                                                                            size,
                                                                      );
                                                                    }
                                                                    final selectedParentCode =
                                                                        ref.watch(
                                                                          selectedValueProvider,
                                                                        );

                                                                    if (selectedParentCode
                                                                        .isEmpty) {
                                                                      return _buildDropdown(
                                                                        field:
                                                                            field,
                                                                        options:
                                                                            [],
                                                                        selectedValue:
                                                                            null,
                                                                        onChanged:
                                                                            (
                                                                              value,
                                                                            ) =>
                                                                                null,
                                                                        size:
                                                                            size,
                                                                      );
                                                                    }

                                                                    final dependentAsync = ref.watch(
                                                                      dependentDropdownProvider((
                                                                        applicationId:
                                                                            stepsInfo.applicationId,
                                                                        locale:
                                                                            currentLocale,
                                                                        actionKey:
                                                                            field.choiceOptionsAuto!,
                                                                        parentCode:
                                                                            selectedParentCode,
                                                                        parentActionId:
                                                                            "REGION_ID",
                                                                      )),
                                                                    );

                                                                    return dependentAsync.when(
                                                                      loading:
                                                                          () => buildDropdownSkeleton(
                                                                            field,
                                                                            isLoading:
                                                                                true,
                                                                          ),
                                                                      error:
                                                                          (
                                                                            err,
                                                                            _,
                                                                          ) => buildDropdownSkeleton(
                                                                            field,
                                                                            error:
                                                                                err.toString(),
                                                                          ),
                                                                      data: (
                                                                        dataMap,
                                                                      ) {
                                                                        final dependentOptions =
                                                                            (dataMap[field.actionId] ??
                                                                                    <
                                                                                      ChoiceOption
                                                                                    >[])
                                                                                .toSet()
                                                                                .toList();

                                                                        String?
                                                                        currentValue =
                                                                            formFamilyProviderRead.getValue(
                                                                                  field.key,
                                                                                )
                                                                                as String?;

                                                                        if (currentValue !=
                                                                                null &&
                                                                            !dependentOptions.any(
                                                                              (
                                                                                opt,
                                                                              ) =>
                                                                                  opt.code ==
                                                                                  currentValue,
                                                                            )) {
                                                                          Future.microtask(() {
                                                                            formFamilyProviderRead.setValue(
                                                                              field.key,
                                                                              null,
                                                                            );
                                                                          });
                                                                          currentValue =
                                                                              null;
                                                                        }

                                                                        return _buildDropdown(
                                                                          field:
                                                                              field,
                                                                          options:
                                                                              dependentOptions,
                                                                          selectedValue:
                                                                              currentValue,
                                                                          onChanged: (
                                                                            String?
                                                                            newValue,
                                                                          ) {
                                                                            Future.microtask(() {
                                                                              formFamilyProviderRead.setValue(
                                                                                field.key,
                                                                                newValue,
                                                                              );
                                                                            });
                                                                          },
                                                                          size:
                                                                              size,
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                );

                                                              case 'TEXT_BLOCK':
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            12,
                                                                      ),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                      color:
                                                                          field.textBlockColor ==
                                                                                  'ORANGE'
                                                                              ? Color(
                                                                                0xFFffefe3,
                                                                              )
                                                                              : field.textBlockColor ==
                                                                                  'BLUE'
                                                                              ? Color(
                                                                                0xFFeaf5ff,
                                                                              )
                                                                              : Color(
                                                                                0xFFeafff3,
                                                                              ),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                          16,
                                                                        ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          field.title.getText(
                                                                            currentLocale,
                                                                          ),
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                field.textBlockColor ==
                                                                                        'ORANGE'
                                                                                    ? Color(
                                                                                      0xFFF79B58,
                                                                                    )
                                                                                    : field.textBlockColor ==
                                                                                        'BLUE'
                                                                                    ? Color(
                                                                                      0xFF4ca2f2,
                                                                                    )
                                                                                    : primaryButtonColor,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          field.textBlockContent.getText(
                                                                            currentLocale,
                                                                          ),
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );

                                                              default:
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        bottom:
                                                                            12,
                                                                      ),
                                                                  child: Text(
                                                                    "Неизвестный тип: ${field.type}",
                                                                    style: const TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  ),
                                                                );
                                                            }
                                                          }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  My_Button(
                                                    size: size,
                                                    backgroundColor:
                                                        Colors.white,
                                                    borderColor:
                                                        primaryGreenColor,
                                                    onPressed:
                                                        () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(),
                                                    child: textWithH1Style(
                                                      "Отмена",
                                                      color: primaryGreenColor,
                                                      fontsize: 15,
                                                    ),
                                                  ),
                                                  My_Button(
                                                    size: size,
                                                    backgroundColor:
                                                        primaryGreenColor,
                                                    borderColor:
                                                        primaryButtonColor,
                                                    onPressed: () async {
                                                      // ref.read(
                                                      //   uploadeMethodFileProvider(
                                                      //     applicationId,
                                                      //   ),
                                                      // );
                                                    },
                                                    child: textWithH1Style(
                                                      "Сохранить",
                                                      color: Colors.white,
                                                      fontsize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        textWithH1Style(
                                          "Добавить",
                                          color: primaryButtonColor,
                                          fontsize: 17,
                                        ),
                                        SizedBox(width: size.otstup10),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: primaryGreenColor,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: primaryGreenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            file.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        textWithH1Style("belka.png"),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.edit_rounded,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              error:
                                  (st, error) =>
                                      Center(child: Text("${error}")),
                              loading:
                                  () => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            ),
                          ],
                        ),
                  ],
                );
              }),
            ],
          ),
        )
        : step.type == 'PAYMENT'
        ? Container(
          decoration: BoxDecoration(
            border: Border.all(color: greyTextFBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup18,
              vertical: size.otstup15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      "Электронная подпись",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: size.otstup5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textWithH2BlackStyle(
                          "№ инвойса:",
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        SizedBox(height: size.otstup5),

                        textWithH2BlackStyle(
                          " 5555555555555",
                          color: primaryGreenColor,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(color: greyTextFBorderColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      "Номер заявки:",
                      fontW: FontWeight.normal,
                      fontsize: 16,
                    ),
                    SizedBox(height: size.otstup5),

                    textWithH2BlackStyle("1208", textAlign: TextAlign.start),
                  ],
                ),
                Divider(color: greyTextFBorderColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      "Дата:",
                      fontW: FontWeight.normal,
                      fontsize: 16,
                    ),
                    SizedBox(height: size.otstup5),

                    textWithH2BlackStyle("12.08.2026"),
                  ],
                ),
                Divider(color: greyTextFBorderColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      "Сумма:",
                      fontW: FontWeight.normal,
                      fontsize: 16,
                    ),
                    SizedBox(height: size.otstup5),

                    Row(
                      children: [
                        textWithH2BlackStyle("120 "),
                        textWithH2BlackStyle("Сомони"),
                      ],
                    ),
                  ],
                ),
                Divider(color: greyTextFBorderColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      "Статус:",
                      fontW: FontWeight.normal,
                      fontsize: 16,
                    ),
                    SizedBox(height: size.otstup5),
                    textWithH2BlackStyle("Не оплачен", color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        )
        : RequirementStep(stepRequirement: requirements, documentId: docId);
    // : Container();
  }
}

Widget _buildDropdown({
  required Field field,
  required List<ChoiceOption> options,
  required void Function(String?) onChanged,
  String? selectedValue,
  AdaptiveSizes? size,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: field.title.ru,
                style: const TextStyle(
                  color: primaryButtonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: '* ',
                style: TextStyle(color: primaryButtonColor, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        DropdownButtonFormField2<String>(
          value: selectedValue,
          hint: SizedBox(
            width: size!.screenWidth * 0.65,
            child: Text(
              field.placeholder.ru ?? '',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          // hint: Text('Выберите  '),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0, right: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryButtonColor),
            ),
            border: const OutlineInputBorder(),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
          ),
          items:
              options.map((option) {
                return DropdownMenuItem<String>(
                  value: option.code,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.otstup10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.screenWidth * 0.6,
                          child: Text(
                            option.name.ru ??
                                option.name.en ??
                                option.code ??
                                "",
                            style: const TextStyle(
                              height: 1.1,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: size.screenWidth * 0.6,
                          height: 0.5,
                          color: primaryGreenColor,
                          margin: const EdgeInsets.only(top: 3),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          selectedItemBuilder: (context) {
            return options.map<Widget>((option) {
              return SizedBox(
                width: size!.screenWidth * 0.6,
                child: Text(
                  option.name.ru ?? option.name.en ?? option.code ?? "",
                  style: const TextStyle(color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
