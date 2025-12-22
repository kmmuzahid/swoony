import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

@RoutePage()
class PaymentWebView extends StatefulWidget {
  const PaymentWebView({
    required this.checkoutUrl,
    required this.onCancel,
    required this.onSuccess,
    super.key,
    this.onFailed,
  });
  final String checkoutUrl; // The URL to load (payment URL)
  final Function onSuccess; // Callback for successful payment
  final Function onCancel; // Callback for canceled payment
  final void Function(String url)? onFailed;

  @override
  // ignore: library_private_types_in_public_api
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController _controller;
  final DioService dioService = getIt();

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            if (url.contains('/payment/cancel')) {
              Navigator.pop(context);
            }
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // if (url.contains('/payment/payment-success')) {
            //   widget.onSuccess();
            // }
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains('/payment/payment-success') ||
                request.url.contains('/payment/success') ||
                request.url.contains('stripe/success')) {
              widget.onSuccess();
              // final uri = Uri.parse(request.url);
              // final responce = await dioService.request(
              //   input: RequestInput(
              //     endpoint: '${uri.path}?${(uri.query.isNotEmpty ? '${uri.query}' : '')}',
              //     method: RequestMethod.GET,
              //   ),
              //   responseBuilder: (data) => data,
              // );
              // AppLogger.debug(responce.data.toString(), tag: 'Payment webview');
              // if (responce.statusCode == 200) {
              //   widget.onSuccess();
              // } else {
              //   widget.onCancel();
              // }
              return NavigationDecision.prevent; // stop current HTTP load
            } else if (request.url.contains('/payment/refresh')) {
              widget.onFailed?.call(request.url);
            }

            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: '',
        actions: const [],
        backgroundColor: AppColors.backgroundWhite,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.webViewController, super.key});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('No back history item')));
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('No forward history item')));
              }
            }
          },
        ),
        IconButton(icon: const Icon(Icons.replay), onPressed: webViewController.reload),
      ],
    );
  }
}
