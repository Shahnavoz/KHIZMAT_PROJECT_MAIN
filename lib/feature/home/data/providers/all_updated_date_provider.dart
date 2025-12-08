import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/models/combined_usluga_data.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_detail_info.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_requirement.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';
import 'package:khizmat_new/feature/home/data/repos/all_updated_date_service.dart';
import 'package:khizmat_new/feature/home/data/repos/category_service.dart';

final allUpdatedDateProvider = FutureProvider((ref) async {
  final repo = AllUpdatedDateService();
  return await repo.getAllInformation();
});

final specializationProvider = FutureProvider.family<SpecializationData, int>((
  ref,
  categoryId,
) async {
  final repo = CategoryService();
  final allData = await ref.read(allUpdatedDateProvider.future);
  final documents =
      allData!.data.documents.where((d) => d.categoryId == categoryId).toList();

  if (documents.isEmpty) {
    return SpecializationData(uslugaSpecialization: {});
  }

  final results = await Future.wait(
    documents.map((doc) async {
      final specializations = await repo.getUsluguSpecialization(doc.id);

      final specs = specializations.data.specializations;
      final sortedSpecs =
          specs.isEmpty
                ? <MySpecialization>[]
                : List<MySpecialization>.from(specs)
            ..sort(
              (a, b) => (a.position ?? 999999).compareTo(b.position ?? 999999),
            );

      return _DocResultForSpecialization(
        docId: doc.id,
        specializations: sortedSpecs,
        categoryId: categoryId,
      );
    }),
  );

  final specMap = <int, List<MySpecialization>>{};

  for (final r in results) {
    specMap[r.docId] = r.specializations;
  }

  return SpecializationData(uslugaSpecialization: specMap);
});


final combinedUslugaDataProvider = FutureProvider.family<
  CombinedUslugaData,
  int
>((ref, categoryId) async {
  final repo = CategoryService();

  // 1. Получаем все данные (кэшируем)
  final allData = await ref.read(allUpdatedDateProvider.future);
  final documents =
      allData!.data.documents.where((d) => d.categoryId == categoryId).toList();

  if (documents.isEmpty) {
    return CombinedUslugaData(
      uslugaDetailInfo: {categoryId: []},
      uslugaSpecialization: {},
    );
  }

  // 2. Параллельно: detail + spec
  final results = await Future.wait(
    documents.map((doc) async {
      final detail = await repo.getUslugaDetailInfo(doc.id);
      final specResp = await repo.getUsluguSpecialization(doc.id);

      final specs = specResp.data.specializations;
      final sortedSpecs =
          specs.isEmpty
                ? <MySpecialization>[]
                : List<MySpecialization>.from(specs)
            ..sort(
              (a, b) => (a.position ?? 999999).compareTo(b.position ?? 999999),
            );

      return _DocResult(
        docId: doc.id,
        detail: detail,
        specializations: sortedSpecs,
        categoryId: detail.data.categoryId,
      );
    }),
  );

  // 3. Группируем
  final detailList = <UslugaDetailInfo>[];
  final specMap = <int, List<MySpecialization>>{};

  for (final r in results) {
    detailList.add(r.detail);
    specMap[r.docId] = r.specializations;
  }

  return CombinedUslugaData(
    uslugaDetailInfo: {categoryId: detailList},
    uslugaSpecialization: specMap,
  );
});

class _DocResult {
  final int docId;
  final UslugaDetailInfo detail;
  final List<MySpecialization> specializations;
  final int categoryId;
  _DocResult({
    required this.docId,
    required this.detail,
    required this.specializations,
    required this.categoryId,
  });
}

class _DocResultForSpecialization {
  final int docId;
  final List<MySpecialization> specializations;
  final int categoryId;
  _DocResultForSpecialization({
    required this.docId,
    required this.specializations,
    required this.categoryId,
  });
}

final requirementsProvider =
    FutureProvider.family<List<Requirement>, (int docId, int specId)>((
      ref,
      params,
    ) async {
      final repo = CategoryService();
      final docId = params.$1;
      final specId = params.$2;

      final reqModel = await repo.getSubcategsRequiremnetsByDocumentId(
        docId,
        specId,
      );
      return reqModel.data.requirements
        ..sort((a, b) => a.position!.compareTo(b.position!));
    });
