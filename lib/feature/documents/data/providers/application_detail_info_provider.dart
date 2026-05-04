import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/documents/data/models/my_application_detail_info_page.dart';
import 'package:khizmat_new/feature/documents/data/repos/my_applications_detail_info_service.dart';

final applicationDetailInfoProvider = FutureProvider.family<MyApplicationDetailModel,int>((ref,id) async {
  final repo = MyApplicationsDetailInfoService();
  return await repo.getApplicationsDetailInfo(id);
});
