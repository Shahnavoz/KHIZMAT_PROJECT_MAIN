import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/core/config/app_config.dart';
import 'package:khizmat_new/core/network/api_client.dart';
import 'package:khizmat_new/feature/home/data/models/all_organizations_model.dart';
import 'package:khizmat_new/feature/home/data/models/each_organizations_services.dart';

final allOrganizationsProvider = FutureProvider<AllOrganizationsModel>((ref) async {
  final client = ApiClient();
  final body = await client.get(AppConfig.openSourceOrganizations);
  return AllOrganizationsModel.fromJson(body);
});

final orgServicesProvider =
    FutureProvider.family<EachOrganizationsServicesModel, int>((ref, orgId) async {
  final client = ApiClient();
  final body = await client.get(AppConfig.openSourceOrganizationById(orgId));
  return EachOrganizationsServicesModel.fromJson(body);
});
