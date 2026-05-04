import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/feature/profile/data/repos/private_policy_service.dart';

class PrivatePolicyPage extends ConsumerStatefulWidget {
  const PrivatePolicyPage({super.key});

  @override
  ConsumerState<PrivatePolicyPage> createState() => _PrivatePolicyPageState();
}

class _PrivatePolicyPageState extends ConsumerState<PrivatePolicyPage> {
  late final Future<PrivatePolicyData> _future;

  @override
  void initState() {
    super.initState();
    _future = PrivatePolicyService().fetchPolicy();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = ref.watch(localeProvider).languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Политика конфиденциальности',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<PrivatePolicyData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryButtonColor),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          final data = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Html(
              data: data.description(languageCode),
              extensions: [TableHtmlExtension()],
              style: {
                'h1': Style(margin: Margins.symmetric(vertical: 4)),
                'h2': Style(margin: Margins.symmetric(vertical: 4)),
                'h3': Style(margin: Margins.symmetric(vertical: 4)),
                'h4': Style(margin: Margins.symmetric(vertical: 4)),
                'h5': Style(margin: Margins.symmetric(vertical: 4)),
                'h6': Style(margin: Margins.symmetric(vertical: 4)),
                'p':  Style(margin: Margins.symmetric(vertical: 4)),
                'table': Style(border: Border.all(color: Colors.grey)),
                'td': Style(
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.symmetric(horizontal: 8, vertical: 4),
                ),
                'th': Style(
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.symmetric(horizontal: 8, vertical: 4),
                  fontWeight: FontWeight.bold,
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
