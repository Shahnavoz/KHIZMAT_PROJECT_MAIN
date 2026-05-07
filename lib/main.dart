import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/themes/themes.dart';
import 'package:khizmat_new/deeplink/auth_provider.dart';
import 'package:khizmat_new/deeplink/deeplink_provider.dart';
import 'package:khizmat_new/deeplink/stateModel.dart';
import 'package:khizmat_new/feature/authorization/presentation/pages/main_enter_page.dart';
import 'package:khizmat_new/feature/bottomNavBar/presentation/pages/bottom_nav_page.dart';
import 'package:khizmat_new/consts/shimmers/home_page_shimmer.dart';
import 'package:khizmat_new/feature/home/presentation/widgets/notification_page.dart';
import 'package:khizmat_new/core/navigation/navigator_key.dart';
import 'package:khizmat_new/generated/l10n.dart';
import 'package:pdfrx/pdfrx.dart';

void main() async {
  // ensureInitialized must be first — plugins cannot touch the engine before this.
  WidgetsFlutterBinding.ensureInitialized();
  await pdfrxFlutterInitialize(dismissPdfiumWasmWarnings: true);
  await initNotifications();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authProvider.notifier).checkToken());
  }

  // Future<void> _initDeepLinks() async {
  //   // ── Cold start: app launched via deep link ────────────────────────────
  //   // getInitialLink() returns the URI that opened the app (null if opened normally).
  //   try {
  //     final uri = await _appLinks.getInitialLink();
  //     if (uri != null) _handleIncomingLink(uri);
  //   } catch (_) {}

  //   // ── App already running (foreground/background): new deep link arrives ─
  //   _appLinks.uriLinkStream.listen(
  //      _handleIncomingLink,
  //     onError: (_) {},
  //   );
  // }

  // /// Called whenever the app receives a deep link.
  // /// Handles: khizmatapp://sso?code=CODE&state=STATE
  // void _handleIncomingLink(Uri uri) {
  //   debugPrint('[DeepLink] received: $uri');

  //   if (uri.scheme != 'khizmatapp') return;

  //   // SSO OAuth callback — host is "sso" or path starts with "/sso"
  //   final isSsoCallback = uri.host == 'sso' ||
  //       uri.path.startsWith('/sso') ||
  //       uri.queryParameters.containsKey('code');

  //   if (isSsoCallback) {
  //     final code = uri.queryParameters['code'];
  //     final state = uri.queryParameters['state'];
  //     if (code != null) {
  //       _exchangeSsoCode(code: code, state: state);
  //     }
  //   }
  // }
  // final storage=FlutterSecureStorage();

  // /// Sends the SSO code to YOUR OWN backend.
  // /// Backend verifies it with the SSO provider and returns your app's token.
  // Future<void> _exchangeSsoCode({
  //   required String code,
  //   String? state,
  // }) async {
  //   try {
  //     // Show loading indicator while exchanging the code
  //     _showLoading(true);

  //     // POST the received code to your own backend.
  //     // Your backend verifies it with the SSO provider and returns your token.
  //     final recievedToken=storage.read(key: 'token');
  //     final response = await http.post(
  //       Uri.parse('https://api.ekhizmat.tj/v1/oauth/sso/access_token'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $recievedToken',
  //       },
  //       body: jsonEncode({
  //         'code': code,
  //         if (state != null) 'state': state,
  //       }),
  //     );

  //     _showLoading(false);

  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);

  //       // Your backend returns the same shape as email login:
  //       // { "data": { "token": { "access_token": "..." } } }
  //       final token = json['data']?['token']?['access_token'] ??
  //           json['data']?['access_token'] ??
  //           json['access_token'];

  //       if (token != null) {
  //         await FlutterSecureStorage().write(key: 'token', value: token);
  //         _navigateToHome();
  //       } else {
  //         _showError('Токен не найден в ответе сервера');
  //       }
  //     } else {
  //       final body = jsonDecode(response.body);
  //       final msg = body['message'] ?? 'Ошибка ${response.statusCode}';
  //       _showError('Ошибка авторизации: $msg');
  //     }
  //   } catch (e) {
  //     _showLoading(false);
  //     _showError('Ошибка соединения: $e');
  //   }
  // }

  // void _showLoading(bool value) {
  //   if (!mounted) return;
  //   final ctx = navigatorKey.currentContext;
  //   if (ctx == null) return;
  //   if (value) {
  //     showDialog(
  //       context: ctx,
  //       barrierDismissible: false,
  //       builder: (_) => const PopScope(
  //         canPop: false,
  //         child: Center(child: CircularProgressIndicator()),
  //       ),
  //     );
  //   } else {
  //     navigatorKey.currentState?.pop();
  //   }
  // }

  // void _navigateToHome() {
  //   navigatorKey.currentState?.pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (_) => const BottomNavPage()),
  //     (_) => false,
  //   );
  // }

  // void _showError(String message) {
  //   final ctx = navigatorKey.currentContext;
  //   if (ctx == null) return;
  //   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  // }

  @override
  Widget build(BuildContext context) {
    final localProvider = ref.watch(localeProvider);

     ref.watch(deepLinkProvider);
    ref.listen<AuthState>(authProvider, (prev, next) {
      if (next.status == AuthStatus.loading &&
          prev?.status == AuthStatus.initial) {
        // Deeplink auth started from login screen — show spinner immediately
        // so the user never sees the login UI during the SSO flow.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: HomePageShimmer(),
              ),
            ),
            (_) => false,
          );
        });
      } else if (next.status == AuthStatus.success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const BottomNavPage()),
            (_) => false,
          );
        });
      } else if (next.status == AuthStatus.initial &&
          prev?.status != AuthStatus.initial) {
        // Logout: clear the stack and go back to login screen.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainEnterPage()),
            (_) => false,
          );
        });
      } else if (next.status == AuthStatus.error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (prev?.status == AuthStatus.loading) {
            // Deeplink auth failed — go back to login screen first.
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainEnterPage()),
              (_) => false,
            );
          }
          // Show the error after navigation settles.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final ctx = navigatorKey.currentContext;
            if (ctx != null) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(
                    'Ошибка авторизации: ${next.error ?? 'Неизвестная ошибка'}',
                  ),
                ),
              );
            }
          });
        });
      }
    });
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: localProvider,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const MainEnterPage(),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
