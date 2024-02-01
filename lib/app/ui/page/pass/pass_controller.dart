import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
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
          onNavigationRequest: (NavigationRequest request) async {
            logger.i(request.url);
            // 2 채널이용
            if (!request.url.startsWith('http') &&
                !request.url.startsWith('https')) {
              if (Platform.isAndroid) {
                return NavigationDecision.prevent;
              } else if (Platform.isIOS) {
                if (await canLaunchUrl(Uri.parse(request.url))) {
                  await launchUrl(
                    Uri.parse(request.url),
                  );

                  return NavigationDecision.prevent;
                }
              }
            }

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
