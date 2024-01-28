import 'package:flutter/material.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PassController extends BaseController {
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setOnConsoleMessage((message) {
        logger.w("Pass webview: ${message.message}");

        if (message.message.contains("passVerify")) {
          var token = message.message.replaceAll("passVerify(", "");
          token = token.replaceAll(")", "");
          close(result: token);
        }
      })
      ..loadRequest(Uri.parse(Constants.PASS_URL));

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }
}
