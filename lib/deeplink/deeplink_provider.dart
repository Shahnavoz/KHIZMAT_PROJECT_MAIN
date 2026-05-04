import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/core/navigation/navigator_key.dart';
import 'package:khizmat_new/deeplink/auth_provider.dart';
import 'package:khizmat_new/feature/bottomNavBar/presentation/pages/bottom_nav_page.dart';
import 'package:khizmat_new/feature/documents/presentation/pages/my_documents_page.dart';
import 'package:khizmat_new/feature/documents/presentation/widgets/my_application_detail_page.dart';

final deepLinkProvider = Provider((ref) {
  return DeepLinkService(ref);
});

class DeepLinkService {
  final Ref ref;
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  bool _isHandling = false;
  final Set<String> _handledCodes = {};

  DeepLinkService(this.ref) {
    _init();
  }

  Future<void> _init() async {
    final initialUri  = await _appLinks.getInitialLink();

    if (initialUri != null) {
      await _handleUri(initialUri);
    }

    _sub = _appLinks.uriLinkStream.listen((uri) async {
      await _handleUri(uri);
    });
  }

  Future<void> _handleUri(Uri uri) async {
    if (uri.scheme != 'khizmatapp') return;

    switch (uri.host) {
      case 'sso':
        await _handleSso(uri);
        break;
      case 'payment':
      case 'application':
        _navigateToApplication(uri);
        break;
    }
  }

  // khizmatapp://sso?code=CODE&state=STATE
  Future<void> _handleSso(Uri uri) async {
    final code = uri.queryParameters['code'];
    final stateParam = uri.queryParameters['state'];

    if (code == null || code.isEmpty) return;
    if (_handledCodes.contains(code)) return;
    if (_isHandling) return;

    _isHandling = true;
    _handledCodes.add(code);

    try {
      await ref.read(authProvider.notifier).handleDeepLink(code, stateParam);
    } catch (e) {
      _handledCodes.remove(code);
    } finally {
      _isHandling = false;
    }
  }

  // khizmatapp://payment?application_id=123
  // khizmatapp://application?id=123
  void _navigateToApplication(Uri uri) {
    final idStr = uri.queryParameters['application_id'] ??
        uri.queryParameters['id'];
    final appId = int.tryParse(idStr ?? '');
    if (appId == null) return;

    final locale = ref.read(localeProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BottomNavPage()),
        (_) => false,
      );
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => MyDocumentsPage(selectedIndex: 1, document: const []),
        ),
      );
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => MyApplicationInReviewDetailPage(
            id: appId,
            currentLocale: locale,
          ),
        ),
      );
    });
  }

  Future<void> dispose() async {
    await _sub?.cancel();
  }
}

// class DeepLinkService {
//   final Ref ref;
//   final AppLinks _appLinks = AppLinks();
//   StreamSubscription<Uri>? _sub;

//   DeepLinkService(this.ref) {
//     _init();
//   }

//   Future<void> _init() async {
//     // ✅ правильный метод
//     final uri = await _appLinks.getInitialLink();

//     if (uri != null) {
//       _handleUri(uri);
//     }

//     _sub = _appLinks.uriLinkStream.listen((uri) {
//       _handleUri(uri);
//     });
//   }

//   void _handleUri(Uri uri) {
//     print("FULL URI: $uri");
//     final code = uri.queryParameters['code'];
//     final stateParam = uri.queryParameters['state'];
//     print("CODE: $code");
//     print("STATE: $stateParam");

//     if (code != null) {
//       ref.read(authProvider.notifier).handleDeepLink(code, stateParam);
//     }
//   }
// }
