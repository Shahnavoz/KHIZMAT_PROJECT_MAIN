import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/widgets/my__button.dart';
import 'package:khizmat_new/feature/home/data/providers/steps_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/steps_page.dart';

class MyButtonPolucheniyeUslugi extends ConsumerStatefulWidget {
  final int docId;
  final int index;
  const MyButtonPolucheniyeUslugi({
    super.key,
    required this.docId,
    required this.index,
  });

  @override
  ConsumerState<MyButtonPolucheniyeUslugi> createState() =>
      _MyButtonPolucheniyeUslugiState();
}

class _MyButtonPolucheniyeUslugiState
    extends ConsumerState<MyButtonPolucheniyeUslugi> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocale = ref.watch(localeProvider);
    // final startDocProvider = ref.watch(shagiProvider(widget.docId));
    return My_Button(
      borderRadius: 50,
      width: double.infinity,
      size: size,
      backgroundColor: primaryButtonColor,
      borderColor: primaryButtonColor,

      onPressed:
          _isLoading
              ? null
              : () async {
                setState(() => _isLoading = true);

                try {
                  final data = await ref.read(
                    shagiProvider(widget.docId).future,
                  );

                  // Главная проверка по status_code
                  if (data.application.data != null) {
                    // ← success
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => StepsPage(
                              docId: widget.docId,
                              index: widget.index,
                            ),
                      ),
                    );
                  } else {
                    // status_code != 0 или data == null → показываем сообщение
                    String message = "Не удалось запустить процесс";

                    // Самый надёжный способ достать нужный текст
                    final titleMap = data?.application.message!.title.getText(
                      currentLocale,
                    );
                    if (titleMap != null) {
                      // Берём русский, или tajik, или english как fallback
                      message = titleMap;
                    }
                    // запасной вариант — status_message
                    else if (data?.application.statusMessage != null &&
                        data.application.statusMessage.trim().isNotEmpty) {
                      message = data.application.statusMessage.trim();
                    }

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline_rounded),
                            SizedBox(width: 5),
                            Text(message),
                          ],
                        ),
                        backgroundColor: Colors.orange[800],
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                } catch (e, stack) {
                  String text =
                      e.toString().replaceFirst('Exception: ', '').trim();
                  if (text.isEmpty) text = "Не удалось запустить процесс";

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Expanded(child: Text(text)),
                        ],
                      ),
                      backgroundColor: Colors.orange[800],
                    ),
                  );
                } finally {
                  if (mounted) {
                    setState(() => _isLoading = false);
                  }
                }
              },

      // onPressed:
      //     _isLoading
      //         ? null
      //         : () async {
      //           setState(() => _isLoading = true);

      //           try {
      //             final data = await ref.read(
      //               shagiProvider(widget.docId).future,
      //             );
      //             String displayMessage = "Неизвестная ошибка";

      //             if (data?.application != null) {
      //               displayMessage =
      //                   data!.application!.message ??
      //                   "Нет сообщения от сервера";
      //             } else if (data?.application.message?.title?.ru != null) {
      //               displayMessage =
      //                   data!.application.message!.title!.ru ??
      //                   "Ошибка запуска процесса";
      //             } else if (data?.application.statusMessage != null) {
      //               displayMessage = data!.application.statusMessage!;
      //             }

      //             // Главная проверка успеха
      //             final hasValidData = data?.application?.data != null;

      //             if (hasValidData) {
      //               if (!context.mounted) return;
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder:
      //                       (context) => StepsPage(
      //                         docId: widget.docId,
      //                         index: widget.index,
      //                       ),
      //                 ),
      //               );
      //             } else {
      //               // Всё остальное — показываем как ошибку/информацию
      //               if (!context.mounted) return;
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(
      //                   content: Text(displayMessage),
      //                   duration: const Duration(seconds: 4),
      //                   backgroundColor:
      //                       hasValidData ? null : Colors.orange[800],
      //                 ),
      //               );
      //             }
      //           } catch (e, stack) {
      //             String errorText = "Ошибка загрузки данных";
      //             if (e.toString().contains("Недостаточно информации")) {
      //               errorText =
      //                   "Недостаточно информации для запуска. Не поддерживается для физических лиц!!!";
      //             } else if (e.toString().contains("Timeout") ||
      //                 e.toString().contains("Socket")) {
      //               errorText = "Нет соединения с сервером. Проверьте интернет";
      //             } else {
      //               errorText =
      //                   "Ошибка: ${e.toString().replaceAll('Exception: ', '')}";
      //             }

      //             if (!context.mounted) return;
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 content: Text(errorText),
      //                 backgroundColor: Colors.red,
      //                 duration: const Duration(seconds: 5),
      //               ),
      //             );
      //           } finally {
      //             if (mounted) {
      //               setState(() => _isLoading = false);
      //             }
      //           }
      //         },
      // onPressed:
      //     _isLoading || startDocProvider.isLoading
      //         ? null
      //         : () async {
      //           setState(() => _isLoading = true);

      //           try {
      //             print("Начинаем await shagiProvider.future...");
      //             final data = await ref.read(
      //               shagiProvider(widget.docId).future,
      //             );
      //             print("Данные получены успешно: $data");

      //             // Проверяем структуру поэтапно
      //             if (data == null) {
      //               print("data == null");
      //               throw Exception("Ответ сервера пустой (null)");
      //             }

      //             if (data.application == null) {
      //               print("data.application == null");
      //               throw Exception("Поле application отсутствует");
      //             }

      //             final message =
      //                 data.application.message ?? "Нет сообщения от сервера";
      //             print("Сообщение: $message");

      //             if (data.application.data == null) {
      //               print("Успех: application.data присутствует");
      //               if (!context.mounted) return;
      //               ScaffoldMessenger.of(
      //                 context,
      //               ).showSnackBar(SnackBar(content: Text(message)));
      //             } else {
      //               print("application.data == null → показываем snackbar");
      //               if (!context.mounted) return;

      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder:
      //                       (context) => StepsPage(
      //                         docId: widget.docId,
      //                         index: widget.index,
      //                       ),
      //                 ),
      //               );
      //             }
      //           } catch (e, stack) {
      //             print("Поймана ошибка: $e");
      //             print("Стек: $stack");
      //             if (!context.mounted) return;
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 content: Text("Ошибка загрузки: ${e.toString()}"),
      //                 backgroundColor: Colors.red,
      //               ),
      //             );
      //           } finally {
      //             if (mounted) {
      //               setState(() => _isLoading = false);
      //             }
      //           }
      //         },
      //  () async {
      //   setState(() => _isLoading = true);

      //   try {
      //     final data = await ref.read(
      //       shagiProvider(widget.docId).future,
      //     );

      //     final message = data.application.message;

      //     if (data.application.data != null) {
      //       if (!context.mounted) return;
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder:
      //               (context) => StepsPage(
      //                 docId: widget.docId,
      //                 index: widget.index,
      //               ),
      //         ),
      //       );
      //     } else {
      //       if (!context.mounted) return;
      //       ScaffoldMessenger.of(
      //         context,
      //       ).showSnackBar(SnackBar(content: Text(message)));
      //     }
      //   } catch (e, stack) {
      //     if (!context.mounted) return;
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text("messa"),
      //         backgroundColor: Colors.red,
      //       ),
      //     );
      //   } finally {
      //     if (mounted) {
      //       setState(() => _isLoading = false);
      //     }
      //   }
      // },
      child:
          _isLoading
              ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
              : textWithH1Style(
                "Получить услугу",
                color: Colors.white,
                fontsize: 15,
              ),
    );
    //  My_Button(
    //   borderRadius: 50,
    //   width: double.infinity,
    //   size: size,  // предполагаю, size определён где-то выше
    //   backgroundColor: primaryButtonColor,
    //   borderColor: primaryButtonColor,
    // onPressed: _isLoading
    //     ? null  // кнопка отключена во время загрузки
    //     : () async {
    //         setState(() => _isLoading = true);

    //         try {
    //           // Ждём данные ОДИН раз (без watch, чтобы не подписываться)
    //           final data = await ref.read(startDocProvider.future);

    //           final message = data.application.message;

    //           if (data.application.data != null) {
    //             // Успех → переходим на экран
    //             if (!context.mounted) return;
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => StepsPage(
    //                   docId: widget.uslugaInfo.data.document.id,
    //                   index: widget.index,
    //                 ),
    //               ),
    //             );
    //           } else {
    //             // Сервер вернул ошибку/сообщение
    //             if (!context.mounted) return;
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(content: Text(message)),
    //             );
    //           }
    //         } catch (e) {
    //           // Ошибка сети, парсинга и т.д.
    //           if (!context.mounted) return;
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text('Ошибка: ${e.toString()}'),
    //               backgroundColor: Colors.red,
    //             ),
    //           );
    //         } finally {
    //           if (mounted) {  // mounted — защита от setState после dispose
    //             setState(() => _isLoading = false);
    //           }
    //         }
    //       },
    //   child: _isLoading
    //       ? const SizedBox(
    //           width: 24,
    //           height: 24,
    //           child: CircularProgressIndicator(
    //             strokeWidth: 3,
    //             color: Colors.white,
    //           ),
    //         )
    //       : textWithH1Style(
    //           "Получить услугу",
    //           color: Colors.white,
    //           fontsize: 15,
    //         ),
    // );
  }
}
