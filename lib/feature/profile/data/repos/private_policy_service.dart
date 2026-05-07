import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrivatePolicyData {
  final String titleRu;
  final String titleTj;
  final String titleEn;
  final String descriptionRu;
  final String descriptionTj;
  final String descriptionEn;

  PrivatePolicyData({
    required this.titleRu,
    required this.titleTj,
    required this.titleEn,
    required this.descriptionRu,
    required this.descriptionTj,
    required this.descriptionEn,
  });

  String title(String languageCode) {
    switch (languageCode) {
      case 'tj':
        return titleTj;
      case 'en':
        return titleEn;
      default:
        return titleRu;
    }
  }

  String description(Locale languageCode) {
    switch (languageCode.languageCode) {
      case 'fr':
        return descriptionTj;
      case 'en':
        return descriptionEn;
      default:
        return descriptionRu;
    }
  }
}

class PrivatePolicyService {
  Future<PrivatePolicyData> fetchPolicy() async {
    final response = await http.get(
      Uri.parse(
        'https://api.ekhizmat.tj/v1/admin/open_source/alert/privatepolicy',
      ),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'];
      return PrivatePolicyData(
        titleRu: data['title_ru'] ?? '',
        titleTj: data['title_tj'] ?? '',
        titleEn: data['title_en'] ?? '',
        descriptionRu: data['description_ru'] ?? '',
        descriptionTj: data['description_tj'] ?? '',
        descriptionEn: data['description_en'] ?? '',
      );
    }

    throw Exception('Ошибка загрузки: ${response.statusCode}');
  }
}
