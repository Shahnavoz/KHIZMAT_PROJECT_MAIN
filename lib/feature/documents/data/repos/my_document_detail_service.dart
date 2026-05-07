import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';

class MyDocumentDetailService {
  var storage = FlutterSecureStorage();

  Future<MyDocumentDetailInfoModel> getDocumentDetailInfoById(int id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse("https://api.ekhizmat.tj/v1/register/view?id=$id"),
        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var decoded = myDocumentDetailInfoModelFromJson(response.body);

        return decoded;
      } else {
        print("Response Body: ${response.body}");
        print("Statuscode: ${response.statusCode}");
        throw new Exception();
      }
    } catch (e) {
      print(e);
      throw new Exception();
    }
  }

  // Future<String?> downloadDocument(int appId, Locale currentLocale) async {
  //   try {
  //     // 1. Формируем URL — замени на свой реальный способ получения ссылки
  //     final urlString =
  //         'https://dockhizmat.ehukumat.tj/certificate/$appId/pdf?language=${currentLocale.languageCode}';
  //     final uri = Uri.parse(urlString);

  //     // 2. Получаем временную директорию
  //     final tempDir = await getTemporaryDirectory();

  //     // 3. Имя файла (можно переопределить через параметр)
  //     final fileName = 'certificate${appId}_${currentLocale.languageCode}.pdf';
  //     final filePath = '${tempDir.path}/$fileName';

  //     final file = File(filePath);

  //     // 4. Если файл уже существует — возвращаем его путь сразу
  //     if (await file.exists()) {
  //       return filePath;
  //     }

  //     // 5. Делаем запрос
  //     final response = await http.get(uri);

  //     if (response.statusCode != 200) {
  //       // Можно добавить логирование
  //       // print('Ошибка сервера: ${response.statusCode} — ${response.body}');
  //       return null;
  //     }

  //     // 6. Сохраняем
  //     await file.writeAsBytes(response.bodyBytes);

  //     return filePath;
  //   } catch (e) {
  //     // print('Ошибка при скачивании документа: $e');
  //     return null;
  //   }
  // }

  String _serverLangCode(Locale locale) {
    // App stores Tajik as Locale('fr'); server expects 'tj'
    if (locale.languageCode == 'fr') return 'tj';
    return locale.languageCode;
  }

  Future<Uint8List> getCertificateUrl(int appId, Locale currentLocale) async {
    var token = await storage.read(key: 'token');
    var response = await http.get(
      Uri.parse(
        'https://dockhizmat.ehukumat.tj/certificate/$appId/pdf?language=${_serverLangCode(currentLocale)}',
      ),
      headers: <String, String>{
        'Content-Type': 'Application/json;Charset=utf-8',
        'Accept': 'application/pdf',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
      return response.bodyBytes;
    } else {
      throw Exception(
          'Не удалось загрузить документ (${response.statusCode})');
    }
  }

  // String getCertificateUrl(int appId, Locale currentLocale) {
  //   return 'https://dockhizmat.ehukumat.tj/certificate/$appId/pdf?language=${currentLocale.languageCode}';
  // }
}
