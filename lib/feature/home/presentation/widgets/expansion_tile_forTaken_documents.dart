import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/notification_page.dart';
import 'package:path_provider/path_provider.dart';

class ExpansionTileForTakenDocuments extends StatefulWidget {
  const ExpansionTileForTakenDocuments({
    super.key,
    required this.size,
    required this.title,
    required this.currentLocale,
    required this.index,
    required this.attachments,
  });

  final AdaptiveSizes size;
  final String title;
  final Locale currentLocale;
  final int index;
  final List<Attachment> attachments;

  @override
  State<ExpansionTileForTakenDocuments> createState() =>
      _ExpansionTileForTakenDocumentsState();
}

class _ExpansionTileForTakenDocumentsState
    extends State<ExpansionTileForTakenDocuments> {
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
                    itemCount: widget.attachments.length,
                    itemBuilder: (context, index) {
                      final document = widget.attachments[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: size.otstup10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.screenWidth * 0.55,
                              child: textWithH1Style(
                                textAlign: TextAlign.start,
                                document.name!,
                                fontsize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await downloadAndSaveWithHttp(
                                  downloadUri: document.downloadUri,
                                  name: document.name,
                                  extension: document.extension,
                                  context: context,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: primaryGreenColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: textWithH1Style(
                                    "Сохранить",
                                    fontsize: 14,
                                    color: Colors.white,
                                  ),
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

Future<void> downloadAndSaveWithHttp({
  required String? downloadUri,
  required String? name,
  required String? extension,
  BuildContext? context,
}) async {
  if (downloadUri == null || downloadUri.isEmpty) {
    print('Ошибка: downloadUri пустой');
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нет ссылки для скачивания')),
      );
    }
    return;
  }

  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token');

  try {
    final response = await http.get(
      Uri.parse(downloadUri),
      headers: <String, String>{
        'Content-Type': 'application/json;Charset=utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки: ${response.statusCode}');
    }

    final Uint8List bytes = response.bodyBytes;

    // Формируем имя
    String fileName = name ?? 'file';
    if (extension != null && extension.isNotEmpty) {
      fileName =
          fileName.endsWith('.$extension') ? fileName : '$fileName.$extension';
    } else {
      fileName = '$fileName.pdf';
    }

    // Путь в Downloads
    Directory? downloadDir;
    if (Platform.isAndroid) {
      downloadDir = Directory('/storage/emulated/0/Download');
    } else {
      downloadDir = await getDownloadsDirectory();
    }

    if (downloadDir != null && !await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }

    final String filePath = '${downloadDir?.path}/$fileName';
    final File file = File(filePath);

    await file.writeAsBytes(bytes);

    print('Файл успешно сохранён в: $filePath');

    // SnackBar (если есть context)
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Сохранено в Загрузки: $fileName'),
          duration: const Duration(seconds: 4),
        ),
      );
    }

    // Показываем уведомление
    await _showDownloadNotification(fileName, filePath);
  } catch (e) {
    print('Ошибка: $e');
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось сохранить: $e')));
    }
  }
}

// Функция уведомления
Future<void> _showDownloadNotification(String fileName, String filePath) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'downloads_channel',
    'Загрузки документов',
    channelDescription: 'Уведомления о сохранении файлов',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: true,
    enableVibration: true,
    playSound: true,
    ticker: 'Файл сохранён',
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(id: 0);
}
