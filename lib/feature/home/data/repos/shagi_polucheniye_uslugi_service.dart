import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/home/data/models/drop_down_options_model.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/resume_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/start_document_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/models/upload_file_model.dart';
import 'package:khizmat_new/feature/home/data/models/uploaded_file_info.dart';

class ShagiPolucheniyeUslugiService {
  var storage = FlutterSecureStorage();

  Future<ShagiPolucheniyeUslugiModel> getStepsProcessInfo(
    int documentId,
    int applicationId,
  ) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/process?document_id=$documentId&application_id=$applicationId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = shagiPolucheniyeUslugiModelFromJson(response.body);
        print("RESPONSE BODY: $data");
        return data;
      }
      if (response.statusCode == 403) {
        throw Text("222");
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<StartDocumentModel> startPostForm(
    int documentId,
    Locale currentlocale,
  ) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v2/process/start?document_id=$documentId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return startDocumentModelFromJson(response.body);
      }

      // Для всех ошибок — пытаемся взять сообщение из тела
      String message = 'Ошибка сервера: ${response.statusCode}';

      try {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final titleRu = json['message']?['title']?['$currentlocale'] as String?;
        final titleTj = json['message']?['title']?['tj'] as String?;
        if (titleRu != null && titleRu.trim().isNotEmpty) {
          message = titleRu.trim();
        } else if (titleTj != null && titleTj.trim().isNotEmpty) {
          final statusMsg = json['status_message'] as String?;
          if (statusMsg != null && statusMsg.trim().isNotEmpty) {
            message = titleTj!;
          }
        } else {
          final statusMsg = json['status_message'] as String?;
          if (statusMsg != null && statusMsg.trim().isNotEmpty) {
            message = titleRu!;
          }
        }
      } catch (e) {
        print('Error in startPostForm: ${e.toString()}');
        // Пробрасываем дальше — пусть UI ловит и показывает
        rethrow;
      }

      throw Exception(message.toString());
    } catch (e) {
      print('Error in startPostForm: $e');
      rethrow;
    }
  }

  Future<ResumeModel> updatingWithResume(int applicationId) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.post(
        Uri.parse(
          "https://api.ekhizmat.tj/v2/process/resume?application_id=$applicationId",
        ),
        headers: <String, String>{
          'Content-Type': "Application/json;Charset=utf-8",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return resumeModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  //GET DROP DOWN INFO
  Future<DropDownOptionsModel> getDropDownInfo(
    int applicationId,
    Locale lang,
    String actionKey,
  ) async {
    try {
      final token = await storage.read(key: 'token');

      // final body = jsonEncode(values.map((val) => val.toJson()));//
      final response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/action?application_id=$applicationId&lang=$lang&action_key=$actionKey',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: body
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Ошибка запроса: ${response.statusCode} ${response.body}',
        );
      }

      // if (decoded['status_code'] != 0) {
      //   throw Exception('Ошибка API: ${decoded['status_message']}');
      // }

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = jsonDecode(response.body);
        print(decoded);
        print("*********************");
        // print(decoded['data']['field_events'][0]['choice_options']);
        print("*********************");
        var allData = DropDownOptionsModel.fromJson(decoded);
        print(allData.data.fieldEvents);
        return allData;
      } else {
        throw Exception();
      }
    } catch (e) {
      print("**********************************");
      print(e);
      throw Exception(e);
    }
  }

  Future<DropDownOptionsModel?> getDropDownInfoSafe(
    int applicationId,
    Locale lang,
    String actionKey, {
    String? inn,
  }) async {
    // 🚫 если этот action требует INN — не вызываем
    if (actionKey == "PLACE_SUBMISSION_TAX" && (inn == null || inn.isEmpty)) {
      print("SKIP $actionKey because INN is null");
      return null;
    }

    return await getDropDownInfo(applicationId, lang, actionKey);
  }

  //GET DROP DOWN INFO
  Future<DropDownOptionsModel> getSubRegionDropDown(
    int applicationId,
    Locale lang,
    String actionKey,
    String actionId,
    String code,
  ) async {
    try {
      final token = await storage.read(key: 'token');

      final response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/action?application_id=$applicationId&lang=$lang&action_key=$actionKey',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode([
          {"key": code, "value": actionId},
        ]),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Ошибка запроса: ${response.statusCode} ${response.body}',
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = jsonDecode(response.body);
        print(decoded);
        print("*********************");
        var allData = DropDownOptionsModel.fromJson(decoded);
        print(allData.data.fieldEvents);
        return allData;
      } else {
        throw Exception();
      }
    } catch (e) {
      print("**********************************");
      print(e);
      throw Exception(e);
    }
  }

  Future<StepRequirementModel> getStepRequirement(int documentId) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/requirement?document_id=$documentId&SELECTED_SPECIALIZATIONS=',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body;
        return stepRequirementModelFromJson(data);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //POST FORM STEPS

  Future<void> updateFormByStepsNext(
    int stepId,
    int applicationId,
    List<FieldValueModel> fieldValues,
    BuildContext context,
  ) async {
    try {
      var token = await storage.read(key: 'token');

      final body = jsonEncode(
        fieldValues.map((value) => value.toJson()).toList(),
      );

      var response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v2/process/update?application_id=$applicationId&step_id=$stepId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("status: ${response.statusCode}");
        print("status: ${response.body}");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Форма отправлено успешно.")),
          );
        }
      } else {
        print('Something went wrong ${response.statusCode}');
        print("body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /*
    Future<void> updateFormByStepsNext(
    WidgetRef ref,
    int stepId,
    int applicationId,
    List<FieldValueModel> fieldValues,
    BuildContext context,
    int documentId,
  ) async {
    try {
      var token = await storage.read(key: 'token');

      final body = jsonEncode(
        fieldValues.map((value) => value.toJson()).toList(),
      );

      var response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v2/process/update?application_id=$applicationId&step_id=$stepId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("status: ${response.statusCode}");
        print("status: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Форма отправлено успешно.")),
        );
        ref.invalidate(shagiProvider(documentId));
      } else {
        print('Something went wrong ${response.statusCode}');
        print("body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }*/

  Future<void> updateFormByStepsLast(
    int currentStepId,
    int lastStepId,
    int applicationId,
    List<FieldValueModel> fieldValues,
    BuildContext context,
  ) async {
    try {
      var token = await storage.read(key: 'token');

      final body = jsonEncode(
        fieldValues.map((value) => value.toJson()).toList(),
      );

      var response = await http.post(
        Uri.parse(
          'https://api.ekhizmat.tj/v2/process/update?application_id=$applicationId&step_id=$currentStepId&change_step_id=$lastStepId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("status: ${response.statusCode}");
        print("status: ${response.body}");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Форма отправлено успешно.")),
          );
        }
      } else {
        print('Something went wrong ${response.statusCode}');
        print("body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<UploadedFileModel?> uploadFile(int applicationId) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/file/application/upload?application_id=$applicationId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = jsonDecode(response.body);
        print(decoded);
        print("*********************");
        var allData = UploadedFileModel.fromJson(decoded);
        return allData;
      } else {
        throw Exception();
      }
    } catch (e) {
      return null;
    }
  }

  Future<UploadedFileInfo?> getUploadedFileInfo(int application_id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.post(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/file/application/info/6575?application_id=$application_id',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = jsonDecode(response.body);
        print(decoded);
        print("*********************");
        var allData = UploadedFileInfo.fromJson(decoded);
        return allData;
      } else {
        throw Exception();
      }
    } catch (e) {
      return null;
    }
  }
}
