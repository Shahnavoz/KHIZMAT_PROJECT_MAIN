import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_application_provider.dart';
import 'package:khizmat_new/feature/documents/data/providers/my_documents_provider.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_application_detail_page.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_document_detail_page.dart';
import 'package:khizmat_new/feature/process/data/services/process_api_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/masks/field_masks.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/start_document_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';
import 'package:khizmat_new/feature/home/data/providers/controllers_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/payment_webview_page.dart';
import 'package:khizmat_new/feature/process/data/models/process_state.dart';
import 'package:khizmat_new/feature/process/data/providers/process_providers.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/_build_dropdown_skeleton.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/radio_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/requirement_step.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/switch_widget.dart';
import 'package:khizmat_new/generated/l10n.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final currentStepProvider = StateProvider<int>((ref) => 0);

class StepsPage extends ConsumerStatefulWidget {
  final int docId;
  final int index;

  /// If non-null, resumes an existing IN_PROCESS application instead of
  /// starting a new one. React equivalent: /application/:applicationId route
  /// with useProcess({ resumeOnload: true, applicationId }).
  final int? resumeApplicationId;

  const StepsPage({
    super.key,
    required this.docId,
    required this.index,
    this.resumeApplicationId,
  });

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
  final _focusNode = FocusNode();
  final _uploadingNotifier = ValueNotifier<bool>(false);
  bool _isPressing = false;
  // Tracks which step index requirements were last reloaded for, so we
  // call reloadRequirements only once each time we enter a REQUIREMENTS step.
  int _requirementsLoadedForStep = -1;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
    // React: Start saga — called once when the page opens.
    // Using addPostFrameCallback so the ProviderScope is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset step index for each new application flow — React equivalent:
      // StepperModule.Provider initialises with firstStepKey on every mount.
      ref.read(currentStepProvider.notifier).state = 0;
      final locale = ref.read(localeProvider);
      if (widget.resumeApplicationId != null) {
        // React: /application/:applicationId → useProcess({ resumeOnload: true, applicationId })
        ref
            .read(processProvider.notifier)
            .resume(widget.resumeApplicationId!, locale);
      } else {
        ref.read(processProvider.notifier).start(widget.docId, locale);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _openPaymentWebView(ProcessState processData) async {
    final serial =
        processData.fieldValues
            .firstWhere(
              (f) => f.key == 'INVOICE_SERIAL',
              orElse: () => FieldValueModel(key: '', value: ''),
            )
            .value;

    if (serial.isEmpty || !mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => PaymentWebViewPage(
              url: 'https://pay.ekhizmat.tj/00037736',
              redirectUri: '',
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    // React equivalent: useProcess hook / Redux process state.
    // processAsync drives the entire page — loading / error / data.
    final processAsync = ref.watch(processProvider);
    // currentStepProvider is kept for the step-bar UI indicator only.
    // Its value is synced from the server's lastStepId after every API call.
    final currentStep = ref.watch(currentStepProvider);
    final currentLocale = ref.watch(localeProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: S.of(context).back,
        // actionWidget: Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: FontSettingContainer(size: size),
        // ),
      ),
      // bottomNavigationBar:
      // Container(
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
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/BACK.png",
              // "assets/images/WHITE MAINcut.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
          ),
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
                    child: processAsync.when(
                      data: (processData) {
                        // On first load only: restore step from server's last_step_id.
                        // (React: firstStepKey in StepperModule.Provider)
                        // Do NOT sync on every rebuild — navigation is driven by +1 on success.
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (ref.read(currentStepProvider) == 0) {
                            final serverIndex = processData.currentStepIndex;
                            if (serverIndex > 0) {
                              ref.read(currentStepProvider.notifier).state =
                                  serverIndex;
                            }
                          }
                        });

                        final stepsAndFields = processData.info.data;
                        final steps = stepsAndFields.steps;
                        final stepRequirement =
                            processData.requirements.data.requirements;
                        final sortedSteps =
                            steps.toList()..sort(
                              (a, b) => a.position!.compareTo(b.position!),
                            );
                        if (sortedSteps.isEmpty ||
                            currentStep < 0 ||
                            currentStep >= sortedSteps.length) {
                          return null;
                        }

                        // When entering a REQUIREMENTS step, reload the requirements
                        // with the currently selected specialization IDs — React does
                        // this via useRequirements({ specializationIds }) on mount.
                        // Only reload if there are specialization IDs — the initial
                        // load already handles the no-specialization case correctly.
                        if (sortedSteps[currentStep].type == 'REQUIREMENTS' &&
                            currentStep != _requirementsLoadedForStep) {
                          _requirementsLoadedForStep = currentStep;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!mounted) return;
                            final specRaw =
                                (ref
                                        .read(formProviderFamily(widget.docId))
                                        .getValue('SELECTED_SPECIALIZATIONS')
                                    as String?) ??
                                '';
                            final specIds =
                                specRaw
                                    .split(':')
                                    .where((s) => s.isNotEmpty)
                                    .toList();
                            // Only call reloadRequirements if there are actual
                            // specialization IDs selected. Without them, the
                            // initial requirements load is already correct.
                            if (specIds.isNotEmpty) {
                              ref
                                  .read(processProvider.notifier)
                                  .reloadRequirements(
                                    specializationIds: specIds,
                                  );
                            }
                          });
                        }

                        // Convert FieldValueModel → Value for FormProvider
                        final applicantion =
                            processData.fieldValues
                                .map(
                                  (fv) => Value(key: fv.key, value: fv.value),
                                )
                                .toList();

                        final fieldGroups = stepsAndFields.fieldGroups;
                        final currentStepGroups =
                            fieldGroups
                                .where(
                                  (fieldGroup) =>
                                      fieldGroup.stepId ==
                                      sortedSteps[currentStep].id,
                                )
                                .toList();
                        for (var group in fieldGroups) {
                          group.fields.sort(
                            (a, b) => a.position.compareTo(b.position),
                          );
                          if (sortedSteps.isEmpty ||
                              currentStep < 0 ||
                              currentStep >= sortedSteps.length) {
                            return null;
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                        S.of(context).shagNomer(currentStep + 1),
                                      ),
                                      textWithH1Style(" / "),
                                      textWithH1Style(
                                        (steps.length.toString()),
                                      ),
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

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.otstup20,
                                  // vertical: size.otstup15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: List.generate(steps.length, (
                                        index,
                                      ) {
                                        // Use local variable — do not call setState during build
                                        final currentIndex = index;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                index != 0 ? size.otstup15 : 0,
                                          ),
                                          // React: StepBar is purely visual — no onTap navigation
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color:
                                                      currentIndex ==
                                                                  currentStep ||
                                                              currentIndex <
                                                                  currentStep
                                                          ? primaryButtonColor
                                                          : Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 2,
                                                    color:
                                                        currentIndex ==
                                                                    currentStep ||
                                                                currentIndex <
                                                                    currentStep
                                                            ? primaryButtonColor
                                                            : greyTextFBorderColor,
                                                  ),
                                                ),
                                                child:
                                                    currentIndex < currentStep
                                                        ? Icon(
                                                          Icons.done,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )
                                                        : Center(
                                                          child: textWithH1Style(
                                                            fontsize: 16,
                                                            color:
                                                                currentIndex ==
                                                                        currentStep
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            (index + 1)
                                                                .toString(),
                                                          ),
                                                        ),
                                              ),
                                              Container(
                                                width: size.screenWidth * 0.1,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color:
                                                      currentIndex ==
                                                                  currentStep ||
                                                              currentIndex <
                                                                  currentStep
                                                          ? primaryButtonColor
                                                          : greyTextFBorderColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.otstup18),
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
                                child: StepContentWidget(
                                  // Key on step index: keeps state alive during
                                  // same step rebuilds (e.g. after file upload),
                                  // resets form state only when step changes.
                                  key: ValueKey(currentStep),
                                  currentLocale: currentLocale,
                                  size: size,
                                  step: sortedSteps[currentStep],
                                  groups: currentStepGroups,
                                  docId: widget.docId,
                                  applicationId: processData.applicationId,
                                  requirements: stepRequirement,
                                  specializations: processData.specializations,
                                  initialvalues: applicantion,
                                  formKey: _formKey,
                                  uploadingNotifier: _uploadingNotifier,
                                ),
                                // buildStepContent(
                                // currentLocale: currentLocale,
                                // size: size,
                                // step: sortedSteps[currentStep],
                                // groups: currentStepGroups,
                                // formFamilyProviderRead:
                                //     formFamilyProviderRead,
                                // formFamilyProviderWatch:
                                //     formFamilyProviderWatch,
                                // docId: widget.docId,
                                // requirements: stepRequirement,
                                // initialvalues: applicantion,
                                // ),
                              ),
                            ),
                          ],
                        );
                      },
                      error:
                          (error, st) => Center(child: Text(error.toString())),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                SizedBox(height: size.screenHeight * 0.2),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (context) {
                return processAsync.when(
                  data: (processData) {
                    final steps = processData.sortedSteps;
                    final currentStepIdx = ref.watch(currentStepProvider);

                    if (steps.isEmpty ||
                        currentStepIdx < 0 ||
                        currentStepIdx >= steps.length) {
                      return const SizedBox.shrink();
                    }

                    final currentStepType = steps[currentStepIdx].type;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: greyTextFBorderColor),
                        ),
                        borderRadius: const BorderRadius.horizontal(
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
                              if (currentStepType == 'PAYMENT') {
                                // "Заполнить заново" — cancel and restart
                                ref
                                    .read(processProvider.notifier)
                                    .cancel()
                                    .then((cancelled) {
                                      if (!cancelled) return; // cancel failed — don't start a new process
                                      // Reset form state so old values don't bleed into the new attempt
                                      ref
                                          .read(formProviderFamily(widget.docId))
                                          .disposeControllers();
                                      // Reset step indicator to 0
                                      ref
                                          .read(currentStepProvider.notifier)
                                          .state = 0;
                                      final locale = ref.read(localeProvider);
                                      ref
                                          .read(processProvider.notifier)
                                          .start(widget.docId, locale);
                                    });
                              } else {
                                // "Назад" — React: Back saga
                                // After back(), processState.currentStepIndex
                                // reflects the server's new last_step_id position.
                                ref.read(processProvider.notifier).back().then((
                                  _,
                                ) {
                                  final ps =
                                      ref.read(processProvider).valueOrNull;
                                  if (ps != null) {
                                    ref
                                        .read(currentStepProvider.notifier)
                                        .state = ps.currentStepIndex;
                                  }
                                });
                              }
                            },
                            child: textWithH1Style(
                              currentStepType == 'PAYMENT'
                                  ? S.of(context).fillAgain
                                  : S.of(context).back,
                              fontsize: 15,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ValueListenableBuilder<bool>(
                            valueListenable: _uploadingNotifier,
                            builder:
                                (context, isUploading, _) => My_Button(
                                  width: double.infinity,
                                  size: size,
                                  backgroundColor:
                                      (processData.isSubmitting ||
                                              isUploading ||
                                              _isPressing)
                                          ? primaryButtonColor.withValues(
                                            alpha: 0.5,
                                          )
                                          : primaryButtonColor,
                                  borderColor: primaryButtonColor,
                                  borderRadius: 10,
                                  onPressed:
                                      (processData.isSubmitting ||
                                              isUploading ||
                                              _isPressing)
                                          ? () {}
                                          : () async {
                                            if (_isPressing) return;
                                            setState(() => _isPressing = true);
                                            try {
                                              if (currentStepType ==
                                                  'PAYMENT') {
                                                // await _openPaymentWebView(
                                                //   processData,
                                                // );
                                              } else {
                                                await _onContinuePressed(
                                                  processData,
                                                  currentStepIdx,
                                                  currentLocale,
                                                );
                                              }
                                            } finally {
                                              if (mounted)
                                                setState(
                                                  () => _isPressing = false,
                                                );
                                            }
                                          },
                                  child:
                                      (processData.isSubmitting ||
                                              isUploading ||
                                              _isPressing)
                                          ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : textWithH1Style(
                                            currentStepType == 'PAYMENT'
                                                ? S.of(context).goToPayment
                                                : S.of(context).continueButton,
                                            fontsize: 15,
                                            color: Colors.white,
                                          ),
                                ),
                          ), // ValueListenableBuilder
                        ],
                      ),
                    );
                  },
                  // data: (allStepsInfo) {
                  //   final stepsAndFields = allStepsInfo.stepsInfo[0].data;
                  //   final fields = stepsAndFields.fieldGroups[0].fields;
                  //   final steps =
                  //       stepsAndFields.steps.toList()
                  //         ..sort((a, b) => a.position!.compareTo(b.position!));
                  //   final currentStepIdx = ref.watch(currentStepProvider);

                  //   final step = steps.map((s) => s.type).toList();

                  //   final applicationId = allStepsInfo.applicationId;
                  //   final docId = allStepsInfo.stepsInfo[0].data.document.id;

                  //   if (steps.isEmpty ||
                  //       currentStepIdx < 0 ||
                  //       currentStepIdx >= steps.length) {
                  //     return const SizedBox.shrink();
                  //   }

                  //   return Container(
                  //     decoration: BoxDecoration(
                  //       border: Border(
                  //         top: BorderSide(color: greyTextFBorderColor),
                  //       ),
                  //       borderRadius: BorderRadius.horizontal(
                  //         right: Radius.circular(10),
                  //         left: Radius.circular(10),
                  //       ),
                  //       color: Colors.white,
                  //     ),
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
                  //           onPressed: () {
                  //             // Полный доступ к steps, currentStepIdx, allStepsInfo!
                  //             print(
                  //               "Сохранить черновик: шаг ${currentStepIdx + 1}/${steps.length}",
                  //             );
                  //           },
                  //           child: textWithH1Style(
                  //             step[currentStep] == 'PAYMENT'
                  //                 ? "Заполнить заново"
                  //                 : "Назад",
                  //             fontsize: 15,
                  //           ),
                  //         ),
                  //         SizedBox(height: 12),
                  //         My_Button(
                  //           width: double.infinity,
                  //           size: size,
                  //           backgroundColor: primaryButtonColor,
                  //           borderColor: primaryButtonColor,
                  //           borderRadius: 10,
                  //           onPressed: () async {
                  //             step[currentStep] == 'PAYMENT'
                  //                 ? Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder:
                  //                         (context) => GosOrganizationsPage(),
                  //                   ),
                  //                 )
                  //                 : _onContinuePressed(
                  //                   asyncSteps,
                  //                   currentStep,
                  //                   currentLocale,
                  //                   docId!,
                  //                   currentStepIdx,
                  //                 );
                  //           },
                  //           child: textWithH1Style(
                  //             step[currentStep] == 'PAYMENT'
                  //                 ? "Перейти к оплате"
                  //                 : "Продолжить",
                  //             fontsize: 15,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // },
                  loading: () => const SizedBox.shrink(),
                  error: (error, st) => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // React equivalent: _onContinuePressed mirrors the Update saga flow.
  // The key fix vs. the old code:
  //   OLD: ref.invalidate(shagiProvider(docId))  ← restarted the entire application!
  //   NEW: processProvider.notifier.next()       ← server returns new lastStepId,
  //        currentStepProvider is synced from ProcessState.currentStepIndex.
  Future<void> _onContinuePressed(
    ProcessState processData,
    int currentStepIdx,
    Locale currentLocale,
  ) async {
    // Guard: ignore if already submitting (covers double-tap race condition)
    if (ref.read(processProvider).valueOrNull?.isSubmitting == true) return;
    final steps = processData.sortedSteps;

    // ── DEBUG: print full step schema ──────────────────────────────────────
    print('===== STEP SCHEMA =====');
    for (int i = 0; i < steps.length; i++) {
      print(
        '  [$i] id=${steps[i].id}, position=${steps[i].position}, type=${steps[i].type}',
      );
    }
    print('currentStepIdx: $currentStepIdx');
    print(
      'processData.currentStepId (last_step_id): ${processData.currentStepId}',
    );
    print('processData.currentStepIndex: ${processData.currentStepIndex}');
    print(
      'processData.currentStepPosition: ${processData.currentStepPosition}',
    );
    print('========================');

    if (currentStepIdx < 0 || currentStepIdx >= steps.length) return;

    final currentStepData = steps[currentStepIdx];

    // ── REQUIREMENTS step ────────────────────────────────────────────────
    if (currentStepData.type == 'REQUIREMENTS') {
      final allRequirements = processData.requirements.data.requirements;
      final formProv = ref.read(formProviderFamily(widget.docId));

      // Collect checked requirement IDs as SELECTED_REQUIREMENTS values.
      // React: List.tsx joins with ':' — server validates valuesArray.length == items.length
      final checkedIds =
          allRequirements
              .where((req) => formProv.getValue(req.id.toString()) == true)
              .map((req) => req.id.toString())
              .toList();

      // DEBUG — remove after fix is confirmed
      print('===== REQUIREMENTS STEP =====');
      print('allRequirements count: ${allRequirements.length}');
      print(
        'allRequirements ids: ${allRequirements.map((r) => r.id).toList()}',
      );
      print('checkedIds: $checkedIds');
      print('step_id (position): ${processData.currentStepPosition}');
      print('SELECTED_REQUIREMENTS value: "${checkedIds.join(':')}"');
      print('==============================');

      // Client-side guard: ALL requirements must be accepted (mirrors React's
      // validate fn: if (valuesArray.length !== length) return error).
      if (allRequirements.isNotEmpty &&
          checkedIds.length < allRequirements.length) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(
              S.of(context).oznakomtesIpotverditeVseTrebovaniya,
            ),
          ),
        );
        return;
      }

      // React: getValues(state, position) for REQUIREMENTS returns ONLY
      // SELECTED_REQUIREMENTS (it's the only field in byStep[requirementsPosition]).
      // Sending extra fields from other steps causes last_step_id to stall.
      final reqValues = [
        FieldValueModel(
          key: 'SELECTED_REQUIREMENTS',
          value: checkedIds.join(':'),
        ),
      ];
      // Always use the step's own position as step_id (matches React behavior).
      final ok = await ref
          .read(processProvider.notifier)
          .next(values: reqValues, stepPosition: currentStepData.position);
      if (!mounted) return;
      if (ok) {
        final processState = ref.read(processProvider).valueOrNull;
        if (processState?.isComplete == true) {
          await _navigateToCreatedApplication(processState!.applicationId);
          return;
        }
        _advanceStep(processState, currentStepIdx, navigateIfLastStep: true);
      } else {
        final error =
            ref.read(processProvider).valueOrNull?.submitError ?? 'Ошибка';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $error')));
      }
      return;
    }

    // ── Non-FORM steps (SPECIALIZATION, STATUS, PAYMENT) ─────────────────
    // React: all step types go through the same Formik form → getValues()
    // returns all server-accumulated field values for that position.
    // We mirror this by sending processData.fieldValues (server-echoed values
    // merged with any FormProvider-held values) so the server sees a complete
    // application on each update call, avoiding 403 "required fields not filled".
    if (currentStepData.type != 'FORM') {
      // React: getValues(state, position) returns only the fields for this step.
      // For STATUS/PAYMENT/SPECIALIZATION, these are the step-specific extra fields
      // (APPLICATION_STATUS, REGISTER_ID, invoice fields, etc.) from server values.
      // Sending all fields causes last_step_id to stall, so filter to step's fields.
      const stepExtraFields = <String, List<String>>{
        'SPECIALIZATION': ['SELECTED_SPECIALIZATIONS'],
        'STATUS': [
          'APPLICATION_STATUS',
          'APPLICATION_REVIEW_DEADLINE',
          'APPLICATION_REVIEW_DATE_BEGIN',
          'APPLICATION_REVIEW_DATE_END',
          'APPLICATION_REVIEW_DEADLINE_ADJUST',
          'REGISTER_ID',
        ],
        'PAYMENT': [
          'INVOICE_ISSUE_DATE',
          'INVOICE_AMOUNT',
          'INVOICE_AMOUNT_ONLINE',
          'INVOICE_SERIAL',
          'INVOICE_QR_CODE',
          'INVOICE_STATUS',
          'INVOICE_BANK_ACCOUNT',
          'INVOICE_PAYEE',
          'INVOICE_PAYER',
          'INVOICE_DETAILS',
          'INVOICE_BUDGET_ACCOUNT',
          'INVOICE_BANK_NAME',
          'INVOICE_BANK_MFO',
        ],
      };
      final allowedKeys = stepExtraFields[currentStepData.type];
      final List<FieldValueModel> stepValues;
      if (currentStepData.type == 'SPECIALIZATION') {
        // Collect checked specialization IDs from FormProvider checkboxes,
        // join with ':' — mirrors the React SELECTED_SPECIALIZATIONS approach.
        final formProv = ref.read(formProviderFamily(widget.docId));
        final specs = processData.specializations;
        final checkedIds =
            specs
                .where((s) => formProv.getValue(s.id.toString()) == true)
                .map((s) => s.id.toString())
                .toList();
        final joined = checkedIds.join(':');
        // Persist in FormProvider so the REQUIREMENTS step can read it later.
        formProv.setValue('SELECTED_SPECIALIZATIONS', joined);
        stepValues = [
          FieldValueModel(key: 'SELECTED_SPECIALIZATIONS', value: joined),
        ];
      } else if (allowedKeys != null) {
        stepValues =
            processData.fieldValues
                .where(
                  (fv) => allowedKeys.contains(fv.key) && fv.value.isNotEmpty,
                )
                .toList();
      } else {
        // Unknown type: send nothing (server will use current state).
        stepValues = [];
      }

      print('===== NON-FORM STEP SUBMIT =====');
      print(
        'type: ${currentStepData.type}, stepIdToSend: ${currentStepData.position}',
      );
      print('values count: ${stepValues.length}');
      print('================================');

      final ok = await ref
          .read(processProvider.notifier)
          .next(values: stepValues, stepPosition: currentStepData.position);
      if (ok && mounted) {
        final processState = ref.read(processProvider).valueOrNull;
        if (processState?.isComplete == true) {
          await _navigateToCreatedApplication(processState!.applicationId);
          return;
        }
        _advanceStep(processState, currentStepIdx, navigateIfLastStep: true);
      }
      return;
    }

    // ── FORM step ─────────────────────────────────────────────────────────
    if (!_formKey.currentState!.validate()) {
      // Scroll to the first field that failed validation.
      final formProv = ref.read(formProviderFamily(widget.docId));
      final stepFields =
          processData.info.data.fieldGroups
              .where((g) => g.stepId == currentStepData.id)
              .expand((g) => g.fields)
              .toList();
      for (final f in stepFields) {
        final key = formProv.fieldKeys[f.key];
        if (key?.currentContext != null) {
          final value = formProv.getValue(f.key)?.toString() ?? '';
          final isRequired = f.required;
          if (isRequired && value.trim().isEmpty) {
            Scrollable.ensureVisible(
              key!.currentContext!,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: 0.3,
            );
            break;
          }
        }
      }
      return;
    }

    try {
      // Current step's groups only — React: getValues(state, position) returns
      // ONLY the fields in byStep[position] (current step), not all steps.
      final fieldGroups =
          processData.info.data.fieldGroups
              .where((g) => g.stepId == currentStepData.id)
              .toList();

      final formProv = ref.read(formProviderFamily(widget.docId));

      // Seed merged with server-returned values so server-prefilled fields
      // (e.g. APPLICANT_TIN from PINFL lookup) are included.
      // React equivalent: Redux field entities accumulate server values;
      // getValues returns current-step fields, but those fields already carry
      // the server-echoed values for the whole form.
      final Map<String, String> merged = {
        for (final fv in processData.fieldValues)
          if (fv.value.isNotEmpty) fv.key: fv.value,
      };

      // Override with user's fresh input from FormProvider — ALL GROUPS.
      // React stores ALL field values in Redux across every step; when any step
      // is submitted the full accumulated store is available.  Reading only the
      // current step's groups caused event/info fields from steps 2-4 to be
      // missing from merged when submitting step 5, producing 403.
      for (final group in processData.info.data.fieldGroups) {
        for (final field in group.fields) {
          // Skip display-only and invisible/disabled fields.
          // IMPORTANT: apply runtime overrides from actionEvent (React: actionEventList
          // updates entity.visible/disabled) — a field with visible:false in the schema
          // can be made visible:true by an actionEvent (e.g. conditionally required
          // file fields).  Using field.visible alone would skip such fields and lose
          // the uploaded fileId / user input, causing 403 "Required fields not filled".
          if (field.type == 'TEXT_BLOCK') continue;
          // React: accumulates ALL field values regardless of visibility/disabled.
          // Do NOT skip fields based on visibility here — cattle fields and other
          // conditionally-visible fields must have their values captured in merged
          // so they are included in stepFields when the server requires them.

          final controller = formProv.textControllers[field.key];

          if (field.type == 'FILE' || field.type == 'OPEN_SOURCE_FILE') {
            // React: setFieldValue(name, String(file.id)) — stored fileId
            final fileId = formProv.getValue(field.key)?.toString() ?? '';
            if (fileId.isNotEmpty) merged[field.key] = fileId;
          } else if (field.type == 'DATE' ||
              field.type == 'DATE_OF_BIRTH' ||
              field.type == 'BIRTH_DATE') {
            // React sends dates as dd.MM.yyyy (e.g. "22.04.2026").
            // The mask formatter also produces dd.MM.yyyy, so controller.text
            // is already in the correct format.  The date picker used to
            // format as dd-MM-yyyy which this code then converted to ISO
            // yyyy-MM-dd — the server rejected that.  Now the picker also
            // uses dd.MM.yyyy, so just send the raw value as-is.
            final raw = controller?.text ?? '';
            if (raw.isNotEmpty) {
              merged[field.key] = raw;
            }
          } else if (field.type == 'DATE_TIME') {
            // DATE_TIME stored as "dd-MM-yyyy HH:mm"
            final raw = controller?.text ?? '';
            if (raw.isNotEmpty) {
              try {
                final dt = DateFormat('dd-MM-yyyy HH:mm').parseStrict(raw);
                merged[field.key] = DateFormat('yyyy-MM-dd HH:mm').format(dt);
              } catch (_) {
                merged[field.key] = raw;
              }
            }
          } else if (field.type == 'CHECK_BOX') {
            // React: CHECK_BOX stores colon-separated codes
            final val = formProv.getValue(field.key)?.toString() ?? '';
            if (val.isNotEmpty) merged[field.key] = val;
          } else if (field.type == 'SWITCH') {
            final val = formProv.getValue(field.key);
            merged[field.key] = (val == true).toString();
          } else {
            // For masked INPUT fields, formProv stores the UNMASKED value
            // (raw digits, set via onChanged → getUnmaskedText()).
            // Prefer that over controller.text which contains mask literals.
            final storedValue = formProv.getValue(field.key);
            String? sv;
            if (storedValue is ChoiceOption) {
              sv = storedValue.code ?? '';
            } else if (storedValue is DateTime) {
              sv = DateFormat('yyyy-MM-dd').format(storedValue);
            } else if (storedValue is bool) {
              sv = storedValue.toString();
            } else if (storedValue != null &&
                storedValue.toString().isNotEmpty) {
              sv = storedValue.toString();
            } else if (controller != null && controller.text.isNotEmpty) {
              // Fallback: no FormProvider value, use controller text directly
              sv = controller.text;
            }
            if (sv != null && sv.isNotEmpty) {
              merged[field.key] = sv;
            } else {
              // React: actionEventList can set a default value on the field entity
              // (e.g. '0' for cattle count when BANKET_EVENT is selected).
              // Apply fieldOverrides.value as a last fallback so those defaults
              // reach the server even when the field is invisible in the UI.
              // Also fall back to field.key when actionId is null.
              final overrideVal =
                  (processData.fieldOverrides[field.actionId] ??
                          processData.fieldOverrides[field.key])
                      ?.value;
              if (overrideVal != null && overrideVal.isNotEmpty) {
                merged[field.key] = overrideVal;
              }
            }
          }
        }
      }

      // ── DEBUG: print fieldOverrides for cattle fields specifically ─────────
      for (final key in [
        'APPLICANT_QUANTITY_CATTLE',
        'APPLICANT_QUANTITY_SMALL_CATTLE',
      ]) {
        final grp =
            processData.info.data.fieldGroups
                .expand((g) => g.fields)
                .where((f) => f.key == key)
                .firstOrNull;
        if (grp != null) {
          // Fix: fall back to field.key when actionId is null
          final override =
              processData.fieldOverrides[grp.actionId] ??
              processData.fieldOverrides[grp.key];
          print(
            '[CATTLE DEBUG] key=$key actionId=${grp.actionId} '
            'schema.visible=${grp.visible} schema.required=${grp.required} '
            'override=${override != null ? "visible=${override.visible} required=${override.required} value=${override.value}" : "none"} '
            'merged=${merged[key] ?? "(not in merged)"}',
          );
        }
      }

      // ── DEBUG: show ALL groups in schema (to diagnose missing groups) ────
      print('===== ALL FIELD GROUPS IN SCHEMA =====');
      for (final g in processData.info.data.fieldGroups) {
        final fieldSummary =
            g.fields
                .map(
                  (f) =>
                      '${f.key}(${f.type},req=${f.required},vis=${f.visible})',
                )
                .toList();
        print(
          '  Group: key=${g.key}, stepId=${g.stepId}, fields=$fieldSummary',
        );
      }
      print(
        '  Current step id=${currentStepData.id}, position=${currentStepData.position}',
      );
      print('  Matched groups: ${fieldGroups.map((g) => g.key).toList()}');
      print('======================================');

      // Build final field list for the CURRENT step's groups.
      // React: getValues(state, position) returns fields in byStep[position].
      final List<FieldValueModel> stepFields = [];
      final processedKeys = <String>{};

      for (final group in fieldGroups) {
        for (final field in group.fields) {
          // NOTE: do NOT skip TEXT_BLOCK here.
          // React's getValues() sends ALL field types including TEXT_BLOCK.
          // The server requires certain TEXT_BLOCK fields to be present in the
          // payload (e.g. IS_BUSINESS_DAY, ELIGIBLE_GUESTS_NUMBER,
          // DATE_INTERVAL_VALID_CODE on step 4) — omitting them causes a 403/
          // no-advance even when all user-entered fields are correct.
          // TEXT_BLOCK values are server-computed; they arrive in processData.
          // fieldValues and are seeded into merged at the top of this method.
          if (processedKeys.contains(field.key)) continue;
          // React: getValues() sends ALL fields for the step — no visibility check.
          // The server decides what is required based on its own conditional logic.
          // Filtering by visible/disabled caused server-expected fields with
          // visible:false (e.g. duplicable group fields) to be missing → 403.

          if (group.groupDuplicate) {
            // React: duplicable_values: [{position:1, value:"…"}, ...]
            final raw = merged[field.key] ?? '';
            final parts = raw.split(',');
            final dupVals =
                parts
                    .asMap()
                    .entries
                    .where((e) => e.value.isNotEmpty)
                    .map(
                      (e) =>
                          DuplicableValue(position: e.key + 1, value: e.value),
                    )
                    .toList();
            // Always include — even with empty duplicable_values: [].
            // React sends duplicable fields unconditionally; the server checks
            // field PRESENCE in the body, not just value content.
            stepFields.add(
              FieldValueModel(
                key: field.key,
                value: '',
                duplicableValues: dupVals,
              ),
            );
          } else {
            final value = merged[field.key] ?? '';
            // Look up visibility override: try field.actionId first, then
            // field.key as fallback (some fields have actionId=null but the
            // server's actionEvent response references them by key).
            final override =
                processData.fieldOverrides[field.actionId] ??
                processData.fieldOverrides[field.key];
            final isVisible = override?.visible ?? field.visible;
            // Skip fields that are invisible AND have no value — sending empty
            // values for invisible fields (e.g. cattle for BANKET_EVENT) causes
            // the server to reject the step even though they are not required.
            // Visible fields and fields with a value are always included.
            if (!isVisible && value.isEmpty) {
              processedKeys.add(field.key);
              continue;
            }
            stepFields.add(FieldValueModel(key: field.key, value: value));
          }
          processedKeys.add(field.key);
        }
      }

      // React: getValues(state, position) returns ONLY byStep[position] fields.
      // Sending fields from other steps causes the server to re-evaluate earlier
      // steps and refuse to advance last_step_id.  Each submission must contain
      // exactly the current step's fields — the server stores previous steps'
      // data server-side from prior submissions.

      // ── DEBUG: log exactly what is sent to the server ────────────────
      print('===== FORM STEP SUBMIT =====');
      print(
        'visual step position (stepIdToSend): ${currentStepData.position}, server last_step_id: ${processData.currentStepId}',
      );
      print('allMergedKeys count: ${merged.length}');
      print('merged keys: ${merged.keys.toList()}');
      print('stepFields count: ${stepFields.length}');
      for (final sf in stepFields) {
        print(
          '  field: key=${sf.key}, value=${sf.value}, dupVals=${sf.duplicableValues}',
        );
      }
      print('============================');

      // ── Catch-up: server rule is "accept step_id=N only when last_step_id=N" ──
      // If the user went back (processBack resets last_step_id) and then
      // navigated forward without re-submitting intermediate steps, the server
      // will sit at last_step_id < current UI position and refuse to advance.
      // Re-submit each pending position using its own groups' fields from merged.
      final serverPendingPos = processData.currentStepId; // last_step_id
      final currentStepPos = currentStepData.position ?? 0;
      if (serverPendingPos < currentStepPos) {
        final allSteps = processData.sortedSteps;
        for (int pos = serverPendingPos; pos < currentStepPos; pos++) {
          // Find the step at this position
          StepInfo? pendingStep;
          for (final s in allSteps) {
            if ((s.position ?? 0) == pos) {
              pendingStep = s;
              break;
            }
          }
          if (pendingStep == null) continue;

          // Build fields for this step using its groups from merged
          final pendingGroups =
              processData.info.data.fieldGroups
                  .where((g) => g.stepId == pendingStep!.id)
                  .toList();
          final pendingFields = <FieldValueModel>[];
          final pendingKeys = <String>{};
          for (final g in pendingGroups) {
            for (final f in g.fields) {
              // Do NOT skip TEXT_BLOCK — React sends all field types; server may
              // require computed TEXT_BLOCK fields (e.g. IS_BUSINESS_DAY) to be
              // present. Values come from merged (seeded from fieldValues).
              if (pendingKeys.contains(f.key)) continue;
              // React: send ALL fields — no visibility filter.
              // Server handles conditional requirements server-side.
              if (g.groupDuplicate) {
                final raw = merged[f.key] ?? '';
                final parts = raw.split(',');
                final dups =
                    parts
                        .asMap()
                        .entries
                        .where((e) => e.value.isNotEmpty)
                        .map(
                          (e) => DuplicableValue(
                            position: e.key + 1,
                            value: e.value,
                          ),
                        )
                        .toList();
                // Always include — even with empty duplicable_values: [].
                pendingFields.add(
                  FieldValueModel(
                    key: f.key,
                    value: '',
                    duplicableValues: dups,
                  ),
                );
              } else {
                // Send value (empty string if not available) — mirrors React behavior.
                final val = merged[f.key] ?? '';
                pendingFields.add(FieldValueModel(key: f.key, value: val));
              }
              pendingKeys.add(f.key);
            }
          }
          if (pendingFields.isEmpty) continue;

          print('===== CATCH-UP SUBMIT step_id=$pos =====');
          for (final f in pendingFields) {
            print('  ${f.key}: ${f.value}');
          }
          print('=========================================');

          await ref
              .read(processProvider.notifier)
              .next(values: pendingFields, stepPosition: pos);

          if (!mounted) return;

          final catchState = ref.read(processProvider).valueOrNull;

          // Check for early completion during catch-up
          if (catchState?.isComplete == true) {
            await _navigateToCreatedApplication(catchState!.applicationId);
            return;
          }

          // Catch-up continues regardless of whether last_step_id advanced —
          // the server may return 200 with last_step_id unchanged but that is
          // not a reason to block the user (the date-format bug was the real
          // cause of catch-up failures; with that fixed, catch-up should
          // advance normally).
        }
      }
      // ─────────────────────────────────────────────────────────────────────────

      // React: sends step_id = currentStep.number = the step's own position.
      final ok = await ref
          .read(processProvider.notifier)
          .next(values: stepFields, stepPosition: currentStepData.position);

      if (!mounted) return;

      if (ok) {
        final processState = ref.read(processProvider).valueOrNull;

        // If application is complete → refresh list and open the created application
        if (processState?.isComplete == true) {
          if (!mounted) return;
          await _navigateToCreatedApplication(processState!.applicationId);
          return;
        }

        // React: stepper watches firstStepKey = steps[last_step_id].number
        // navigateIfLastStep:true — when the server advances past the final step
        // (no more steps left) we navigate to the created application detail page
        // rather than staying stuck on the last step.
        _advanceStep(processState, currentStepIdx, navigateIfLastStep: true);
      } else {
        final error =
            ref.read(processProvider).valueOrNull?.submitError ?? 'Ошибка';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Ошибка: $error")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ошибка сохранения: $e")));
    }
  }

  /// React equivalent: StepperModule.Provider useEffect watches firstStepKey
  /// (= steps[last_step_id].number) and calls setStep when it changes.
  /// Here we use processState.currentStepIndex (computed from last_step_id via
  /// position matching) as the new step index — falls back to +1 if unchanged.
  void _advanceStep(
    ProcessState? processState,
    int currentStepIdx, {
    bool navigateIfLastStep = false,
  }) {
    if (!mounted) return;
    final serverIdx = processState?.currentStepIndex ?? -1;
    final totalSteps = processState?.sortedSteps.length ?? 0;
    // If the server advanced last_step_id past current, jump to that index;
    // otherwise fall back to currentStepIdx + 1.
    final nextIdx =
        (serverIdx > currentStepIdx) ? serverIdx : currentStepIdx + 1;
    if (nextIdx < totalSteps) {
      ref.read(currentStepProvider.notifier).state = nextIdx;
    } else if (navigateIfLastStep) {
      // We're past the last step and the server accepted the submission —
      // navigate to application detail (same as React navigating on isComplete).
      final appId = processState?.applicationId ?? 0;
      if (appId > 0) _navigateToCreatedApplication(appId);
    }
  }

  Future<void> _navigateToCreatedApplication(int applicationId) async {
    if (!mounted) return;

    // React equivalent:
    //   if (registerId) history.push(`/cabinet/document?document=${registerId}`)
    //   else            history.push(`/cabinet/application?application=${applicationId}`)
    //
    // Check whether the server returned a REGISTER_ID field value, which
    // indicates an auto-generated document was created for this application.
    final processState = ref.read(processProvider).valueOrNull;
    final registerIdStr =
        processState?.fieldValues
            .firstWhere(
              (fv) => fv.key == 'REGISTER_ID',
              orElse: () => FieldValueModel(key: '', value: ''),
            )
            .value ??
        '';
    final hasRegisterId = registerIdStr.isNotEmpty;

    // Always invalidate the applications list so it refreshes when visited.
    ref.invalidate(applicationProvider);

    // If the service auto-generated a document (REGISTER_ID present), also
    // invalidate the documents list so Documents tab shows the new record.
    if (hasRegisterId) {
      ref.invalidate(myDocumentsProvider);
    }

    // Pop StepsPage only (not all the way to root).
    Navigator.of(context).pop();

    // React: if (registerId) history.push(`/cabinet/document?document=${registerId}`)
    //        else            history.push(`/cabinet/application?application=${applicationId}`)
    if (hasRegisterId) {
      final registerId = int.tryParse(registerIdStr) ?? 0;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => MyDocumentDetailPage(
                id: registerId,
                index: 0,
                docModel: MyDocumentsModel(),
                currentLocale: ref.read(localeProvider),
              ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => MyApplicationInReviewDetailPage(
                id: applicationId,
                currentLocale: ref.read(localeProvider),
              ),
        ),
      );
    }
  }
}

class StepContentWidget extends ConsumerStatefulWidget {
  final StepInfo step;
  final List<FieldGroup> groups;
  final AdaptiveSizes size;
  final Locale currentLocale;
  final int docId;
  final int applicationId;
  final List<Requirement> requirements;
  final List<MySpecialization> specializations;
  final List<Value> initialvalues;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> uploadingNotifier;

  const StepContentWidget({
    super.key,
    required this.step,
    required this.groups,
    required this.size,
    required this.currentLocale,
    required this.docId,
    required this.applicationId,
    required this.requirements,
    required this.specializations,
    required this.initialvalues,
    required this.formKey,
    required this.uploadingNotifier,
  });

  @override
  ConsumerState<StepContentWidget> createState() => _StepContentWidgetState();
}

class _StepContentWidgetState extends ConsumerState<StepContentWidget> {
  final _apiService = ProcessApiService();
  int _uploading = 0;

  // Stores per-group duplicable entries: groupKey → [{fieldKey: value}, ...]
  final Map<String, List<Map<String, String>>> _duplicableEntries = {};

  // Tracks which actionKeys are currently being refreshed (for child spinner).
  // Key = field.actionKey of the parent that fired; value = child's choiceOptionsAuto.
  final Set<String> _refreshingDropdowns = {};

  // Tracks fields whose controller text has already been pre-formatted through
  // the mask, so we only do it once per field key (not on every rebuild).
  final Set<String> _maskInitialized = {};

  // Tracks which controllers already have an uppercase listener attached.
  final Set<String> _uppercaseListeners = {};

  bool get isUploading => _uploading > 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final formProv = ref.read(formProviderFamily(widget.docId));

      // Seed FormProvider from server-echoed values (resume / back flow).
      if (widget.initialvalues.isNotEmpty) {
        formProv.initializeFromDocument(widget.initialvalues);
      }
    });
  }

  // ── File upload ───────────────────────────────────────────────────────────

  /// React equivalent: File.tsx upload flow → setFieldValue(name, String(file.id))
  /// [openSource] = true → POST /file/open_source/upload (OPEN_SOURCE_FILE type)
  Future<void> _pickAndUploadFile(
    String fieldKey,
    TextEditingController controller, {
    bool openSource = false,
  }) async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null) return;
    final file = result.files.first;
    if (file.path == null) return;

    setState(() {
      _uploading++;
      controller.text = '⏳ ${file.name}';
    });
    widget.uploadingNotifier.value = true;

    try {
      final FileUploadResult uploaded;
      if (openSource) {
        uploaded = await _apiService.uploadOpenSourceFile(
          applicationId: widget.applicationId,
          file: File(file.path!),
          filename: file.name,
        );
      } else {
        uploaded = await _apiService.uploadFile(
          applicationId: widget.applicationId,
          file: File(file.path!),
          filename: file.name,
        );
      }
      if (!mounted) return;
      setState(() {
        controller.text = file.name;
        _uploading--;
      });
      widget.uploadingNotifier.value = _uploading > 0;
      ref
          .read(formProviderFamily(widget.docId))
          .setValue(fieldKey, uploaded.fileId.toString());
    } catch (e) {
      if (!mounted) return;
      setState(() {
        controller.text = '';
        _uploading--;
      });
      widget.uploadingNotifier.value = _uploading > 0;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка загрузки файла: $e')));
    }
  }

  // ── Single field builder (React: FieldByType.tsx) ────────────────────────

  /// Builds a single form field widget matching the React FieldByType component.
  /// Skips invisible or disabled fields (React: if (field.disabled || !field.visible) return null).
  Widget _buildFormField(
    Field field,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    // Apply runtime overrides from actionEvent (React: actionEventList mapper).
    // The server can change visible/disabled/required dynamically after the
    // user interacts with a parent field (e.g. selecting APPLICANT_CELEBRATION_TYPE
    // shows/hides APPLICANT_QUANTITY_CATTLE).
    // NOTE: cattle fields have field.actionId==null, so we also try field.key as fallback.
    final processSnap = ref.read(processProvider).valueOrNull;
    final override =
        (processSnap?.fieldOverrides[field.actionId]) ??
        (processSnap?.fieldOverrides[field.key]);
    final effectiveVisible = override?.visible ?? field.visible;
    final effectiveRequired = override?.required ?? field.required;

    // React: visible:false → returns null (completely hidden)
    if (!effectiveVisible) return const SizedBox.shrink();
    // React: disabled:true → gray background, still visible but not interactive
    final controller = formProv.getTextController(field.key);

    switch (field.type) {
      case 'INPUT':
        return _buildInput(
          field,
          controller,
          formProv,
          locale,
          size,
          overrideRequired: effectiveRequired,
        );
      case 'TEXT_EDITOR':
      case 'TEXT_AREA':
        return _buildTextArea(
          field,
          controller,
          formProv,
          locale,
          size,
          overrideRequired: effectiveRequired,
        );
      case 'DATE':
      case 'DATE_OF_BIRTH':
      case 'BIRTH_DATE':
        return _buildDate(
          field,
          controller,
          formProv,
          locale,
          size,
          overrideRequired: effectiveRequired,
        );
      case 'DATE_TIME':
        return _buildDateTime(
          field,
          controller,
          formProv,
          locale,
          size,
          overrideRequired: effectiveRequired,
        );
      case 'TIME':
        return _buildTime(
          field,
          controller,
          formProv,
          locale,
          size,
          overrideRequired: effectiveRequired,
        );
      case 'TEXT_BLOCK':
        return _buildTextBlock(field, locale, size);
      case 'FILE':
        return _buildFile(
          field,
          controller,
          formProv,
          locale,
          size,
          openSource: false,
          overrideRequired: effectiveRequired,
        );
      case 'OPEN_SOURCE_FILE':
        return _buildFile(
          field,
          controller,
          formProv,
          locale,
          size,
          openSource: true,
          overrideRequired: effectiveRequired,
        );
      case 'DROP_DOWN':
        return _buildDropDown(field, formProv, locale, size);
      case 'RADIO_BUTTON':
        return _buildRadio(field, formProv, locale, size);
      case 'CHECK_BOX':
        return _buildCheckBox(field, formProv, locale, size);
      case 'SWITCH':
        return _buildSwitch(field, formProv, locale, size);
      default:
        return SizedBox.shrink();
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 12),
      //   child: Text(
      //     'Неизвестный тип: ${field.type}',
      //     style: const TextStyle(color: Colors.red),
      //   ),
      // );
    }
  }

  // ── INPUT ─────────────────────────────────────────────────────────────────

  TextInputType _keyboardTypeFor(String? inputKeyboard) {
    switch (inputKeyboard) {
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'email':
        return TextInputType.emailAddress;
      case 'url':
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  Widget _buildInput(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;
    // Dynamic mask: React uses field.input_mask (e.g. "##########" for TIN)
    // React IMask with unmask:true sends only raw digits; we match that by
    // using eager mode (auto-fills literal prefix like "+992 ") and storing
    // the raw digits via onChanged (controller.text without mask literals).
    List<TextInputFormatter> formatters = [];
    MaskTextInputFormatter? maskFormatter;

    // React uses a dedicated Phone component with mask "## ### ## ##" and
    // prefix "+992". Detect phone fields by: matching that exact mask string,
    // keyboard type hints, or field key containing PHONE/MOBILE/TEL.
    // filter: {'0': RegExp(r'[0-9]')} MUST be specified — without it '0' in
    // the mask template is treated as a literal char, accepting no input.
    final keyUpper = field.key.toUpperCase();
    final isPhoneByMask = field.inputMask == '## ### ## ##';
    final isPhoneByKey =
        field.inputKeyboard == 'phone' ||
        field.inputKeyboard == 'tel' ||
        keyUpper.contains('PHONE') ||
        keyUpper.contains('MOBILE') ||
        keyUpper.contains('TEL');
    final bool isPhoneField = isPhoneByMask || isPhoneByKey;

    if (isPhoneField) {
      // Phone: +992 XX XXX XX XX  (matches React's "+992" prefix + "## ### ## ##")
      maskFormatter = MaskTextInputFormatter(
        mask: '+992 00 000 00 00',
        filter: {'0': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.eager,
      );
      formatters.add(maskFormatter);
    } else if (field.inputMask != null && field.inputMask!.isNotEmpty) {
      // Generic server-defined mask: convert React "#" placeholder → "0"
      final mask = field.inputMask!.replaceAll('#', '0');
      maskFormatter = MaskTextInputFormatter(
        mask: mask,
        filter: {'0': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.eager,
      );
      formatters.add(maskFormatter);
    } else if (field.key == 'APPLICANT_TIN' || field.key == 'TRUSTED_TIN') {
      formatters.add(innFormatter);
    }
    final isCapCharacters = field.inputKeyboard == 'CAP_CHARACTERS';
    if (isCapCharacters && !_uppercaseListeners.contains(field.key)) {
      _uppercaseListeners.add(field.key);
      bool applying = false;
      controller.addListener(() {
        if (applying) return;
        final text = controller.text;
        final upper = text.toUpperCase();
        if (text != upper) {
          applying = true;
          controller.value = controller.value.copyWith(
            text: upper,
            selection: TextSelection.collapsed(offset: upper.length),
          );
          applying = false;
        }
      });
    }
    if (maskFormatter != null &&
        (controller.text.isNotEmpty || isPhoneField) &&
        !_maskInitialized.contains(field.key)) {
      _maskInitialized.add(field.key);
      final captured = maskFormatter;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final rawDigits = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        // For phone: strip leading country code (992) if number is too long
        final digits =
            isPhoneField && rawDigits.startsWith('992') && rawDigits.length > 9
                ? rawDigits.substring(3)
                : rawDigits;
        final newValue = captured.formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: digits),
        );
        if (controller.text != newValue.text) {
          controller.value = newValue;
        }
      });
    }

    // For masked fields, onChanged stores the UNMASKED digits (matches React unmask:true)
    final hasMask = maskFormatter != null;
    final capturedFormatter = maskFormatter;

    return InputTextField(
      isRequired: isRequired,
      isDisabled: field.disabled,
      controller: controller,
      labelText: field.title.getText(locale),
      hintText: field.placeholder.getText(locale),
      readOnly: field.readonly,
      keyboardType: _keyboardTypeFor(field.inputKeyboard),
      inputFormatters: formatters,
      formKey: formProv.getFieldKey(field.key),
      size: size,
      onTap: () {},
      textInputAction: TextInputAction.next,
      textCapitalization:
          isCapCharacters
              ? TextCapitalization.characters
              : TextCapitalization.none,
      autocorrect: !isCapCharacters,
      enableSuggestions: !isCapCharacters,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      onChanged: (value) {
        if (hasMask && capturedFormatter != null) {
          // Store unmasked (raw) digits — matches React IMask unmask:true
          formProv.setValue(field.key, capturedFormatter.getUnmaskedText());
        } else {
          formProv.setValue(field.key, value);
        }
      },
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return "Поле обязательно для заполнения";
        }
        // Validate against UNMASKED digit count for masked fields
        final checkValue =
            hasMask && capturedFormatter != null
                ? capturedFormatter.getUnmaskedText()
                : value ?? '';
        if (checkValue.isNotEmpty) {
          if (field.inputMinLength != null &&
              checkValue.length < field.inputMinLength!) {
            return 'Минимальная длина: ${field.inputMinLength} символов';
          }
          if (field.inputMaxLength != null &&
              checkValue.length > field.inputMaxLength!) {
            return 'Максимальная длина: ${field.inputMaxLength} символов';
          }
        }
        return null;
      },
      // React: ActionInput — any INPUT field with action.key gets a search button.
      // When pressed, fires actionEvent with the current field value, which the
      // server uses to populate child dropdowns (e.g. vehicle list from TIN)
      // and/or auto-fill other fields (brand, year, etc.).
      suffixIcon:
          field.actionKey != null
              ? _refreshingDropdowns.contains(field.actionKey!)
                  ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                  : IconButton(
                    onPressed: () async {
                      // Use unmasked value for masked fields (e.g. TIN digits only)
                      final rawValue =
                          hasMask && capturedFormatter != null
                              ? capturedFormatter.getUnmaskedText()
                              : controller.text.trim();
                      if (rawValue.isEmpty) return;
                      setState(
                        () => _refreshingDropdowns.add(field.actionKey!),
                      );
                      try {
                        final autoFills = await ref
                            .read(processProvider.notifier)
                            .refreshDropDown(
                              actionKey: field.actionKey!,
                              lang: locale.languageCode,
                              fields: [
                                {
                                  'key': field.actionId ?? field.key,
                                  'value': rawValue,
                                },
                              ],
                            );
                        if (!mounted) return;
                        // Map event.actionId → field.key before applying.
                        for (final e in autoFills.entries) {
                          final formKey = _formKeyForActionId(e.key);
                          print(
                            '[autofill/TIN] actionId=${e.key} → formKey=$formKey value=${e.value}',
                          );
                          formProv.setValue(formKey, e.value);
                          formProv.getTextController(formKey).text = e.value;
                        }
                      } finally {
                        if (mounted) {
                          setState(
                            () => _refreshingDropdowns.remove(field.actionKey!),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.search, color: primaryGreenColor),
                  )
              : null,
    );
  }

  // ── TEXT_AREA / TEXT_EDITOR ───────────────────────────────────────────────

  Widget _buildTextArea(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;
    return InputTextField(
      isRequired: isRequired,
      isDisabled: field.disabled,
      onChanged: (value) => formProv.setValue(field.key, value),
      keyboardType: TextInputType.multiline,
      maxLength: 5, // multi-line — React TEXT_AREA has no maxLength restriction
      labelText: field.title.getText(locale),
      hintText: field.placeholder.getText(locale),
      controller: controller,
      readOnly: field.readonly,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Заполните поле';
        }
        return null;
      },
      formKey: formProv.getFieldKey(field.key),
      size: size,
      onTap: () {},
    );
  }

  // ── DATE / DATE_OF_BIRTH / BIRTH_DATE ────────────────────────────────────

  Widget _buildDate(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;
    // React: uses field.date_start / field.date_end for picker range
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);
    try {
      if (field.dateStart.isNotEmpty) {
        firstDate = DateFormat('yyyy-MM-dd').parse(field.dateStart);
      }
    } catch (_) {}
    try {
      if (field.dateEnd.isNotEmpty) {
        lastDate = DateFormat('yyyy-MM-dd').parse(field.dateEnd);
      }
    } catch (_) {}

    final canPick = field.readonly != true && field.disabled != true;

    Future<void> pickDate() async {
      if (!canPick) return;
      final now = DateTime.now();
      final initial =
          now.isAfter(firstDate) && now.isBefore(lastDate) ? now : firstDate;
      final datetime = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initial,
      );
      if (datetime != null) {
        final picked = DateFormat('dd.MM.yyyy').format(datetime);
        formProv.setValue(field.key, picked);
        controller.text = picked;
      }
    }

    return InputTextField(
      isRequired: isRequired,
      isDisabled: field.disabled,
      onTap: canPick ? pickDate : null,
      size: size,
      formKey: formProv.getFieldKey(field.key),
      onChanged: (value) => formProv.setValue(field.key, value),
      labelText: field.title.getText(locale),
      readOnly: true,
      hintText:
          field.placeholder.getText(locale).isNotEmpty
              ? field.placeholder.getText(locale)
              : 'дд.мм.гггг',
      controller: controller,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Поле обязательно для заполнения';
        }
        return null;
      },
      suffixIcon: IconButton(
        onPressed: canPick ? pickDate : null,
        icon: Icon(
          Icons.calendar_month,
          color: canPick ? primaryButtonColor : Colors.grey,
        ),
      ),
    );
  }

  // ── DATE_TIME ─────────────────────────────────────────────────────────────

  Widget _buildDateTime(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;

    Future<void> pickDateTime() async {
      final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );
      if (date == null || !mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder:
            (ctx, child) => MediaQuery(
              data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            ),
      );
      if (time == null) return;
      final formatted =
          '${DateFormat('dd-MM-yyyy').format(date)} '
          '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}';
      formProv.setValue(field.key, formatted);
      controller.text = formatted;
    }

    return InputTextField(
      isRequired: isRequired,
      isDisabled: field.disabled,
      onTap: pickDateTime,
      size: size,
      formKey: formProv.getFieldKey(field.key),
      onChanged: (value) => formProv.setValue(field.key, value),
      labelText: field.title.getText(locale),
      readOnly: true,
      hintText:
          field.placeholder.getText(locale).isNotEmpty
              ? field.placeholder.getText(locale)
              : 'дд.мм.гггг чч:мм',
      controller: controller,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Поле обязательно для заполнения';
        }
        return null;
      },
      suffixIcon: IconButton(
        onPressed: pickDateTime,
        icon: Icon(Icons.calendar_month, color: primaryButtonColor),
      ),
    );
  }

  // ── TIME ──────────────────────────────────────────────────────────────────

  Widget _buildTime(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;

    Future<void> pickTime() async {
      final initial = () {
        final parts = controller.text.split(':');
        if (parts.length == 2) {
          final h = int.tryParse(parts[0]);
          final m = int.tryParse(parts[1]);
          if (h != null && m != null) return TimeOfDay(hour: h, minute: m);
        }
        return TimeOfDay.now();
      }();
      final picked = await showTimePicker(
        context: context,
        initialTime: initial,
        builder:
            (ctx, child) => MediaQuery(
              data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            ),
      );
      if (picked != null) {
        final formatted =
            '${picked.hour.toString().padLeft(2, '0')}:'
            '${picked.minute.toString().padLeft(2, '0')}';
        controller.text = formatted;
        formProv.setValue(field.key, formatted);
      }
    }

    return InputTextField(
      onChanged: (value) => formProv.setValue(field.key, value),
      labelText: field.title.getText(locale),
      hintText: 'чч:мм',
      controller: controller,
      isRequired: isRequired,
      isDisabled: field.disabled,
      readOnly: true,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Заполните поле';
        }
        return null;
      },
      formKey: formProv.getFieldKey(field.key),
      size: size,
      suffixIcon: IconButton(
        icon: const Icon(Icons.access_time, color: primaryButtonColor),
        onPressed: pickTime,
      ),
      onTap: pickTime,
    );
  }

  // ── TEXT_BLOCK ────────────────────────────────────────────────────────────

  Widget _buildTextBlock(Field field, Locale locale, AdaptiveSizes size) {
    final bgColor =
        field.textBlockColor == 'ORANGE'
            ? const Color(0xFFffefe3)
            : field.textBlockColor == 'BLUE'
            ? const Color(0xFFeaf5ff)
            : const Color(0xFFeafff3);
    final titleColor =
        field.textBlockColor == 'ORANGE'
            ? const Color(0xFFF79B58)
            : field.textBlockColor == 'BLUE'
            ? const Color(0xFF4ca2f2)
            : primaryButtonColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.title.getText(locale),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              field.textBlockContent.getText(locale),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // ── FILE / OPEN_SOURCE_FILE ───────────────────────────────────────────────

  Widget _buildFile(
    Field field,
    TextEditingController controller,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    required bool openSource,
    bool? overrideRequired,
  }) {
    final isRequired = overrideRequired ?? field.required;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InputTextField(
        onChanged: (value) {},
        onTap:
            () async => _pickAndUploadFile(
              field.key,
              controller,
              openSource: openSource,
            ),
        labelText: field.title.getText(locale),
        hintText:
            field.placeholder.getText(locale).isNotEmpty
                ? field.placeholder.getText(locale)
                : 'Выберите файл',
        controller: controller,
        readOnly: true,
        isRequired: isRequired,
        isDisabled: field.disabled,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Поле обязательно для заполнения';
          }
          return null;
        },
        formKey: formProv.getFieldKey(field.key),
        size: size,
        suffixIcon:
            controller.text.trim().isEmpty
                ? IconButton(
                  onPressed:
                      () async => _pickAndUploadFile(
                        field.key,
                        controller,
                        openSource: openSource,
                      ),
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: primaryButtonColor,
                  ),
                )
                : IconButton(
                  onPressed: () {
                    setState(() => controller.text = '');
                    formProv.setValue(field.key, '');
                  },
                  icon: Icon(Icons.delete_outline, color: primaryButtonColor),
                ),
      ),
    );
  }

  // ── DROP_DOWN ─────────────────────────────────────────────────────────────
  //
  // Architecture (matches React ActionSelect):
  //   • All options live in processState.dropDownOptions[field.actionId].
  //   • On initial load, _loadDropDownOptions pre-fills all auto-load dropdowns.
  //   • When a parent dropdown changes (field.actionKey != null), we call
  //     refreshDropDown which fires POST /action and updates dropDownOptions for
  //     child dropdowns — no global shared state needed.
  //   • _refreshingDropdowns tracks which actionKeys are currently loading so
  //     the child dropdown can show a spinner.

  /// Maps an actionEvent response's [actionId] to the field.key used by
  /// FormProvider controllers. React: field entities are indexed by actionId
  /// in Redux, but the form submission key is field.key — these can differ.
  /// Falls back to [actionId] itself when no matching field is found.
  String _formKeyForActionId(String actionId) {
    final info = ref.read(processProvider).valueOrNull?.info;
    if (info == null) return actionId;
    for (final group in info.data.fieldGroups) {
      for (final f in group.fields) {
        if (f.actionId == actionId) return f.key;
      }
    }
    return actionId;
  }

  /// Fires actionEvent for [field.actionKey], updates child dropdown options
  /// in processState, and applies any auto-fill values to FormProvider.
  Future<void> _onDropdownParentChanged(
    Field field,
    String newValue,
    FormProvider formProv,
    Locale locale,
  ) async {
    if (field.actionKey == null) return;
    setState(() => _refreshingDropdowns.add(field.actionKey!));
    try {
      final autoFills = await ref
          .read(processProvider.notifier)
          .refreshDropDown(
            actionKey: field.actionKey!,
            lang: locale.languageCode,
            fields: [
              {'key': field.actionId ?? field.key, 'value': newValue},
            ],
          );
      if (!mounted) return;
      // refreshDropDown returns both top-level 'values' and per-event 'value'.
      // Map event.actionId → field.key (they can differ) before applying.
      for (final entry in autoFills.entries) {
        final formKey = _formKeyForActionId(entry.key);
        print(
          '[autofill] actionId=${entry.key} → formKey=$formKey value=${entry.value}',
        );
        formProv.setValue(formKey, entry.value);
        formProv.getTextController(formKey).text = entry.value;
      }
    } finally {
      if (mounted)
        setState(() => _refreshingDropdowns.remove(field.actionKey!));
    }
  }

  Widget _buildDropDown(
    Field field,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    final processAsync = ref.watch(processProvider);

    return processAsync.when(
      loading: () => buildDropdownSkeleton(field, isLoading: true),
      error: (err, _) => buildDropdownSkeleton(field, error: err.toString()),
      data: (processState) {
        // Options: static from schema OR dynamically loaded via actionEvent
        final List<ChoiceOption> options =
            field.choiceOptions.isNotEmpty
                ? field.choiceOptions
                : (processState.dropDownOptions[field.actionId] ?? []);

        // Show spinner in dropdown while parent is refreshing this field's options
        final bool isRefreshing =
            field.choiceOptionsAuto != null &&
            _refreshingDropdowns.contains(field.choiceOptionsAuto);

        // Validate stored value still exists in current option list
        String? selectedValue = formProv.getValue(field.key) as String?;
        if (selectedValue != null &&
            options.isNotEmpty &&
            !options.any((o) => o.code == selectedValue)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) formProv.setValue(field.key, null);
          });
          selectedValue = null;
        }

        return _buildDropdown(
          field: field,
          options: options,
          selectedValue: selectedValue,
          isLoading: isRefreshing,
          locale: locale,
          size: size,
          isReadonly: field.readonly,
          isDisabled: field.disabled,
          onChanged: (newValue) {
            if (newValue == null) return;
            formProv.setValue(field.key, newValue);
            // Fire cascaded refresh if this field has dependents
            if (field.actionKey != null) {
              _onDropdownParentChanged(field, newValue, formProv, locale);
            }
          },
        );
      },
    );
  }

  // ── RADIO_BUTTON ──────────────────────────────────────────────────────────

  Widget _buildRadio(
    Field field,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    return FormField<ChoiceOption>(
      initialValue: formProv.getRadioChoiceValue(
        field.key,
        field.choiceOptions,
      ),
      validator: (value) {
        if (field.required == true && value == null) {
          return 'Поле обязательное для заполнения';
        }
        return null;
      },
      builder:
          (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButton(
                size: size,
                options: field.choiceOptions,
                choice: state.value,
                onChanged: (value) {
                  if (value is ChoiceOption) {
                    state.didChange(value);
                    formProv.setValue(field.key, value.code);
                  }
                },
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
    );
  }

  // ── CHECK_BOX ─────────────────────────────────────────────────────────────

  /// React: CHECK_BOX stores selected option codes as comma-separated string.
  Widget _buildCheckBox(
    Field field,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    final storedValue = formProv.getValue(field.key)?.toString() ?? '';
    // React: CHECK_BOX uses colon ':' as delimiter ("code1:code2:code3")
    final selectedCodes =
        storedValue.isEmpty ? <String>{} : storedValue.split(':').toSet();

    return StatefulBuilder(
      builder: (ctx, setLocal) {
        final Color labelColor =
            field.disabled ? Colors.grey : primaryButtonColor;
        return Container(
          decoration:
              field.disabled
                  ? BoxDecoration(
                    color: const Color(0xFFf6f6f6),
                    borderRadius: BorderRadius.circular(8),
                  )
                  : null,
          padding: field.disabled ? const EdgeInsets.all(8) : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (field.required)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: field.title.getText(locale),
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: labelColor, fontSize: 15),
                      ),
                    ],
                  ),
                )
              else
                textWithH1Style(
                  field.title.getText(locale),
                  fontsize: 15,
                  color: labelColor,
                ),
              const SizedBox(height: 8),
              ...field.choiceOptions.map((option) {
                final isChecked = selectedCodes.contains(option.code ?? '');
                return CheckboxListTile(
                  activeColor: primaryButtonColor,
                  value: isChecked,
                  title: Text(option.name.getText(locale)),
                  onChanged:
                      field.disabled
                          ? null
                          : (checked) {
                            setLocal(() {
                              if (checked == true) {
                                selectedCodes.add(option.code ?? '');
                              } else {
                                selectedCodes.remove(option.code ?? '');
                              }
                              // React: colon-delimited ("code1:code2:code3")
                              formProv.setValue(
                                field.key,
                                selectedCodes.join(':'),
                              );
                            });
                          },
                  contentPadding: EdgeInsets.zero,
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ── SWITCH ────────────────────────────────────────────────────────────────

  Widget _buildSwitch(
    Field field,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    final switchValue = ref.watch(
      formProviderFamily(
        widget.docId,
      ).select((p) => p.getValue(field.key) ?? false),
    );
    return SwitchWidget(
      content: field.title.getText(locale),
      onToggle: (value) => formProv.setValue(field.key, value),
      size: size,
      isOn: switchValue == true,
      validator: (value) {
        if (field.required && value != true) {
          return 'Поле обязательно для заполнения';
        }
        return null;
      },
    );
  }

  // ── Duplicable group ──────────────────────────────────────────────────────

  Widget _buildDuplicableGroup(
    FieldGroup group,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size,
  ) {
    final entries = _duplicableEntries[group.key] ?? [];
    // React: shows first 3 visible non-TEXT_BLOCK fields as table columns
    final tableFields =
        group.fields
            .where((f) => f.type != 'TEXT_BLOCK' && f.visible)
            .take(3)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table (shown when there are entries)
        if (entries.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Table(
              border: TableBorder.all(
                color: greyTextFBorderColor,
                borderRadius: BorderRadius.circular(8),
              ),
              columnWidths: {
                for (int i = 0; i < tableFields.length; i++)
                  i: const FlexColumnWidth(),
                tableFields.length: const FixedColumnWidth(72),
              },
              children: [
                // Header row
                TableRow(
                  decoration: const BoxDecoration(color: Color(0xFFf5f5f5)),
                  children: [
                    ...tableFields.map(
                      (f) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Text(
                          f.title.getText(locale),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Text(
                        'Действия',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                // Data rows
                ...entries.asMap().entries.map((e) {
                  final idx = e.key;
                  final entry = e.value;
                  return TableRow(
                    decoration: BoxDecoration(
                      color: idx.isOdd ? const Color(0xFFfafafa) : Colors.white,
                    ),
                    children: [
                      ...tableFields.map(
                        (f) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            entry[f.key] ?? '',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      // Actions: edit + delete
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap:
                                () => _showDuplicableDialog(
                                  group,
                                  formProv,
                                  locale,
                                  size,
                                  editIndex: idx,
                                ),
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: primaryButtonColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _duplicableEntries[group.key]!.removeAt(idx);
                                _syncDuplicableToProvider(group, formProv);
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        const SizedBox(height: 8),
        // Add button — React: "+ Добавить" button at bottom of group
        GestureDetector(
          onTap: () => _showDuplicableDialog(group, formProv, locale, size),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryGreenColor),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: primaryGreenColor),
              ),
              SizedBox(width: size.otstup10),
              textWithH1Style(
                'Добавить',
                color: primaryButtonColor,
                fontsize: 17,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _syncDuplicableToProvider(FieldGroup group, FormProvider formProv) {
    final entries = _duplicableEntries[group.key] ?? [];
    for (final field in group.fields) {
      if (field.type == 'TEXT_BLOCK') continue;
      // Store as comma-separated so _onContinuePressed can read it
      final vals = entries.map((e) => e[field.key] ?? '').join(',');
      formProv.setValue(field.key, vals);
    }
  }

  void _showDuplicableDialog(
    FieldGroup group,
    FormProvider formProv,
    Locale locale,
    AdaptiveSizes size, {
    int? editIndex,
  }) {
    final existingEntry =
        editIndex != null
            ? (_duplicableEntries[group.key]?[editIndex] ?? <String, String>{})
            : <String, String>{};

    // selectedValues: what gets saved to _duplicableEntries (text, date, fileId, code…)
    final selectedValues = <String, String>{
      for (final f in group.fields.where((f) => f.type != 'TEXT_BLOCK'))
        f.key: existingEntry[f.key] ?? '',
    };
    // controllers for text-based fields so user sees what they typed
    final dialogCtrls = <String, TextEditingController>{
      for (final f in group.fields.where((f) => f.type != 'TEXT_BLOCK'))
        f.key: TextEditingController(text: existingEntry[f.key] ?? ''),
    };
    // Display names for file fields (shows filename; value stores fileId)
    final fileDisplayNames = <String, String>{};

    // Tracks validation: fieldKey → error message
    final errors = <String, String?>{};

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => StatefulBuilder(
            builder: (ctx, setDialogState) {
              // ── Per-field widget builder ──────────────────────────────────────
              Widget buildField(Field f) {
                final label = f.title.getText(locale);
                final hint = f.placeholder.getText(locale);
                final isRequired = f.required;
                final currentValue = selectedValues[f.key] ?? '';
                final error = errors[f.key];

                switch (f.type) {
                  // ── Date ─────────────────────────────────────────────────────
                  case 'DATE':
                  case 'DATE_OF_BIRTH':
                  case 'BIRTH_DATE':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextFormField(
                        controller: dialogCtrls[f.key],
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: label + (isRequired ? ' *' : ''),
                          hintText: hint.isNotEmpty ? hint : 'дд.мм.гггг',
                          errorText: error,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryButtonColor),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_month,
                              color: primaryButtonColor,
                            ),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: ctx,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                final formatted = DateFormat(
                                  'dd.MM.yyyy',
                                ).format(picked);
                                setDialogState(() {
                                  selectedValues[f.key] = formatted;
                                  dialogCtrls[f.key]!.text = formatted;
                                  errors.remove(f.key);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    );

                  // ── Time ─────────────────────────────────────────────────────
                  case 'TIME':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextFormField(
                        controller: dialogCtrls[f.key],
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: label + (isRequired ? ' *' : ''),
                          hintText: hint.isNotEmpty ? hint : 'чч:мм',
                          errorText: error,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryButtonColor),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time,
                              color: primaryButtonColor,
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: ctx,
                                initialTime: TimeOfDay.now(),
                                builder:
                                    (c, child) => MediaQuery(
                                      data: MediaQuery.of(
                                        c,
                                      ).copyWith(alwaysUse24HourFormat: true),
                                      child: child!,
                                    ),
                              );
                              if (picked != null) {
                                final formatted =
                                    '${picked.hour.toString().padLeft(2, '0')}:'
                                    '${picked.minute.toString().padLeft(2, '0')}';
                                setDialogState(() {
                                  selectedValues[f.key] = formatted;
                                  dialogCtrls[f.key]!.text = formatted;
                                  errors.remove(f.key);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    );

                  // ── File / Open-source file ───────────────────────────────────
                  case 'FILE':
                  case 'OPEN_SOURCE_FILE':
                    final displayName =
                        fileDisplayNames[f.key] ??
                        (currentValue.isNotEmpty
                            ? 'Файл загружен (id: $currentValue)'
                            : '');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label + (isRequired ? ' *' : ''),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          error != null
                                              ? Colors.red
                                              : greyTextFBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    displayName.isNotEmpty
                                        ? displayName
                                        : hint.isNotEmpty
                                        ? hint
                                        : 'Выберите файл',
                                    style: TextStyle(
                                      color:
                                          displayName.isNotEmpty
                                              ? Colors.black87
                                              : Colors.grey,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  currentValue.isNotEmpty
                                      ? Icons.delete_outline
                                      : Icons.file_download_outlined,
                                  color: primaryButtonColor,
                                ),
                                onPressed: () async {
                                  if (currentValue.isNotEmpty) {
                                    setDialogState(() {
                                      selectedValues[f.key] = '';
                                      fileDisplayNames[f.key] = '';
                                    });
                                    return;
                                  }
                                  final result = await FilePicker.platform
                                      .pickFiles(withData: true);
                                  if (result == null || result.files.isEmpty)
                                    return;
                                  final file = result.files.first;
                                  if (file.path == null) return;
                                  setDialogState(
                                    () =>
                                        fileDisplayNames[f.key] =
                                            '⏳ ${file.name}',
                                  );
                                  try {
                                    final uploaded =
                                        f.type == 'OPEN_SOURCE_FILE'
                                            ? await _apiService
                                                .uploadOpenSourceFile(
                                                  applicationId:
                                                      widget.applicationId,
                                                  file: File(file.path!),
                                                  filename: file.name,
                                                )
                                            : await _apiService.uploadFile(
                                              applicationId:
                                                  widget.applicationId,
                                              file: File(file.path!),
                                              filename: file.name,
                                            );
                                    // Dialog may have been dismissed during upload
                                    if (!ctx.mounted) return;
                                    setDialogState(() {
                                      selectedValues[f.key] =
                                          uploaded.fileId.toString();
                                      fileDisplayNames[f.key] = file.name;
                                      errors.remove(f.key);
                                    });
                                  } catch (e) {
                                    if (!ctx.mounted) return;
                                    setDialogState(
                                      () => fileDisplayNames[f.key] = '',
                                    );
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Ошибка загрузки: $e'),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          if (error != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );

                  // ── Dropdown ─────────────────────────────────────────────────
                  case 'DROP_DOWN':
                    final opts = f.choiceOptions;
                    final selectedCode =
                        currentValue.isNotEmpty &&
                                opts.any((o) => o.code == currentValue)
                            ? currentValue
                            : null;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: DropdownButtonFormField<String>(
                        initialValue: selectedCode,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: label + (isRequired ? ' *' : ''),
                          errorText: error,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryButtonColor),
                          ),
                        ),
                        items:
                            opts
                                .map(
                                  (o) => DropdownMenuItem(
                                    value: o.code,
                                    child: SizedBox(
                                      width: size.screenWidth * 0.5,
                                      child: Text(
                                        o.name.getText(locale),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          setDialogState(() {
                            selectedValues[f.key] = val;
                            errors.remove(f.key);
                          });
                        },
                      ),
                    );

                  // ── Radio button ─────────────────────────────────────────────
                  case 'RADIO_BUTTON':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label + (isRequired ? ' *' : ''),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          if (error != null)
                            Text(
                              error,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ...f.choiceOptions.map(
                            (o) => RadioListTile<String>(
                              title: Text(o.name.getText(locale)),
                              value: o.code ?? '',
                              groupValue: currentValue,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (val) {
                                if (val == null) return;
                                setDialogState(() {
                                  selectedValues[f.key] = val;
                                  errors.remove(f.key);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );

                  // ── Switch ───────────────────────────────────────────────────
                  case 'SWITCH':
                    final isOn = currentValue == 'true' || currentValue == '1';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              label,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Switch(
                            value: isOn,
                            activeThumbColor: primaryButtonColor,
                            onChanged:
                                (val) => setDialogState(
                                  () => selectedValues[f.key] = val.toString(),
                                ),
                          ),
                        ],
                      ),
                    );

                  // ── Default: INPUT / TEXT_AREA ────────────────────────────────
                  default:
                    List<TextInputFormatter> fmts = [];
                    if (f.type == 'INPUT' &&
                        f.inputMask != null &&
                        f.inputMask!.isNotEmpty) {
                      fmts.add(
                        MaskTextInputFormatter(
                          mask: f.inputMask!.replaceAll('#', '0'),
                          filter: {'0': RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.eager,
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: dialogCtrls[f.key],
                        inputFormatters: fmts,
                        keyboardType:
                            f.inputKeyboard == 'number'
                                ? TextInputType.number
                                : f.inputKeyboard == 'phone'
                                ? TextInputType.phone
                                : f.type == 'TEXT_AREA' ||
                                    f.type == 'TEXT_EDITOR'
                                ? TextInputType.multiline
                                : TextInputType.text,
                        maxLines:
                            f.type == 'TEXT_AREA' || f.type == 'TEXT_EDITOR'
                                ? 3
                                : 1,
                        decoration: InputDecoration(
                          labelText: label + (isRequired ? ' *' : ''),
                          hintText: hint,
                          errorText: error,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryButtonColor),
                          ),
                        ),
                        onChanged: (val) {
                          setDialogState(() {
                            selectedValues[f.key] = val;
                            if (val.isNotEmpty) errors.remove(f.key);
                          });
                        },
                      ),
                    );
                }
              }

              // ── Validate all required fields ─────────────────────────────────
              bool validate() {
                bool ok = true;
                for (final f in group.fields.where(
                  (f) => f.required && f.type != 'TEXT_BLOCK',
                )) {
                  final val = selectedValues[f.key] ?? '';
                  if (val.trim().isEmpty) {
                    errors[f.key] = 'Поле обязательно для заполнения';
                    ok = false;
                  }
                }
                return ok;
              }

              return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                contentPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  editIndex != null
                      ? 'Изменить запись'
                      : group.title.getText(locale),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          group.fields
                              .where((f) => f.type != 'TEXT_BLOCK' && f.visible)
                              .map(buildField)
                              .toList(),
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      My_Button(
                        size: size,
                        backgroundColor: Colors.white,
                        borderColor: primaryGreenColor,
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: textWithH1Style(
                          'Отмена',
                          color: primaryGreenColor,
                          fontsize: 15,
                        ),
                      ),
                      My_Button(
                        size: size,
                        backgroundColor: primaryGreenColor,
                        borderColor: primaryButtonColor,
                        onPressed: () {
                          if (!validate()) {
                            setDialogState(() {}); // redraw to show errors
                            return;
                          }
                          final entry = Map<String, String>.from(
                            selectedValues,
                          );
                          setState(() {
                            if (editIndex != null) {
                              _duplicableEntries[group.key]![editIndex] = entry;
                            } else {
                              _duplicableEntries
                                  .putIfAbsent(group.key, () => [])
                                  .add(entry);
                            }
                            _syncDuplicableToProvider(group, formProv);
                          });
                          Navigator.of(ctx).pop();
                        },
                        child: textWithH1Style(
                          'Сохранить',
                          color: Colors.white,
                          fontsize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final formProvRead = ref.read(formProviderFamily(widget.docId));
    final locale = ref.watch(localeProvider);
    final size = AdaptiveSizes(context);

    // ── FORM step ────────────────────────────────────────────────────────
    if (widget.step.type == 'FORM') {
      return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              widget.groups.map((group) {
                // Sort fields by position
                final sortedFields = List<Field>.from(group.fields)
                  ..sort((a, b) => a.position.compareTo(b.position));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      group.title.getText(locale),
                      textAlign: TextAlign.start,
                      fontsize: 17,
                    ),
                    SizedBox(height: size.otstup15),
                    if (!group.groupDuplicate)
                      Column(
                        children:
                            sortedFields
                                .map(
                                  (f) => _buildFormField(
                                    f,
                                    formProvRead,
                                    locale,
                                    size,
                                  ),
                                )
                                .toList(),
                      )
                    else
                      _buildDuplicableGroup(group, formProvRead, locale, size),
                    SizedBox(height: size.otstup10),
                  ],
                );
              }).toList(),
        ),
      );
    }

    // ── PAYMENT step ─────────────────────────────────────────────────────
    if (widget.step.type == 'PAYMENT') {
      final processData = ref.watch(processProvider).valueOrNull;
      return _buildPaymentWidget(processData?.fieldValues ?? [], size);
    }

    // ── SPECIALIZATION step ───────────────────────────────────────────────
    if (widget.step.type == 'SPECIALIZATION') {
      return _buildSpecializationStep(locale, size);
    }

    // ── REQUIREMENTS / STATUS / other steps ──────────────────────────────
    return RequirementStep(
      stepRequirement: widget.requirements,
      documentId: widget.docId,
    );
  }

  Widget _buildSpecializationStep(Locale locale, AdaptiveSizes size) {
    final items = widget.specializations;

    if (items.isEmpty) {
      return Center(
        child: Text(
          'Нет специализаций',
          style: TextStyle(color: Colors.grey[500], fontSize: 14),
        ),
      );
    }

    return Consumer(
      builder: (context, ref, _) {
        final fp = ref.watch(formProviderFamily(widget.docId));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              items.map((spec) {
                final key = spec.id.toString();
                final isChecked = fp.getValue(key) == true;
                return Container(
                  margin: EdgeInsets.only(bottom: size.otstup10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFf7f7f7),
                  ),
                  child: CheckboxListTile(
                    activeColor: const Color(0xFF26AC71),
                    value: isChecked,
                    onChanged: (val) {
                      if (val != null) {
                        fp.setValue(key, val);
                      }
                    },
                    title: Text(
                      spec.name.getText(locale),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle:
                        spec.description.getText(locale).isNotEmpty
                            ? Text(
                              spec.description.getText(locale),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                            : null,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.otstup10,
                      vertical: size.otstup5,
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  // ── Payment widget (reads invoice data directly from processData.fieldValues) ─

  Widget _buildPaymentWidget(
    List<FieldValueModel> fieldValues,
    AdaptiveSizes size,
  ) {
    String fv(String key) =>
        fieldValues
            .firstWhere(
              (f) => f.key == key,
              orElse: () => FieldValueModel(key: key, value: ''),
            )
            .value;

    final serial = fv('INVOICE_SERIAL');
    final amount = fv('INVOICE_AMOUNT');
    final amountOnline = fv('INVOICE_AMOUNT_ONLINE');
    final status = fv('INVOICE_STATUS');
    final issueDate = fv('INVOICE_ISSUE_DATE');

    final isNotPaid =
        status.toUpperCase() == 'OPEN' || status.toUpperCase() == 'ОПЛАЧЕНО';

    // Build the amount display: prefer online amount; show both if different.
    final String amountDisplay;
    if (amount.isNotEmpty &&
        amountOnline.isNotEmpty &&
        amount != amountOnline) {
      amountDisplay = '$amount / $amountOnline (онлайн)';
    } else if (amountOnline.isNotEmpty) {
      amountDisplay = amountOnline;
    } else if (amount.isNotEmpty) {
      amountDisplay = amount;
    } else {
      amountDisplay = '—';
    }

    final card = Container(
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
            // ── Invoice header ────────────────────────────────────────────
            if (serial.isNotEmpty) ...[
              Center(
                child: textWithH2BlackStyle(
                  'Инвойс № $serial',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.otstup10),
              Divider(color: greyTextFBorderColor),
            ],

            // ── Fields ───────────────────────────────────────────────────
            _paymentRow('Номер заявки', widget.applicationId.toString(), size),
            Divider(color: greyTextFBorderColor),

            if (issueDate.isNotEmpty) ...[
              _paymentRow('Дата', issueDate, size),
              Divider(color: greyTextFBorderColor),
            ],

            _paymentRow('Сумма оплаты', amountDisplay, size),
            Divider(color: greyTextFBorderColor),

            // ── Status ───────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWithH1Style(
                  'Статус:',
                  fontW: FontWeight.normal,
                  fontsize: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isNotPaid
                            ? const Color(0xFFFFF3E0)
                            : const Color(0xFFEBFFF3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isNotPaid ? 'Не оплачено' : 'Оплачено',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isNotPaid
                              ? const Color(0xFFE79800)
                              : const Color(0xFF26AC71),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return card;
  }

  Widget _paymentRow(String label, String value, AdaptiveSizes size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWithH1Style('$label:', fontW: FontWeight.normal, fontsize: 16),
          const SizedBox(width: 8),
          Flexible(child: textWithH2BlackStyle(value, fontSize: 16)),
        ],
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final AdaptiveSizes size;
  const PaymentCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

Widget _buildDropdown({
  required Field field,
  required List<ChoiceOption> options,
  required void Function(String?) onChanged,
  required String? selectedValue,
  required AdaptiveSizes size,
  bool isLoading = false,
  bool isReadonly = false,
  bool isDisabled = false,
  Locale? locale,
}) {
  final bool valueIsValid =
      selectedValue == null || options.any((opt) => opt.code == selectedValue);
  final effectiveValue = valueIsValid ? selectedValue : null;
  final bool isEmpty = options.isEmpty && !isLoading;
  final bool notInteractive = isLoading || isEmpty || isReadonly || isDisabled;

  // React: readonly → yellow #fffae7 + orange border; disabled → gray #f6f6f6
  final Color? fillColor =
      isDisabled
          ? const Color(0xFFf6f6f6)
          : isReadonly
          ? const Color(0xFFfffae7)
          : null;
  final Color borderColor =
      isReadonly && !isDisabled ? const Color(0xFFf5a623) : Colors.grey[400]!;
  final Color labelColor = isDisabled ? Colors.grey : primaryButtonColor;

  final String titleText =
      locale != null
          ? field.title.getText(locale)
          : (field.title.ru ?? field.title.en ?? '');
  final String hintText =
      locale != null
          ? (field.placeholder.getText(locale).isNotEmpty
              ? field.placeholder.getText(locale)
              : 'Выберите значение')
          : (field.placeholder.ru ?? 'Выберите значение');

  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: titleText,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (field.required == true)
                TextSpan(
                  text: '* ',
                  style: TextStyle(color: labelColor, fontSize: 16),
                ),
            ],
          ),
        ),
        const SizedBox(height: 9),

        DropdownButtonFormField2<String>(
          isExpanded: true,
          // Show spinner instead of arrow while child options are loading
          iconStyleData:
              isLoading
                  ? const IconStyleData(
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryButtonColor,
                      ),
                    ),
                  )
                  : const IconStyleData(icon: Icon(Icons.arrow_drop_down)),
          value: effectiveValue,
          hint: Text(
            isLoading ? 'Загрузка...' : hintText,
            overflow: TextOverflow.ellipsis,
          ),
          items:
              isEmpty
                  ? [
                    const DropdownMenuItem<String>(
                      value: null,
                      enabled: false,
                      child: Text(
                        'Список пуст',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ]
                  : options.map((option) {
                    final label =
                        locale != null
                            ? option.name.getText(locale)
                            : (option.name.ru ??
                                option.name.en ??
                                option.code ??
                                '');
                    return DropdownMenuItem<String>(
                      value: option.code,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.otstup10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: const TextStyle(
                                height: 1.1,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
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
              final label =
                  locale != null
                      ? option.name.getText(locale)
                      : (option.name.ru ?? option.name.en ?? option.code ?? '');
              return Text(
                label,
                style: const TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }).toList();
          },

          onChanged: notInteractive ? null : onChanged,
          validator: (value) {
            if (field.required == true && (value == null || value.isEmpty)) {
              return 'Поле обязательно для заполнения';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0, right: 8),
            filled: fillColor != null,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor, width: 2),
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
        ),
      ],
    ),
  );
}

// class FontSettingContainer extends StatelessWidget {
//   const FontSettingContainer({super.key, required this.size});

//   final AdaptiveSizes size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: greyBorderColor),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.otstup5,
//           vertical: size.otstup5,
//         ),
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: greyBorderColor),
//                 shape: BoxShape.circle,
//                 color: Color(0xFFEBFFF3),
//               ),
//               child: Icon(Icons.add, color: primaryGreenColor),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.otstup15),
//               child: Text("Aaa", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: greyBorderColor),
//                 shape: BoxShape.circle,
//                 color: Color(0xFFEBFFF3),
//               ),
//               child: Icon(Icons.remove, color: primaryGreenColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double? width;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Key? formKey;
  final AdaptiveSizes size;
  final void Function()? onTap;
  final int maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? isFocused;
  final bool? readOnly;
  final bool? isRequired;
  final bool? isDisabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.width,
    required this.controller,
    this.onFieldSubmitted,
    required this.onChanged,
    required this.validator,
    this.suffixIcon,
    required this.formKey,
    required this.size,
    required this.onTap,
    this.maxLength = 1,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.isFocused,
    this.readOnly,
    this.isRequired,
    this.isDisabled,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
  });

  @override
  Widget build(BuildContext context) {
    // React: readonly → yellow #fffae7 bg + orange border
    // React: disabled → gray #f6f6f6 bg, not interactive
    final bool effectiveReadOnly = (readOnly ?? false) || (isDisabled ?? false);
    final Color? fillColor =
        (isDisabled == true)
            ? const Color(0xFFf6f6f6)
            : (readOnly == true)
            ? const Color(0xFFfffae7)
            : null;
    final Color borderColor =
        (readOnly == true && isDisabled != true)
            ? const Color(0xFFf5a623) // orange for readonly
            : greyTextFBorderColor;
    final Color labelColor =
        (isDisabled == true) ? Colors.grey : primaryButtonColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: isRequired == true ? '* ' : '',
                style: TextStyle(color: labelColor, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            key: formKey,
            width: width ?? double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.otstup10),
              child: TextFormField(
                inputFormatters: inputFormatters,
                readOnly: effectiveReadOnly,
                showCursor: isFocused,
                focusNode: focusNode,
                cursorOpacityAnimates: false,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization,
                autocorrect: autocorrect,
                enableSuggestions: enableSuggestions,
                textInputAction: textInputAction ?? TextInputAction.next,
                maxLines: maxLength,
                validator: validator,
                onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
                controller: controller,
                scrollPadding: const EdgeInsets.only(bottom: 160),

                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  filled: fillColor != null,
                  fillColor: fillColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(fontWeight: FontWeight.w500),

                  // suffixIcon: Icon(Icons.abc),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget buildDropdown(List<ChoiceOption> options) {
//   final validItems =
//       options
//           .where((opt) => opt.code != null && opt.code!.isNotEmpty)
//           .map(
//             (opt) => DropdownMenuItem<String>(
//               value: opt.code,
//               child: SizedBox(
//                 width: size.screenWidth * 0.7,
//                 child: Text(
//                   opt.name.ru ?? opt.name.en ?? opt.code ?? '',
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           )
//           .toList();

//   // Если ничего нет — показываем серую заглушку
//   if (validItems.isEmpty) {
//     validItems.add(
//       const DropdownMenuItem<String>(
//         enabled: false,
//         child: Text(
//           'Нет доступных вариантов',
//           style: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }

//   return Padding(
//     padding: const EdgeInsets.only(top: 8, bottom: 10),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Заголовок с красной звёздочкой
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: field.title.ru,
//                 style: const TextStyle(
//                   color: primaryButtonColor,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const TextSpan(
//                 text: ' *',
//                 style: TextStyle(color: primaryButtonColor, fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 9),

//         // Сам дропдаун
//         DropdownButtonFormField2<String>(
//           value:
//               currentValue, // ← это переменная из внешнего scope (уже объявлена выше)
//           hint: Text(field.placeholder.ru ?? 'Выберите значение'),
//           isExpanded: true,
//           items: validItems,
//           dropdownStyleData: DropdownStyleData(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//             ),
//           ),
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.only(left: 0, right: 8),
//             border: const OutlineInputBorder(),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: primaryButtonColor),
//             ),
//           ),
//           onChanged: (String? newValue) {
//             // ← ЭТО САМОЕ ГЛАВНОЕ!
//             ref.read(formFamilyProvider.notifier).setValue(field.key, newValue);
//             // Зависимые дропдауны сами перезагрузятся
//           },
//         ),
//       ],
//     ),
//   );
// }

// DropdownButton<String>(
//   isExpanded: true,
//   value: selectedValue,

//   //  Это ключевой момент!

//   onChanged: (value) {
//     // твой обработчик
//   },
// ),
