import 'package:flutter/material.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class NaverLoginController extends BaseController {
  late final webViewController;

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
      ..clearCache()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            logger.i("onPageStarted: $url");
          },
          onPageFinished: (String url) {
            logger.i("onPageFinished: $url");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) async {
            final url = change.url;
            if (url != null &&
                url.contains("${Constants.naverRedirectUrl}?code=") == true) {
              var result =
                  url.replaceAll("${Constants.naverRedirectUrl}?code=", "");

              var uri = Uri.parse(url);

              logger.i("result: ${uri.queryParameters["code"]}");
              webViewController.clearCache();
              close(result: result);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=ni1NgxkxZL4C9rRQxoed&redirect_uri=https://dev.hajinj.com/login&state=${DateTime.now().millisecond}"));

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }
}
