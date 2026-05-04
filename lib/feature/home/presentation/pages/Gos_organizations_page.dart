import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_question_page.dart';
import 'package:khizmat_new/feature/home/data/models/all_organizations_model.dart';
import 'package:khizmat_new/feature/home/data/models/each_organizations_services.dart';
import 'package:khizmat_new/feature/home/data/providers/all_updated_date_provider.dart';
import 'package:khizmat_new/feature/home/data/providers/organizations_provider.dart';
import 'package:khizmat_new/feature/home/presentation/pages/usluga_info_page.dart';
import 'package:khizmat_new/generated/l10n.dart';

// ── Organizations list ────────────────────────────────────────────────────────

class GosOrganizationsPage extends ConsumerStatefulWidget {
  const GosOrganizationsPage({super.key});

  @override
  ConsumerState<GosOrganizationsPage> createState() =>
      _GosOrganizationsPageState();
}

class _GosOrganizationsPageState extends ConsumerState<GosOrganizationsPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _orgName(Datum org, Locale locale) {
    if (locale.languageCode == 'ru') return org.nameRu;
    if (locale.languageCode == 'fr') return org.nameTj;
    return org.nameEn;
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final locale = ref.watch(localeProvider);
    final asyncOrgs = ref.watch(allOrganizationsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: greyTextFBorderColor,
        elevation: 0,
        backgroundColor: Colors.white,
        title: textWithH1Style(
          S.of(context).gosOrganizations,
          fontW: FontWeight.w500,
          color: Colors.black,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            MyTextFieldWithPrefix(
              onTap: () {},
              hintText: S.of(context).searchOrganization,
              controller: _searchController,
              backGroundColor: Colors.white,
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: asyncOrgs.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (model) {
                  final orgs =
                      _query.isEmpty
                          ? model.data
                          : model.data
                              .where(
                                (o) => _orgName(
                                  o,
                                  locale,
                                ).toLowerCase().contains(_query),
                              )
                              .toList();

                  if (orgs.isEmpty) {
                    return Center(
                      child: Text(
                        S.of(context).notFoundOrgs,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    );
                  }

                  return ListView.builder(
                    key: ValueKey(_query),
                    itemCount: orgs.length,
                    itemBuilder: (context, index) {
                      final org = orgs[index];
                      return _OrgCard(
                        org: org,
                        name: _orgName(org, locale),
                        size: size,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrgCard extends StatelessWidget {
  final Datum org;
  final String name;
  final AdaptiveSizes size;

  const _OrgCard({required this.org, required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrgServicesPage(orgId: org.id, orgName: name),
            ),
          ),
      child: Container(
        margin: EdgeInsets.only(bottom: size.otstup10),
        padding: EdgeInsets.all(size.otstup15),
        decoration: BoxDecoration(
          border: Border.all(color: greyTextFBorderColor),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  // width: 40,
                  // height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 153, 223, 193),
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      "assets/icons/image 15.png",
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => const Icon(
                            Icons.account_balance,
                            color: primaryButtonColor,
                            size: 20,
                          ),
                    ),
                  ),
                ),

                SizedBox(width: size.otstup15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryGreenColor, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          S.of(context).orgdocumentscount(org.documentsCount),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Container(
                //   width: 44,
                //   height: 44,
                //   decoration: BoxDecoration(
                //     color: primaryButtonColor,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: const Icon(Icons.account_balance, color: Colors.white),
                // ),
              ],
            ),
            SizedBox(height: size.otstup15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.otstup5),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.check_circle_outline,
                //       size: 14,
                //       color: Colors.green,
                //     ),
                //     const SizedBox(width: 4),
                //     Text(
                //       S.of(context).orgdocumentscount(org.documentsCount),
                //       style: const TextStyle(
                //         fontSize: 12,
                //         color: Colors.green,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            // const Icon(
            //   Icons.arrow_forward_ios,
            //   size: 14,
            //   color: primaryButtonColor,
            // ),
          ],
        ),
      ),
    );
  }
}

// ── Single organization services ──────────────────────────────────────────────

class OrgServicesPage extends ConsumerStatefulWidget {
  final int orgId;
  final String orgName;

  const OrgServicesPage({
    super.key,
    required this.orgId,
    required this.orgName,
  });

  @override
  ConsumerState<OrgServicesPage> createState() => _OrgServicesPageState();
}

class _OrgServicesPageState extends ConsumerState<OrgServicesPage> {
  // Tracks which doc ID is currently loading so we show a per-item spinner.
  int? _loadingDocId;

  String _docName(Document doc, Locale locale) {
    if (locale.languageCode == 'ru') return doc.nameRu;
    if (locale.languageCode == 'fr') return doc.nameTj;
    return doc.nameEn;
  }

  Future<void> _openService(Document doc, Locale locale) async {
    if (_loadingDocId != null) return;
    setState(() => _loadingDocId = doc.id);
    try {
      final model = await ref.read(
        combinedUslugaDataProvider(doc.categoryId).future,
      );
      final infoList = model.uslugaDetailInfo[doc.categoryId] ?? [];
      final idx = infoList.indexWhere((u) => u.data.document.id == doc.id);
      if (idx != -1 && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => UslugaInfoPage(
                  uslugaInfo: infoList[idx],
                  specializations: const [],
                  requirements: const [],
                  index: idx,
                  categoryId: doc.categoryId,
                  doc: infoList[idx].data.document,
                ),
          ),
        );
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingDocId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final locale = ref.watch(localeProvider);
    final asyncServices = ref.watch(orgServicesProvider(widget.orgId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.orgName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
      ),
      body: asyncServices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (model) {
          final docs = model.data.documents;
          if (docs.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noServices,
                style: TextStyle(color: Colors.grey[500]),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup15,
              vertical: size.otstup10,
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final isLoading = _loadingDocId == doc.id;
              return GestureDetector(
                onTap: () => _openService(doc, locale),
                child: Container(
                  margin: EdgeInsets.only(bottom: size.otstup10),
                  padding: EdgeInsets.all(size.otstup15),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyTextFBorderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          doc.icon,
                          errorBuilder:
                              (_, __, ___) => const Icon(
                                Icons.description,
                                color: primaryButtonColor,
                              ),
                        ),
                      ),
                      SizedBox(width: size.otstup10),
                      Expanded(
                        child: Text(
                          _docName(doc, locale),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: primaryButtonColor,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
