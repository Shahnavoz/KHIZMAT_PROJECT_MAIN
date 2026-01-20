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

                                  //Another Varuant

                                  // case 'DROP_DOWN':
                                  //   final stepsInfoAsync = ref.watch(
                                  //     shagiProvider(docId),
                                  //   );

                                  //   List<ChoiceOption> options =
                                  //       field.choiceOptions;

                                  //   return stepsInfoAsync.when(
                                  //     data: (stepsInfo) {
                                  //       final selectedValue = ref.watch(
                                  //         selectedValueProvider,
                                  //       );
                                  //       final dependentAsync = ref.watch(
                                  //         dependentDropdownProvider((
                                  //           applicationId:
                                  //               stepsInfo.applicationId,
                                  //           locale: currentLocale,
                                  //           actionKey: field.choiceOptionsAuto!,
                                  //           parentCode: selectedValue,
                                  //           parentActionId: field.actionId!,
                                  //         )),
                                  //       );

                                  //       dependentAsync.when(
                                  //         data: (data) {
                                  //           final options =
                                  //               data[field.actionId] ?? [];
                                  //           return Padding(
                                  //             padding: const EdgeInsets.only(
                                  //               top: 8,
                                  //               bottom: 10,
                                  //             ),
                                  //             child: Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.start,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 RichText(
                                  //                   text: TextSpan(
                                  //                     children: [
                                  //                       TextSpan(
                                  //                         text: field.title.ru,
                                  //                         style: const TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 15,
                                  //                           fontWeight:
                                  //                               FontWeight.bold,
                                  //                         ),
                                  //                       ),
                                  //                       const TextSpan(
                                  //                         text: '* ',
                                  //                         style: TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 16,
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 const SizedBox(height: 9),
                                  //                 DropdownButtonFormField2<
                                  //                   String
                                  //                 >(
                                  //                   dropdownStyleData:
                                  //                       DropdownStyleData(
                                  //                         decoration: BoxDecoration(
                                  //                           borderRadius:
                                  //                               BorderRadius.circular(
                                  //                                 16,
                                  //                               ),
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                   decoration: InputDecoration(
                                  //                     contentPadding:
                                  //                         const EdgeInsets.only(
                                  //                           left: 0,
                                  //                           right: 8,
                                  //                         ),
                                  //                     border:
                                  //                         const OutlineInputBorder(),
                                  //                     enabledBorder: OutlineInputBorder(
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
                                  //                     focusedBorder: OutlineInputBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             10,
                                  //                           ),
                                  //                       borderSide:
                                  //                           const BorderSide(
                                  //                             color:
                                  //                                 primaryButtonColor,
                                  //                           ),
                                  //                     ),
                                  //                   ),
                                  //                   hint: Text(
                                  //                     field.placeholder.ru ??
                                  //                         '',
                                  //                   ),

                                  //                   items:
                                  //                       options.map((option) {
                                  //                         return DropdownMenuItem<
                                  //                           String
                                  //                         >(
                                  //                           value: option.code,
                                  //                           child: Padding(
                                  //                             padding:
                                  //                                 EdgeInsets.only(
                                  //                                   top:
                                  //                                       size.otstup10,
                                  //                                 ),
                                  //                             child: Column(
                                  //                               children: [
                                  //                                 SizedBox(
                                  //                                   width:
                                  //                                       size.screenWidth *
                                  //                                       0.75,
                                  //                                   child: Text(
                                  //                                     option.name.ru ??
                                  //                                         option
                                  //                                             .name
                                  //                                             .en ??
                                  //                                         option
                                  //                                             .code ??
                                  //                                         "",

                                  //                                     style: const TextStyle(
                                  //                                       height:
                                  //                                           1.1,
                                  //                                       // fontSize:
                                  //                                       //     14,
                                  //                                       color:
                                  //                                           Colors.black,
                                  //                                     ),
                                  //                                     maxLines:
                                  //                                         2,
                                  //                                     overflow:
                                  //                                         TextOverflow
                                  //                                             .ellipsis,
                                  //                                   ),
                                  //                                 ),
                                  //                                 Container(
                                  //                                   width:
                                  //                                       size.screenWidth *
                                  //                                       0.75,
                                  //                                   height: 0.5,
                                  //                                   color:
                                  //                                       primaryGreenColor,
                                  //                                   margin:
                                  //                                       const EdgeInsets.only(
                                  //                                         top:
                                  //                                             3,
                                  //                                       ),
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                           ),
                                  //                         );
                                  //                       }).toList(),
                                  //                   selectedItemBuilder: (
                                  //                     BuildContext context,
                                  //                   ) {
                                  //                     return (stepsInfo
                                  //                                 .dropDownOptions[field
                                  //                                 .actionId] ??
                                  //                             [])
                                  //                         .map<Widget>((
                                  //                           option,
                                  //                         ) {
                                  //                           return SizedBox(
                                  //                             width:
                                  //                                 size.screenWidth *
                                  //                                 0.75,
                                  //                             child: Text(
                                  //                               option
                                  //                                       .name
                                  //                                       .ru ??
                                  //                                   option
                                  //                                       .name
                                  //                                       .en ??
                                  //                                   option
                                  //                                       .code ??
                                  //                                   "",
                                  //                               style: const TextStyle(
                                  //                                 // fontSize: 14,
                                  //                                 color:
                                  //                                     Colors
                                  //                                         .black,
                                  //                               ),
                                  //                               maxLines: 1,
                                  //                               overflow:
                                  //                                   TextOverflow
                                  //                                       .ellipsis,
                                  //                             ),
                                  //                           );
                                  //                         })
                                  //                         .toList();
                                  //                   },
                                  //                   onChanged: (value) {
                                  //                     if (value != null) {
                                  //                       formFamilyProviderRead
                                  //                           .setValue(
                                  //                             field.key,
                                  //                             value,
                                  //                           );
                                  //                     }

                                  //                     ref
                                  //                         .read(
                                  //                           selectedValueProvider
                                  //                               .notifier,
                                  //                         )
                                  //                         .state = value!;
                                  //                     // Загружаем dependent options
                                  //                     // final dependentAsync = ref.watch(
                                  //                     //   dependentDropdownProvider((
                                  //                     //     applicationId:
                                  //                     //         stepsInfo
                                  //                     //             .applicationId,
                                  //                     //     locale: currentLocale,
                                  //                     //     actionKey:
                                  //                     //         field.actionKey!,
                                  //                     //     parentCode: selected,
                                  //                     //     parentActionId:
                                  //                     //         field.actionId!,
                                  //                     //   )),
                                  //                     // );

                                  //                     // setState(() {
                                  //                     //   options = dependentAsync.when(
                                  //                     //     error:
                                  //                     //         (stack, error) =>
                                  //                     //             [],
                                  //                     //     loading: () => [],
                                  //                     //     data:
                                  //                     //         (map) =>
                                  //                     //             options =
                                  //                     //                 map[field
                                  //                     //                     .actionId] ??
                                  //                     //                 [],
                                  //                     //   );
                                  //                     // });
                                  //                   },
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           );
                                  //         },
                                  //         error:
                                  //             (st, error) => Center(
                                  //               child: Text("${error}"),
                                  //             ),
                                  //         loading:
                                  //             () => Center(
                                  //               child:
                                  //                   CircularProgressIndicator(),
                                  //             ),
                                  //       );

                                  //       return field.choiceOptions.isEmpty
                                  //           ? Padding(
                                  //             padding: const EdgeInsets.only(
                                  //               top: 8,
                                  //               bottom: 10,
                                  //             ),
                                  //             child: Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.start,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 RichText(
                                  //                   text: TextSpan(
                                  //                     children: [
                                  //                       TextSpan(
                                  //                         text: field.title.ru,
                                  //                         style: const TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 15,
                                  //                           fontWeight:
                                  //                               FontWeight.bold,
                                  //                         ),
                                  //                       ),
                                  //                       const TextSpan(
                                  //                         text: '* ',
                                  //                         style: TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 16,
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 const SizedBox(height: 9),
                                  //                 DropdownButtonFormField2<
                                  //                   String
                                  //                 >(
                                  //                   dropdownStyleData:
                                  //                       DropdownStyleData(
                                  //                         decoration: BoxDecoration(
                                  //                           borderRadius:
                                  //                               BorderRadius.circular(
                                  //                                 16,
                                  //                               ),
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                   decoration: InputDecoration(
                                  //                     contentPadding:
                                  //                         const EdgeInsets.only(
                                  //                           left: 0,
                                  //                           right: 8,
                                  //                         ),
                                  //                     border:
                                  //                         const OutlineInputBorder(),
                                  //                     enabledBorder: OutlineInputBorder(
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
                                  //                     focusedBorder: OutlineInputBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             10,
                                  //                           ),
                                  //                       borderSide:
                                  //                           const BorderSide(
                                  //                             color:
                                  //                                 primaryButtonColor,
                                  //                           ),
                                  //                     ),
                                  //                   ),
                                  //                   hint: Text(
                                  //                     field.placeholder.ru ??
                                  //                         '',
                                  //                   ),

                                  //                   items:
                                  //                       (stepsInfo.dropDownOptions[field
                                  //                                   .actionId] ??
                                  //                               [])
                                  //                           .map((option) {
                                  //                             return DropdownMenuItem<
                                  //                               String
                                  //                             >(
                                  //                               value:
                                  //                                   option.code,
                                  //                               child: Padding(
                                  //                                 padding:
                                  //                                     EdgeInsets.only(
                                  //                                       top:
                                  //                                           size.otstup10,
                                  //                                     ),
                                  //                                 child: Column(
                                  //                                   children: [
                                  //                                     SizedBox(
                                  //                                       width:
                                  //                                           size.screenWidth *
                                  //                                           0.75,
                                  //                                       child: Text(
                                  //                                         option.name.ru ??
                                  //                                             option.name.en ??
                                  //                                             option.code ??
                                  //                                             "",

                                  //                                         style: const TextStyle(
                                  //                                           height:
                                  //                                               1.1,
                                  //                                           // fontSize:
                                  //                                           //     14,
                                  //                                           color:
                                  //                                               Colors.black,
                                  //                                         ),
                                  //                                         maxLines:
                                  //                                             2,
                                  //                                         overflow:
                                  //                                             TextOverflow.ellipsis,
                                  //                                       ),
                                  //                                     ),
                                  //                                     Container(
                                  //                                       width:
                                  //                                           size.screenWidth *
                                  //                                           0.75,
                                  //                                       height:
                                  //                                           0.5,
                                  //                                       color:
                                  //                                           primaryGreenColor,
                                  //                                       margin: const EdgeInsets.only(
                                  //                                         top:
                                  //                                             3,
                                  //                                       ),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             );
                                  //                           })
                                  //                           .toList(),
                                  //                   selectedItemBuilder: (
                                  //                     BuildContext context,
                                  //                   ) {
                                  //                     return (stepsInfo
                                  //                                 .dropDownOptions[field
                                  //                                 .actionId] ??
                                  //                             [])
                                  //                         .map<Widget>((
                                  //                           option,
                                  //                         ) {
                                  //                           return SizedBox(
                                  //                             width:
                                  //                                 size.screenWidth *
                                  //                                 0.75,
                                  //                             child: Text(
                                  //                               option
                                  //                                       .name
                                  //                                       .ru ??
                                  //                                   option
                                  //                                       .name
                                  //                                       .en ??
                                  //                                   option
                                  //                                       .code ??
                                  //                                   "",
                                  //                               style: const TextStyle(
                                  //                                 // fontSize: 14,
                                  //                                 color:
                                  //                                     Colors
                                  //                                         .black,
                                  //                               ),
                                  //                               maxLines: 1,
                                  //                               overflow:
                                  //                                   TextOverflow
                                  //                                       .ellipsis,
                                  //                             ),
                                  //                           );
                                  //                         })
                                  //                         .toList();
                                  //                   },
                                  //                   onChanged: (value) {
                                  //                     if (value != null) {
                                  //                       formFamilyProviderRead
                                  //                           .setValue(
                                  //                             field.key,
                                  //                             value,
                                  //                           );
                                  //                     }

                                  //                     ref
                                  //                         .read(
                                  //                           selectedValueProvider
                                  //                               .notifier,
                                  //                         )
                                  //                         .state = value!;
                                  //                     // Загружаем dependent options
                                  //                     // final dependentAsync = ref.watch(
                                  //                     //   dependentDropdownProvider((
                                  //                     //     applicationId:
                                  //                     //         stepsInfo
                                  //                     //             .applicationId,
                                  //                     //     locale: currentLocale,
                                  //                     //     actionKey:
                                  //                     //         field.actionKey!,
                                  //                     //     parentCode: selected,
                                  //                     //     parentActionId:
                                  //                     //         field.actionId!,
                                  //                     //   )),
                                  //                     // );

                                  //                     // setState(() {
                                  //                     //   options = dependentAsync.when(
                                  //                     //     error:
                                  //                     //         (stack, error) =>
                                  //                     //             [],
                                  //                     //     loading: () => [],
                                  //                     //     data:
                                  //                     //         (map) =>
                                  //                     //             options =
                                  //                     //                 map[field
                                  //                     //                     .actionId] ??
                                  //                     //                 [],
                                  //                     //   );
                                  //                     // });
                                  //                   },
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           )
                                  //           : Padding(
                                  //             padding: const EdgeInsets.only(
                                  //               top: 8,
                                  //               bottom: 10,
                                  //             ),
                                  //             child: Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.start,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 RichText(
                                  //                   text: TextSpan(
                                  //                     children: [
                                  //                       TextSpan(
                                  //                         text: field.title.ru,
                                  //                         style: const TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 16,
                                  //                           fontWeight:
                                  //                               FontWeight.bold,
                                  //                         ),
                                  //                       ),
                                  //                       const TextSpan(
                                  //                         text: '* ',
                                  //                         style: TextStyle(
                                  //                           color:
                                  //                               primaryButtonColor,
                                  //                           fontSize: 16,
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 const SizedBox(height: 9),
                                  //                 DropdownButtonFormField2<
                                  //                   String
                                  //                 >(
                                  //                   dropdownStyleData:
                                  //                       DropdownStyleData(
                                  //                         decoration: BoxDecoration(
                                  //                           borderRadius:
                                  //                               BorderRadius.circular(
                                  //                                 16,
                                  //                               ),
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                   decoration: InputDecoration(
                                  //                     contentPadding:
                                  //                         const EdgeInsets.only(
                                  //                           left: 0,
                                  //                           right: 8,
                                  //                         ),
                                  //                     border:
                                  //                         const OutlineInputBorder(),
                                  //                     enabledBorder: OutlineInputBorder(
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
                                  //                     focusedBorder: OutlineInputBorder(
                                  //                       borderRadius:
                                  //                           BorderRadius.circular(
                                  //                             10,
                                  //                           ),
                                  //                       borderSide:
                                  //                           const BorderSide(
                                  //                             color:
                                  //                                 primaryButtonColor,
                                  //                           ),
                                  //                     ),
                                  //                   ),
                                  //                   hint: Text(
                                  //                     field.placeholder.ru ??
                                  //                         '',
                                  //                   ),
                                  //                   items:
                                  //                       options.map((option) {
                                  //                         return DropdownMenuItem<
                                  //                           String
                                  //                         >(
                                  //                           value: option.code,
                                  //                           child: Text(
                                  //                             option.name.ru ??
                                  //                                 option
                                  //                                     .name
                                  //                                     .en ??
                                  //                                 option.code ??
                                  //                                 "",
                                  //                           ),
                                  //                         );
                                  //                       }).toList(),
                                  //                   onChanged: (value) {
                                  //                     if (value != null) {
                                  //                       formFamilyProviderRead
                                  //                           .setValue(
                                  //                             field.key,
                                  //                             value,
                                  //                           );
                                  //                     }
                                  //                     print(
                                  //                       'Current Value: ${value}',
                                  //                     );
                                  //                   },
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           );
                                  //     },
                                  //     loading:
                                  //         () =>
                                  //             const CircularProgressIndicator(),
                                  //     error:
                                  //         (err, stack) => Text('Ошибка: $err'),
                                  //   );

                                  // case 'DROP_DOWN':
                                  //   final stepsInfoAsync = ref.watch(
                                  //     shagiProvider(docId),
                                  //   );

                                  //   List<ChoiceOption> baseOptions =
                                  //           field.choiceOptions;

                                  //   return  stepsInfoAsync.when(
                                  //     loading:
                                  //         () => _buildDropdownSkeleton(
                                  //           field,
                                  //           isLoading: true,
                                  //         ),
                                  //     error:
                                  //         (err, stack) =>
                                  //             _buildDropdownSkeleton(
                                  //               field,
                                  //               error: err.toString(),
                                  //             ),
                                  //     data: (stepsInfo) {
                                  //       // List<ChoiceOption> baseOptions =
                                  //       //     field.choiceOptions;
                                  //       if (baseOptions.isEmpty &&
                                  //           field.actionId != null) {
                                  //         baseOptions =
                                  //             stepsInfo.dropDownOptions[field
                                  //                 .actionId] ??
                                  //             [];
                                  //       }

                                  //       // if (baseOptions.isNotEmpty) {
                                  //       //   return _buildDropdown(
                                  //       //     field: field,
                                  //       //     options: baseOptions,
                                  //       //     selectedValue:
                                  //       //         formFamilyProviderRead.getValue(
                                  //       //               field.key,
                                  //       //             )
                                  //       //             as String?,
                                  //       //     onChanged: (value) {
                                  //       //       if (value != null) {
                                  //       //         formFamilyProviderRead.setValue(
                                  //       //           field.key,
                                  //       //           value,
                                  //       //         );
                                  //       //         // if (field.actionKey != null) {
                                  //       //         //   ref
                                  //       //         //       .read(
                                  //       //         //         selectedValueProvider
                                  //       //         //             .notifier,
                                  //       //         //       )
                                  //       //         //       .state = value;
                                  //       //         // }
                                  //       //       }
                                  //       //     },
                                  //       //     size: size,
                                  //       //   );
                                  //       // }
                                  //       final bool isDependent =
                                  //           field.actionKey == null &&
                                  //           field.choiceOptionsAuto != null ;
                                  //           // &&
                                  //           // field.choiceOptions.isEmpty;

                                  //       if (!isDependent) {
                                  //         return _buildDropdown(
                                  //           field: field,
                                  //           options: baseOptions,
                                  //           selectedValue:
                                  //               formFamilyProviderRead.getValue(
                                  //                     field.key,
                                  //                   )
                                  //                   as String?,
                                  //           onChanged: (String? newValue) {
                                  //             if (newValue != null) {
                                  //               formFamilyProviderRead.setValue(
                                  //                 field.key,
                                  //                 newValue,
                                  //               );

                                                
                                  //               ref
                                  //                   .read(
                                  //                     selectedValueProvider
                                  //                         .notifier,
                                  //                   )
                                  //                   .state = newValue;
                                  //               // formFamilyProviderRead.setValue(
                                  //               //   'sub_region_field_key',
                                  //               //   null,
                                  //               // );
                                  //               // formFamilyProviderRead.setValue(
                                  //               //   'city_field_key',
                                  //               //   null,
                                  //               // );
                                  //             }
                                  //           },
                                  //           size: size,
                                  //         );
                                  //       }

                                  //       final selectedParentCode = ref.watch(
                                  //         selectedValueProvider,
                                  //       );

                                  //       if (selectedParentCode.isEmpty) {
                                  //         return _buildDropdown(
                                  //           field: field,
                                  //           options: [],
                                  //           selectedValue: null,
                                  //           onChanged: (value) => null,
                                  //           size: size,
                                  //         );
                                  //       }

                                  //       final dependentAsync = ref.watch(
                                  //         dependentDropdownProvider((
                                  //           applicationId:
                                  //               stepsInfo.applicationId,
                                  //           locale: currentLocale,
                                  //           actionKey: "SUB_REGIONS",
                                  //           parentCode: selectedParentCode,
                                  //           parentActionId: "REGION_ID",
                                  //         )),
                                  //       );

                                  //       return dependentAsync.when(
                                  //         loading:
                                  //             () => _buildDropdownSkeleton(
                                  //               field,
                                  //               isLoading: true,
                                  //             ),
                                  //         error:
                                  //             (err, _) =>
                                  //                 _buildDropdownSkeleton(
                                  //                   field,
                                  //                   error: err.toString(),
                                  //                 ),

                                  //         // data: (dataMap) {
                                  //         //   final dependentOptions =
                                  //         //       dataMap[field.actionId] ??
                                  //         //       <ChoiceOption>[];

                                  //         //   final codes =
                                  //         //       dependentOptions
                                  //         //           .map((e) => e.code)
                                  //         //           .toList();
                                  //         //   final duplicates =
                                  //         //       codes
                                  //         //           .where(
                                  //         //             (code) =>
                                  //         //                 codes
                                  //         //                     .where(
                                  //         //                       (c) =>
                                  //         //                           c == code,
                                  //         //                     )
                                  //         //                     .length >
                                  //         //                 1,
                                  //         //           )
                                  //         //           .toSet();
                                  //         //   if (duplicates.isNotEmpty) {
                                  //         //     print(
                                  //         //       "ДУБЛИКАТЫ CODE: $duplicates",
                                  //         //     );
                                  //         //   }

                                  //         //   return _buildDropdown(
                                  //         //     field: field,
                                  //         //     options: dependentOptions,
                                  //         //     selectedValue:
                                  //         //         formFamilyProviderRead
                                  //         //                 .getValue(field.key)
                                  //         //             as String?,
                                  //         //     onChanged: (value) {
                                  //         //       if (value != null) {
                                  //         //         formFamilyProviderRead
                                  //         //             .setValue(
                                  //         //               field.key,
                                  //         //               value,
                                  //         //             );
                                  //         //       }
                                  //         //     },
                                  //         //     size: size,
                                  //         //   );
                                  //         // },
                                  //         data: (dataMap) {
                                  //           final dependentOptions =
                                  //               (dataMap[field.actionId] ??
                                  //                       <ChoiceOption>[])
                                  //                   .toSet()
                                  //                   .toList();

                                  //           String? currentValue =
                                  //               formFamilyProviderRead.getValue(
                                  //                     field.key,
                                  //                   )
                                  //                   as String?;
                                  //           if (currentValue != null &&
                                  //               !dependentOptions.any(
                                  //                 (opt) =>
                                  //                     opt.code == currentValue,
                                  //               )) {
                                  //             currentValue = null;
                                  //             formFamilyProviderRead.setValue(
                                  //               field.key,
                                  //               null,
                                  //             );
                                  //           }

                                  //           return _buildDropdown(
                                  //             field: field,
                                  //             options: dependentOptions,
                                  //             selectedValue: currentValue,
                                  //             onChanged: (String? newValue) {
                                  //               formFamilyProviderRead.setValue(
                                  //                 field.key,
                                  //                 newValue,
                                  //               );
                                  //             },
                                  //             size: size,
                                  //           );
                                  //         },
                                  //       );
                                  //     },
                                  //   );


// case 'DROP_DOWN':
                                  //   final stepsInfoAsync = ref.watch(
                                  //     shagiProvider(docId),
                                  //   );
                                  //   List<ChoiceOption> options = [];
                                  //   options = field.choiceOptions;
                                  //   print("FIELD cHOICEoPTIONaUTO");
                                  //   print(field.choiceOptionsAuto);

                                  //   return options.isEmpty &&
                                  //           field.actionKey != null
                                  //       ? stepsInfoAsync.when(
                                  //         data: (stepsInfo) {
                                  //           options =
                                  //               stepsInfo.dropDownOptions[field
                                  //                   .actionId] ??
                                  //               [];

                                  //           // _buildDropdown(
                                  //           //   field: field,
                                  //           //   options: options,
                                  //           //   onChanged: (value) {
                                  //           //     if (value != null) {
                                  //           //       formFamilyProviderRead
                                  //           //           .setValue(
                                  //           //             field.key,
                                  //           //             value,
                                  //           //           );

                                  //           //       final r =
                                  //           //           ref
                                  //           //               .read(
                                  //           //                 selectedValueProvider
                                  //           //                     .notifier,
                                  //           //               )
                                  //           //               .state = value;
                                  //           //       print("******SelectedValue");

                                  //           //       print(r);
                                  //           //     }
                                  //           //   },
                                  //           //   selectedValue:
                                  //           //       formFamilyProviderRead
                                  //           //               .getValue(field.key)
                                  //           //           as String?,

                                  //           //   size: size,
                                  //           // );

                                  //           final parentActionId =
                                  //               field.actionId;
                                  //           print("ActionIdParent");
                                  //           print(parentActionId);
                                  //           final selectedParentCode = ref
                                  //               .watch(selectedValueProvider);

                                  //           if (selectedParentCode.isNotEmpty) {
                                  //             final dependentAsync = ref.watch(
                                  //               dependentDropdownProvider((
                                  //                 applicationId:
                                  //                     stepsInfo.applicationId,
                                  //                 locale: currentLocale,
                                  //                 actionKey:"SUB_REGIONS",
                                  //                 parentCode:
                                  //                     selectedParentCode,
                                  //                 parentActionId:
                                  //                     parentActionId!,
                                  //               )),
                                  //             );

                                  //             print("ActionKey");

                                  //             print(field.choiceOptionsAuto);
                                  //             print("SelectedParentCode");

                                  //             print(selectedParentCode);
                                  //             print("ActionId");

                                  //             print(parentActionId);

                                  //             return dependentAsync.when(
                                  //               loading:
                                  //                   () =>
                                  //                       _buildDropdownSkeleton(
                                  //                         field,
                                  //                         isLoading: true,
                                  //                       ),
                                  //               error:
                                  //                   (err, stack) =>
                                  //                       _buildDropdownSkeleton(
                                  //                         field,
                                  //                         error: err.toString(),
                                  //                       ),
                                  //               data: (dataMap) {
                                  //                 final dependentOptions =
                                  //                     dataMap[field.actionId] ??
                                  //                     <ChoiceOption>[];

                                  //                 return _buildDropdown(
                                  //                   field: field,
                                  //                   options: dependentOptions,
                                  //                   onChanged: (value) {
                                  //                     if (value != null) {
                                  //                       formFamilyProviderRead
                                  //                           .setValue(
                                  //                             field.key,
                                  //                             value,
                                  //                           );
                                  //                     }

                                  //                     ref
                                  //                         .watch(
                                  //                           selectedValueProvider
                                  //                               .notifier,
                                  //                         )
                                  //                         .state = value!;
                                  //                   },

                                  //                   selectedValue:
                                  //                       formFamilyProviderRead
                                  //                               .getValue(
                                  //                                 field.key,
                                  //                               )
                                  //                           as String?,
                                  //                   size: size,
                                  //                 );
                                  //               },
                                  //             );
                                  //           }

                                  //           // List<ChoiceOption> options = [];

                                  //           // if (field.choiceOptions.isNotEmpty) {
                                  //           //   options = field.choiceOptions;
                                  //           // } else {
                                  //           //   options =
                                  //           //       stepsInfo.dropDownOptions[field
                                  //           //           .actionId] ??
                                  //           //       [];

                                  //           //   final s = options.map((e) => e.code);
                                  //           //   print("*****Element*************");
                                  //           //   print(s);
                                  //           //   print("*****Element*************");
                                  //           // }

                                  //           return _buildDropdown(
                                  //             field: field,
                                  //             options: options,
                                  //             onChanged: (value) {
                                  //               if (value != null) {
                                  //                 formFamilyProviderRead
                                  //                     .setValue(
                                  //                       field.key,
                                  //                       value,
                                  //                     );

                                  //                 ref
                                  //                     .read(
                                  //                       selectedValueProvider
                                  //                           .notifier,
                                  //                     )
                                  //                     .state = value;
                                  //               }
                                  //             },
                                  //             selectedValue:
                                  //                 formFamilyProviderRead
                                  //                         .getValue(field.key)
                                  //                     as String?,

                                  //             size: size,
                                  //           );
                                  //         },
                                  //         loading:
                                  //             () => _buildDropdownSkeleton(
                                  //               field,
                                  //               isLoading: true,
                                  //             ),
                                  //         error:
                                  //             (err, stack) =>
                                  //                 _buildDropdownSkeleton(
                                  //                   field,
                                  //                   error: err.toString(),
                                  //                 ),
                                  //       )
                                  //       : options.isEmpty &&
                                  //           field.actionKey == null
                                  //       ? stepsInfoAsync.when(
                                  //         data: (stepsInfo) {
                                  //           options =
                                  //               stepsInfo.dropDownOptions[field
                                  //                   .actionId] ??
                                  //               [];

                                  //           return _buildDropdown(
                                  //             field: field,
                                  //             options: options,
                                  //             onChanged: (value) {
                                  //               if (value != null) {
                                  //                 formFamilyProviderRead
                                  //                     .setValue(
                                  //                       field.key,
                                  //                       value,
                                  //                     );

                                  //                 // final r =
                                  //                 //     ref
                                  //                 //         .read(
                                  //                 //           selectedValueProvider
                                  //                 //               .notifier,
                                  //                 //         )
                                  //                 //         .state = value;
                                  //                 print("******SelectedValue");

                                  //                 // print(r);
                                  //               }
                                  //             },
                                  //             selectedValue:
                                  //                 formFamilyProviderRead
                                  //                         .getValue(field.key)
                                  //                     as String?,

                                  //             size: size,
                                  //           );
                                  //         },
                                  //         loading:
                                  //             () => _buildDropdownSkeleton(
                                  //               field,
                                  //               isLoading: true,
                                  //             ),
                                  //         error:
                                  //             (err, stack) =>
                                  //                 _buildDropdownSkeleton(
                                  //                   field,
                                  //                   error: err.toString(),
                                  //                 ),
                                  //       )
                                  //       : _buildDropdown(
                                  //         field: field,
                                  //         options: options,
                                  //         onChanged: (value) {
                                  //           if (value != null) {
                                  //             formFamilyProviderRead.setValue(
                                  //               field.key,
                                  //               value,
                                  //             );
                                  //           }
                                  //         },
                                  //         selectedValue:
                                  //             formFamilyProviderRead.getValue(
                                  //                   field.key,
                                  //                 )
                                  //                 as String?,
                                  //         size: size,
                                  //       );