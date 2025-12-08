import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/models/podcategories_model.dart';
import 'package:khizmat_new/feature/home/data/models/podcategory_specialization_model.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_requirement.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';

class CategoryService {
  var storage = FlutterSecureStorage();

  Future<AllUpdatedDateModel> getCategoriesWithNewModel() async {
    try {

      final tokenRaw = await storage.read(key: 'token');
      if (tokenRaw == null || tokenRaw.isEmpty) {
        throw Exception('Token не найден в secure storage');
      }
      // Убираем возможные кавычки/пробелы
      final token = tokenRaw.replaceAll('"', '').trim();
      print('➡️ Используем токен: <$token>');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/all?updated_date=0',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = allUpdatedDateModelFromJson(response.body);
        return decoded;
      } else {
        throw Exception('Ошибка загрузки категорий: ${response.statusCode}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Ошибка загрузки категорий: ${e}');
    }
  }

   Future<AllUpdatedDateModel> getAllUpdatedDate() async {
    try {

      final tokenRaw = await storage.read(key: 'token');
      if (tokenRaw == null || tokenRaw.isEmpty) {
        throw Exception('Token не найден в secure storage');
      }
      final token = tokenRaw.replaceAll('"', '').trim();
      print('➡️ Используем токен: <$token>');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/all?updated_date=0',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = allUpdatedDateModelFromJson(response.body);
        return decoded;
      } else {
        throw Exception('Ошибка загрузки категорий: ${response.statusCode}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Ошибка загрузки категорий: ${e}');
    }
  }
  //USLUGADETAILINFO

  Future<UslugaDetailInfo> getUslugaDetailInfo(int document_id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/info?document_id=$document_id',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return uslugaDetailInfoFromJson(response.body);
      } else {
        throw Exception('Oshibka zagruzki: ${response.body}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Oshibka: $e   sdfghjk: $st');
    }
  }

  //USLUGA SPECIALIZATION

  Future<UslugaSpecialization> getUsluguSpecialization(int document_id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/specialization?document_id=$document_id',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return uslugaSpecializationFromJson(response.body);
      } else {
        throw Exception('Oshibka zagruzki: ${response.body}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Oshibka: $e   sdfghjk: $st');
    }
  }

  Future<SubcategoryByDocumentIdModel> getCategoriesDetailInfoByDocumentId(
    int document_id,
  ) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/info?document_id=$document_id',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return SubcategoryByDocumentIdModel.fromJson(decoded);
      } else {
        throw Exception('Oshibka zagruzki: ${response.body}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Oshibka: $e   sdfghjk: $st');
    }
  }

  //SPECIALIZATION

  Future<SubcategorySpezializationByDocumentIdModel>
  getSubcategsSpecializationByDocumentId(int document_id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/specialization?document_id=$document_id',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return SubcategorySpezializationByDocumentIdModel.fromJson(decoded);
      } else {
        throw Exception('Oshibka zagruzki: ${response.body}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Oshibka: $e   sdfghjk: $st');
    }
  }

  //REQUIREMNET

  // Future<SubcategRequirementModel> getSubcategsRequiremnetsByDocumentId(
  //   int document_id,
  //   int selected_spec,
  // ) async {
  //   try {
  //     var token = await storage.read(key: 'token');
  //     var response = await http.get(
  //       Uri.parse(
  //         'https://apikhizmat.ehukumat.tj/v1/reference/documents/requirement?document_id=$document_id&SELECTED_SPECIALIZATIONS=$selected_spec',
  //       ),

  //       headers: <String, String>{
  //         'Content-Type': 'Application/json;Charset=utf-8',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> decoded = jsonDecode(response.body);
  //       return SubcategRequirementModel.fromJson(decoded);
  //     } else {
  //       throw Exception('Oshibka zagruzki: ${response.body}');
  //     }
  //   } catch (e, st) {
  //     print(e);
  //     print(st);
  //     throw Exception('Oshibka: $e   sdfghjk: $st');
  //   }
  // }

   //USLUGA  REQUIREMNET

  Future<UslugaRequirement> getSubcategsRequiremnetsByDocumentId(
    int document_id,
    int selected_spec,
  ) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/reference/documents/requirement?document_id=$document_id&SELECTED_SPECIALIZATIONS=$selected_spec',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        return UslugaRequirement.fromJson(decoded);
      } else {
        throw Exception('Oshibka zagruzki: ${response.body}');
      }
    } catch (e, st) {
      print(e);
      print(st);
      throw Exception('Oshibka: $e   sdfghjk: $st');
    }
  }

  Future<void> loadMatchingData() async {
    final newCategoryModel = await getCategoriesWithNewModel();

    // Получаем все документы
    final documents = newCategoryModel.data.documents;

    final matchingMap = <int, List<SubcategoryByDocumentIdModel>>{};

    final detail = await getCategoriesDetailInfoByDocumentId(2103);

    final categoryId = detail.data.categoryId;

    // Проверяем, есть ли такая категория в списке
    final exists = newCategoryModel.data.categories.any(
      (cat) => cat.id == categoryId,
    );

    if (exists) {
      matchingMap.putIfAbsent(categoryId, () => []);
      matchingMap[categoryId]!.add(detail);
    }

    print("Найдено категорий с совпадением: ${matchingMap.length}");
  }






}
