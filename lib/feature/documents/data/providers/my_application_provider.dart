import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/documents/data/repos/my_application_service.dart';

final applicationProvider = FutureProvider((ref) async {
  final repo = MyApplicationService();
  return await repo.getApplications();
});
