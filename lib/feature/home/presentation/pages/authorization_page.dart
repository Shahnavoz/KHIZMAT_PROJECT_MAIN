import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class AuthService {
  Future<String> getAuthUrl() async {
    final uri = Uri.parse('http://oauth.egov.tj/sso/oauth/Authorization.do')
        .replace(queryParameters: {
      'response_type': 'code',
      'client_id': 'zaks',
      'redirect_uri': 'https://dc.tj',
      'scope': 'zaks',
      'state': _generateState(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['code'] == 200 && data['message'] == 'success') {
        return data['url']; // возвращает готовый URL с токеном
      }
      throw Exception('Ошибка сервера: ${data['message']}');
    }
    throw Exception('HTTP ошибка: ${response.statusCode}');
  }

  // Генерация случайного state для защиты от CSRF
  String _generateState() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return timestamp.hashCode.toRadixString(16);
  }
}

class AuthWebView extends StatefulWidget {
  final String authUrl;
  const AuthWebView({required this.authUrl, super.key});

  @override
  State<AuthWebView> createState() => _AuthWebViewState();
}

class _AuthWebViewState extends State<AuthWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          // Перехватываем редирект на redirect_uri
          if (request.url.startsWith('https://dc.tj')) {
            final uri = Uri.parse(request.url);
            final code = uri.queryParameters['code'];

            if (code != null) {
              // Возвращаем код авторизации обратно
              Navigator.pop(context, code);
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (url) => debugPrint('Загрузка: $url'),
      ))
      ..loadRequest(Uri.parse(widget.authUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Вход через IMZO'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}