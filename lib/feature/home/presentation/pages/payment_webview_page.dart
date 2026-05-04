import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

/// Opens the payment provider's page in a WebView.
///
/// Flow:
///  1. WebView loads [url] (invoice page from the backend).
///  2. User completes payment in the WebView (or gets redirected to external app).
///  3. Provider redirects back to [redirectUri]?token=TOKEN.
///  4. We intercept that redirect, extract the token, POST it to [callbackEndpoint]
///     on our backend for confirmation.
///  5. WebView closes — pops `true` on success, `false` on failure/cancel.
class PaymentWebViewPage extends StatefulWidget {
  final String url;

  /// URI that the payment provider redirects to after payment.
  /// Must match what was sent to the provider in the invoice request.
  final String redirectUri;

  /// Our backend endpoint that receives the token for confirmation.

  final String? serial;

  const PaymentWebViewPage({
    super.key,
    required this.url,
    required this.redirectUri,
    this.serial,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) {
          if (mounted) setState(() => _isLoading = true);
        },
        onPageFinished: (_) {
          if (mounted) setState(() => _isLoading = false);
        },
        onNavigationRequest: (request) {
          // Intercept the redirect from the other app back to our redirect URI.
          // The other app appends ?token=TOKEN to the URI after completing its flow.
          if (request.url.startsWith(widget.redirectUri)) {
            final uri = Uri.parse(request.url);
            final token = uri.queryParameters['token'];
            if (token != null && token.isNotEmpty) {
              _sendTokenToBackend(token);
            } else {
              if (mounted) Navigator.pop(context, false);
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  /// Takes the token received via the redirect URI and forwards it to our backend.
  Future<void> _sendTokenToBackend(String token) async {
    if (!mounted) return;
    setState(() => _isConfirming = true);

    try {
      const storage = FlutterSecureStorage();
      final authToken = await storage.read(key: 'token');

      // final response = await http.post(
      //   Uri.parse(widget.callbackEndpoint),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     if (authToken != null) 'Authorization': 'Bearer $authToken',
      //   },
      //   body: jsonEncode({
      //     'token': token,
      //     if (widget.serial != null) 'serial': widget.serial,
      //     if (widget.applicationId != null)
      //       'application_id': widget.applicationId,
      //   }),
      // );

      // if (!mounted) return;
      // if (response.statusCode == 200) {
      //   Navigator.pop(context, true);
      // } else {
      //   final body = jsonDecode(response.body) as Map<String, dynamic>? ?? {};
      //   final msg = body['message'] as String? ?? 'Ошибка ${response.statusCode}';
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      //   Navigator.pop(context, false);
      // }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ошибка соединения: $e')));
        Navigator.pop(context, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text('Оплата', style: TextStyle(color: Colors.black)),
      //   leading: IconButton(
      //     icon: const Icon(Icons.close, color: Colors.black),
      //     onPressed: () => Navigator.pop(context, false),
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading || _isConfirming)
              Container(
                color: Colors.white.withValues(alpha: 0.8),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
