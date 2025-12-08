import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/providers/controllers_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/drop_down_params_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/steps_provider.dart';
import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/custom_appbar.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/radio_button.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/requirement_step.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/switch_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:open_file/open_file.dart';

final currentStepProvider = StateProvider<int>((ref) => 0);
final selectedValueProvider = StateProvider<String>((ref) => "");

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
              My_Button(
                width: double.infinity,
                size: size,
                backgroundColor: Colors.white,
                borderColor: greyTextFBorderColor,
                borderRadius: 10,
                onPressed: () {},
                child: textWithH1Style(
                  "Сохранить как черновик",
                  fontsize: 15,
                  // color: Colors.white,
                ),
              ),
              My_Button(
                width: double.infinity,
                size: size,
                backgroundColor: primaryButtonColor,
                borderColor: primaryButtonColor,
                borderRadius: 10,
                onPressed: () {
                  _onContinuePressed(asyncSteps, currentStep);
                },
                child: textWithH1Style(
                  "Продoлжить",
                  fontsize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
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
                          return null;
                        }

                        final dropDownList = allStepsInfo.dropDownOptions;

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

                          final currentStepGroups =
                              fieldGroups
                                  .where(
                                    (fieldGroup) =>
                                        fieldGroup.stepId ==
                                        sortedSteps[currentStep].id,
                                  )
                                  .toList();

                          final currentStepKeys = currentStepGroups.expand(
                            (fieldGroup) =>
                                fieldGroup.fields
                                    .where(
                                      (field) => field.type != 'TEXT_BLOCK',
                                    )
                                    .map((field) => field.key)
                                    .toList(),
                          );
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
                                        "Шаг № ${currentStep + 1}",
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
                                        setState(() {
                                          currentIndex = index;
                                          isActive = !isActive;
                                        });
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            left:
                                                index != 0 ? size.otstup15 : 0,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(
                                                    currentStepProvider
                                                        .notifier,
                                                  )
                                                  .state = index;
                                            },
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
                                                  width:
                                                      size.screenWidth * 0.25,
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
                                                              Radius.circular(
                                                                10,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                ),
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
              ],
            ),
          ),
        ],
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
            sendValue = value.code; // или value.name.getText(currentLocale)
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
  }) {
    return step.type == 'FORM'
        ? Form(
          key: _formKey,
          child: Column(
            children: [
              ...groups.map((fieldGroups) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithH1Style(
                      fieldGroups.title.getText(currentLocale),
                      textAlign: TextAlign.start,
                      fontsize: 17,
                    ),
                    SizedBox(height: size.otstup15),
                    fieldGroups.groupDuplicate == false
                        ? Column(
                          children:
                              fieldGroups.fields.map((field) {
                                final selectedItem = ref.watch(
                                  selectedValueProvider,
                                );
                                final _controller = formFamilyProviderWatch
                                    .getTextController(field.key);

                                switch (field.type) {
                                  case 'INPUT':
                                    return InputTextField(
                                      keyboardType: TextInputType.name,
                                      onTap: () {},
                                      size: size,
                                      formKey: formFamilyProviderWatch
                                          .getFieldKey(field.key),
                                      labelText: field.title.getText(
                                        currentLocale,
                                      ),
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
                                        if (value == null || value.isEmpty) {
                                          return "Поле обязательно для заполнения";
                                        }
                                        if (field.key == 'APPLICANT_TIN' &&
                                            value.length < 9) {
                                          return "Введите минимальную длину";
                                        }

                                        return null;
                                      },
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
                                                fontWeight: FontWeight.bold,
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
                                  //   final stepsInfoAsync = ref.watch(
                                  //     shagiProvider(docId),
                                  //   );

                                  //   // Хранит выбранное значение родительского дропдауна (регион → район и т.д.)
                                  //   // final selectedParent = ref.watch(
                                  //   //   selectedParentProvider(field.key),
                                  //   // );

                                  //   final selectedValue=ref.watch(selectedValueProvider);
                                  //   print("***********");

                                  //   print(selectedValue);

                                  //   return stepsInfoAsync.when(
                                  //     data: (stepsInfo) {
                                  //       // Текущее значение этого поля из формы
                                  //       final formData = ref.watch(
                                  //         formProviderFamily(docId),
                                  //       );
                                  //       // final String? currentValue =
                                  //       //     formData.getValue(field.actionKey!)
                                  //       //         as String?;

                                  //       // 1. Статические опции из JSON (самый низкий приоритет)
                                  //       final staticOptions =
                                  //           field.choiceOptions;

                                  //       // 2. Опции из основного запроса (shagiProvider)
                                  //       final baseOptions =
                                  //           stepsInfo.dropDownOptions[field
                                  //               .actionId] ??
                                  //           <ChoiceOption>[];

                                  //       // 3. Зависимые опции — самый высокий приоритет
                                  //       final dependentAsync = ref.watch(
                                  //         dependentDropdownProvider((
                                  //           applicationId:
                                  //               stepsInfo.applicationId,
                                  //           locale: currentLocale,
                                  //           actionKey: field.actionKey ?? '',
                                  //           parentCode: selectedValue ?? '',
                                  //           parentActionId: field.actionId!,
                                  //         )),
                                  //       );

                                  //       return Padding(
                                  //         padding: const EdgeInsets.only(
                                  //           top: 8,
                                  //           bottom: 10,
                                  //         ),
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             // Заголовок поля
                                  //             RichText(
                                  //               text: TextSpan(
                                  //                 children: [
                                  //                   TextSpan(
                                  //                     text: field.title.ru,
                                  //                     style: const TextStyle(
                                  //                       color:
                                  //                           primaryButtonColor,
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                     ),
                                  //                   ),
                                  //                   if (field.required == true)
                                  //                     const TextSpan(
                                  //                       text: ' *',
                                  //                       style: TextStyle(
                                  //                         color:
                                  //                             primaryButtonColor,
                                  //                         fontSize: 16,
                                  //                       ),
                                  //                     ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             const SizedBox(height: 9),

                                  //             DropdownButtonFormField2<String>(
                                  //               value: selectedValue,
                                  //               isExpanded: true,
                                  //               hint: Text(
                                  //                 field.placeholder.ru ??
                                  //                     'Выберите...',
                                  //               ),
                                  //               decoration: InputDecoration(
                                  //                 contentPadding:
                                  //                     const EdgeInsets.only(
                                  //                       left: 0,
                                  //                       right: 8,
                                  //                     ),
                                  //                 enabledBorder:
                                  //                     OutlineInputBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             10,
                                  //                           ),
                                  //                       borderSide: BorderSide(
                                  //                         color:
                                  //                             Colors.grey[400]!,
                                  //                         width: 2,
                                  //                       ),
                                  //                     ),
                                  //                 focusedBorder: OutlineInputBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                         10,
                                  //                       ),
                                  //                   borderSide: const BorderSide(
                                  //                     color: primaryButtonColor,
                                  //                     width: 2,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               dropdownStyleData:
                                  //                   DropdownStyleData(
                                  //                     decoration: BoxDecoration(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             16,
                                  //                           ),
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                   ),

                                  //               // ГЛАВНАЯ ЛОГИКА: какие items показываем?
                                  //               items:
                                  //                   selectedValue != null
                                  //                       // Если выбран родитель — показываем зависимые
                                  //                       ? dependentAsync.when(
                                  //                         data: (map) {
                                  //                           final List<
                                  //                             ChoiceOption
                                  //                           >
                                  //                           opts =
                                  //                               map[field
                                  //                                   .actionId] ??
                                  //                               [];
                                  //                           return opts.isEmpty
                                  //                               ? _buildDropdownItems(
                                  //                                 baseOptions,
                                  //                                 size,
                                  //                               )
                                  //                               : _buildDropdownItems(
                                  //                                 opts,
                                  //                                 size,
                                  //                               );
                                  //                         },
                                  //                         loading:
                                  //                             () => [
                                  //                               const DropdownMenuItem<
                                  //                                 String
                                  //                               >(
                                  //                                 enabled:
                                  //                                     false,
                                  //                                 child: SizedBox(
                                  //                                   height: 20,
                                  //                                   width: 20,
                                  //                                   child: CircularProgressIndicator(
                                  //                                     strokeWidth:
                                  //                                         2,
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ],
                                  //                         error:
                                  //                             (_, __) => [
                                  //                               const DropdownMenuItem<
                                  //                                 String
                                  //                               >(
                                  //                                 enabled:
                                  //                                     false,
                                  //                                 child: Text(
                                  //                                   'Ошибка загрузки',
                                  //                                 ),
                                  //                               ),
                                  //                             ],
                                  //                       )
                                  //                       // Если родитель НЕ выбран
                                  //                       : _buildDropdownItems(
                                  //                         baseOptions.isNotEmpty
                                  //                             ? baseOptions
                                  //                             : staticOptions,
                                  //                         size,
                                  //                       ),

                                  //               // При выборе
                                  //               onChanged: (String? newValue) {
                                  //                 if (newValue == null) return;

                                  //                 ref.read(selectedValueProvider.notifier).state=newValue;

                                  //                 // Сохраняем в форму
                                  //                 ref
                                  //                     .read(
                                  //                       formProviderFamily(
                                  //                         docId,
                                  //                       ).notifier,
                                  //                     )
                                  //                     .setValue(
                                  //                       field.key,
                                  //                       newValue,
                                  //                     );

                                  //                 // Если это родительский дропдаун (есть actionKey) — запоминаем выбор
                                  //                 if (field.actionKey != null &&
                                  //                     field
                                  //                         .actionKey!
                                  //                         .isNotEmpty) {
                                  //                   ref
                                  //                       .read(
                                  //                         selectedParentProvider(
                                  //                           field.actionId!,
                                  //                         ).notifier,
                                  //                       )
                                  //                       .state = newValue;
                                  //                 }
                                  //               },

                                  //               // Красивое отображение выбранного значения (как у тебя было)
                                  //               selectedItemBuilder: (context) {
                                  //                 final displayOptions =
                                  //                     selectedValue != null
                                  //                         ? dependentAsync.maybeWhen(
                                  //                           data:
                                  //                               (map) =>
                                  //                                   map[field
                                  //                                       .actionId] ??
                                  //                                   baseOptions,
                                  //                           orElse:
                                  //                               () =>
                                  //                                   baseOptions,
                                  //                         )
                                  //                         : (baseOptions
                                  //                                 .isNotEmpty
                                  //                             ? baseOptions
                                  //                             : staticOptions);

                                  //                 return displayOptions.map((
                                  //                   opt,
                                  //                 ) {
                                  //                   return SizedBox(
                                  //                     width:
                                  //                         size.screenWidth *
                                  //                         0.75,
                                  //                     child: Text(
                                  //                       opt.name.ru ??
                                  //                           opt.name.en ??
                                  //                           opt.code ??
                                  //                           '',
                                  //                       style: const TextStyle(
                                  //                         color: Colors.black,
                                  //                       ),
                                  //                       maxLines: 1,
                                  //                       overflow:
                                  //                           TextOverflow
                                  //                               .ellipsis,
                                  //                     ),
                                  //                   );
                                  //                 }).toList();
                                  //               },
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     },
                                  //     loading:
                                  //         () => const Center(
                                  //           child: CircularProgressIndicator(),
                                  //         ),
                                  //     error:
                                  //         (err, stack) => Text('Ошибка: $err'),
                                  //   );

                                  case 'DROP_DOWN':
                                    final stepsInfoAsync = ref.watch(
                                      shagiProvider(docId),
                                    );

                                    List<ChoiceOption> options =
                                        field.choiceOptions;

                                    return stepsInfoAsync.when(
                                      data: (stepsInfo) {
                                        return field.choiceOptions.isEmpty
                                            ? Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 10,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: field.title.ru,
                                                          style: const TextStyle(
                                                            color:
                                                                primaryButtonColor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: '* ',
                                                          style: TextStyle(
                                                            color:
                                                                primaryButtonColor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 9),
                                                  DropdownButtonFormField2<
                                                    String
                                                  >(
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  16,
                                                                ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                            left: 0,
                                                            right: 8,
                                                          ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[400]!,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color:
                                                                  primaryButtonColor,
                                                            ),
                                                      ),
                                                    ),
                                                    hint: Text(
                                                      field.placeholder.ru ??
                                                          '',
                                                    ),

                                                    items:
                                                        (stepsInfo.dropDownOptions[field
                                                                    .actionId] ??
                                                                [])
                                                            .map((option) {
                                                              return DropdownMenuItem<
                                                                String
                                                              >(
                                                                value:
                                                                    option.code,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets.only(
                                                                        top:
                                                                            size.otstup10,
                                                                      ),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            size.screenWidth *
                                                                            0.75,
                                                                        child: Text(
                                                                          option.name.ru ??
                                                                              option.name.en ??
                                                                              option.code ??
                                                                              "",

                                                                          style: const TextStyle(
                                                                            height:
                                                                                1.1,
                                                                            // fontSize:
                                                                            //     14,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            size.screenWidth *
                                                                            0.75,
                                                                        height:
                                                                            0.5,
                                                                        color:
                                                                            primaryGreenColor,
                                                                        margin: const EdgeInsets.only(
                                                                          top:
                                                                              3,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                            .toList(),
                                                    selectedItemBuilder: (
                                                      BuildContext context,
                                                    ) {
                                                      return (stepsInfo
                                                                  .dropDownOptions[field
                                                                  .actionId] ??
                                                              [])
                                                          .map<Widget>((
                                                            option,
                                                          ) {
                                                            return SizedBox(
                                                              width:
                                                                  size.screenWidth *
                                                                  0.75,
                                                              child: Text(
                                                                option
                                                                        .name
                                                                        .ru ??
                                                                    option
                                                                        .name
                                                                        .en ??
                                                                    option
                                                                        .code ??
                                                                    "",
                                                                style: const TextStyle(
                                                                  // fontSize: 14,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            );
                                                          })
                                                          .toList();
                                                    },
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        formFamilyProviderRead
                                                            .setValue(
                                                              field.key,
                                                              value,
                                                            );
                                                      }
                                                      final selected =
                                                          ref
                                                              .watch(
                                                                selectedValueProvider
                                                                    .notifier,
                                                              )
                                                              .state = value!;
                                                      // Загружаем dependent options
                                                      final dependentAsync = ref.watch(
                                                        dependentDropdownProvider((
                                                          applicationId:
                                                              stepsInfo
                                                                  .applicationId,
                                                          locale: currentLocale,
                                                          actionKey:
                                                              field.actionKey!,
                                                          parentCode: selected,
                                                          parentActionId:
                                                              field.actionId!,
                                                        )),
                                                      );

                                                      setState(() {
                                                        options = dependentAsync.when(
                                                          error:
                                                              (stack, error) =>
                                                                  [],
                                                          loading: () => [],
                                                          data:
                                                              (map) =>
                                                                  options =
                                                                      map[field
                                                                          .actionId] ??
                                                                      [],
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                            : Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 10,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: field.title.ru,
                                                          style: const TextStyle(
                                                            color:
                                                                primaryButtonColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: '* ',
                                                          style: TextStyle(
                                                            color:
                                                                primaryButtonColor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 9),
                                                  DropdownButtonFormField2<
                                                    String
                                                  >(
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  16,
                                                                ),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                            left: 0,
                                                            right: 8,
                                                          ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[400]!,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color:
                                                                  primaryButtonColor,
                                                            ),
                                                      ),
                                                    ),
                                                    hint: Text(
                                                      field.placeholder.ru ??
                                                          '',
                                                    ),
                                                    items:
                                                        options.map((option) {
                                                          return DropdownMenuItem<
                                                            String
                                                          >(
                                                            value: option.code,
                                                            child: Text(
                                                              option.name.ru ??
                                                                  option
                                                                      .name
                                                                      .en ??
                                                                  option.code ??
                                                                  "",
                                                            ),
                                                          );
                                                        }).toList(),
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        formFamilyProviderRead
                                                            .setValue(
                                                              field.key,
                                                              value,
                                                            );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                      },
                                      loading:
                                          () =>
                                              const CircularProgressIndicator(),
                                      error:
                                          (err, stack) => Text('Ошибка: $err'),
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
                                    return Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          InputTextField(
                                            onChanged: (value) {
                                              ref
                                                  .read(
                                                    formProviderFamily(docId),
                                                  )
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
                                                        color:
                                                            primaryButtonColor,
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
                                                        color:
                                                            primaryButtonColor,
                                                      ),
                                                    ),
                                          ),
                                        ],
                                      ),
                                    );

                                  case 'TEXT_AREA':
                                    return InputTextField(
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
                                              height: size.screenHeight * 0.5,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    textWithH1Style(
                                                      fieldGroups.title.ru!,
                                                      fontsize: 18,
                                                    ),
                                                    Divider(
                                                      color: primaryGreenColor,
                                                    ),
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
                                                                                    "DATE" ||
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
                                                    onPressed: () {},
                                                    child: textWithH1Style(
                                                      "Сохранить",
                                                      color: Colors.white,
                                                      fontsize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // TextButton(
                                              //   onPressed:
                                              //       () =>
                                              //           Navigator.of(
                                              //             context,
                                              //           ).pop(),
                                              //   child: const Text("Отмена"),
                                              // ),
                                              // SizedBox(width: size.otstup15),
                                              // ElevatedButton(
                                              //   onPressed: () {
                                              //     // Здесь можно добавить валидацию формы, если нужно
                                              //     Navigator.of(context).pop();
                                              //   },
                                              //   child: const Text("Сохранить"),
                                              // ),
                                            ],
                                          );
                                        },
                                      );
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return Container(
                                      //       height: size.screenHeight*0.4,
                                      //       child: Column(
                                      //         mainAxisSize: MainAxisSize.max,

                                      //         children:
                                      //             fieldGroups.fields.map((
                                      //               field,
                                      //             ) {
                                      //               final selectedItem = ref
                                      //                   .watch(
                                      //                     selectedValueProvider,
                                      //                   );
                                      //               final _controller =
                                      //                   formFamilyProviderWatch
                                      //                       .getTextController(
                                      //                         field.key,
                                      //                       );
                                      //               switch (field.type) {
                                      //                 case 'INPUT':
                                      //                   return InputTextField(
                                      //                     onTap: () {},
                                      //                     size: size,
                                      //                     formKey:
                                      //                         formFamilyProviderWatch
                                      //                             .getFieldKey(
                                      //                               field.key,
                                      //                             ),
                                      //                     labelText: field.title
                                      //                         .getText(
                                      //                           currentLocale,
                                      //                         ),
                                      //                     hintText: field
                                      //                         .placeholder
                                      //                         .getText(
                                      //                           currentLocale,
                                      //                         ),
                                      //                     controller:
                                      //                         _controller,
                                      //                     // onFieldSubmitted: (value) {
                                      //                     //   // formFamilyProviderRead.setValue(
                                      //                     //   //   field.key,
                                      //                     //   //   value,
                                      //                     //   // );
                                      //                     // },
                                      //                     onChanged: (value) {
                                      //                       ref
                                      //                           .read(
                                      //                             formProviderFamily(
                                      //                               docId,
                                      //                             ),
                                      //                           )
                                      //                           .setValue(
                                      //                             field.key,
                                      //                             value,
                                      //                           );
                                      //                     },
                                      //                     validator: (value) {
                                      //                       if (value == null ||
                                      //                           value.isEmpty) {
                                      //                         return "Поле обязательно для заполнения";
                                      //                       }
                                      //                       if (field.key ==
                                      //                               'APPLICANT_TIN' &&
                                      //                           value.length <
                                      //                               9) {
                                      //                         return "Введите минимальную длину";
                                      //                       }

                                      //                       return null;
                                      //                     },
                                      //                   );

                                      //                 default:
                                      //                   return Padding(
                                      //                     padding:
                                      //                         const EdgeInsets.only(
                                      //                           bottom: 12,
                                      //                         ),
                                      //                     child: Text(
                                      //                       "Неизвестный тип: ${field.type}",
                                      //                     ),
                                      //                   );
                                      //               }
                                      //             }).toList(),
                                      //       ),
                                      //     );
                                      //   },
                                      // );
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
                          ],
                        ),
                  ],
                );
              }),
            ],
          ),
        )
        : step.type == 'PAYMENT'
        ? Container()
        : RequirementStep(stepRequirement: requirements, documentId: docId);
    // : Container();
  }
}

class FontSettingContainer extends StatelessWidget {
  const FontSettingContainer({super.key, required this.size});

  final AdaptiveSizes size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyBorderColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.otstup5,
          vertical: size.otstup5,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyBorderColor),
                shape: BoxShape.circle,
                color: Color(0xFFEBFFF3),
              ),
              child: Icon(Icons.add, color: primaryGreenColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.otstup15),
              child: Text("Aaa", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyBorderColor),
                shape: BoxShape.circle,
                color: Color(0xFFEBFFF3),
              ),
              child: Icon(Icons.remove, color: primaryGreenColor),
            ),
          ],
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double? width;
  final TextEditingController controller;
  // final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Key? formKey;
  final AdaptiveSizes size;
  final void Function()? onTap;
  final int maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? isFocused;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.width,
    required this.controller,
    // required this.onFieldSubmitted,
    required this.onChanged,
    required this.validator,
    this.suffixIcon,
    required this.formKey,
    required this.size,
    required this.onTap,
    this.maxLength = 1,
    this.keyboardType,
    this.focusNode,
    this.isFocused,
    this.readOnly,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: TextStyle(
                  color: primaryButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '* ',
                style: TextStyle(color: primaryButtonColor, fontSize: 16),
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
                readOnly: readOnly ?? false,
                showCursor: isFocused,
                focusNode: focusNode,
                cursorOpacityAnimates: false,
                keyboardType: keyboardType,
                maxLines: maxLength,
                validator: validator,
                // onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
                controller: controller,
                scrollPadding: EdgeInsets.zero,

                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: greyTextFBorderColor,
                      width: 2,
                    ),
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

List<DropdownMenuItem<String>> _buildDropdownItems(
  List<ChoiceOption> options,
  AdaptiveSizes size,
) {
  return options.map<DropdownMenuItem<String>>((option) {
    return DropdownMenuItem<String>(
      value: option.code,
      child: Padding(
        padding: EdgeInsets.only(top: size.otstup10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.screenWidth * 0.75,
              child: Text(
                option.name.ru ?? option.name.en ?? option.code ?? '',
                style: const TextStyle(height: 1.1, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: size.screenWidth * 0.75,
              height: 0.5,
              color: primaryGreenColor,
              margin: const EdgeInsets.only(top: 3),
            ),
          ],
        ),
      ),
    );
  }).toList();
}
