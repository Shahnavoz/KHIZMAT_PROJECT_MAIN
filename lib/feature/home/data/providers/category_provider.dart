import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';
import 'package:khizmat_new/feature/home/data/models/combined_category_data_model.dart';
import 'package:khizmat_new/feature/home/data/models/podcategories_model.dart';
import 'package:khizmat_new/feature/home/data/models/podcategory_specialization_model.dart';
import 'package:khizmat_new/feature/home/data/models/upload_file_model.dart';
import 'package:khizmat_new/feature/home/data/models/uploaded_file_info.dart';
import 'package:khizmat_new/feature/home/data/repos/category_service.dart';
import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';

//With New Model
final categoriesWithNewModelProvider = FutureProvider<AllUpdatedDateModel>((
  ref,
) async {
  final repo = CategoryService();
  return repo.getCategoriesWithNewModel();
});

final uploadedFileProvider = FutureProvider.family<UploadedFileInfo?, int>((
  ref,
  applicationId,
) async {
  final repo = ShagiPolucheniyeUslugiService();
  return repo.getUploadedFileInfo(applicationId);
});
final uploadeMethodFileProvider =
    FutureProvider.family<UploadedFileModel?, int>((ref, applicationId) async {
      final repo = ShagiPolucheniyeUslugiService();
      return repo.uploadFile(applicationId);
    });

//Getting subcategories by document_id
final categoriesDetailByDocumentIdProvider =
    FutureProvider.family<SubcategoryByDocumentIdModel, int>((
      ref,
      document_id,
    ) async {
      final repo = CategoryService();
      return repo.getCategoriesDetailInfoByDocumentId(document_id);
    });

final combinedCategoriesProvider = FutureProvider<CombinedCategoryData>((
  ref,
) async {
  final repo = CategoryService();

  // Загружаем категории
  final newCategoryModel = await repo.getCategoriesWithNewModel();
  final categoryIds =
      newCategoryModel.data.categories.map((cat) => cat.id).toSet();
  final documents = newCategoryModel.data.documents;

  // Параллельно загружаем подкатегории
  final details = await Future.wait(
    documents.map((doc) => repo.getCategoriesDetailInfoByDocumentId(doc.id)),
  );

  final matchingMap = <int, List<SubcategoryByDocumentIdModel>>{};
  final specMatchingMap = <int, List<Specialization>>{};

  // Обработка подкатегорий
  for (var detail in details) {
    final categoryId = detail.data.categoryId;
    if (categoryIds.contains(categoryId)) {
      matchingMap.putIfAbsent(categoryId, () => []);
      matchingMap[categoryId]!.add(detail);
    }
  }

  // Параллельно загружаем специализации
  final specDetails = await Future.wait(
    documents.map((doc) => repo.getSubcategsSpecializationByDocumentId(doc.id)),
  );

  // Обработка специализаций
  for (int i = 0; i < documents.length; i++) {
    final docId = documents[i].id;
    final specDetail = specDetails[i];

    final specializations = specDetail.data.specializations;
    if (specializations.isNotEmpty) {
      specMatchingMap[docId] = [
        ...specializations..sort((a, b) => a.position.compareTo(b.position)),
      ];
    }
  }

  return CombinedCategoryData(
    subcategoriesByCategory: matchingMap,
    specializationsByDocId: specMatchingMap,
  );
});
