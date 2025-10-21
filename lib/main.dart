import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_enter_page.dart';
import 'package:khizmat_new/feature/home/presentation/pages/home_page.dart';
import 'package:khizmat_new/generated/l10n.dart';
import 'package:khizmat_new/qr_main_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final localProvider=ref.watch(localeProvider);
    return MaterialApp(
      locale: localProvider ?? Locale('ru'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: MainEnterPage(),
    );
  }
}
