import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/repos/all_updated_date_service.dart';

final allUpdatedDateProvider = FutureProvider((ref) async {
  final repo = AllUpdatedDateService();
  return await repo.getAllInformation();
});
