import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/inline_webview/inline_webview.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InlineWebviewPage extends GetView<InlineWebviewController> {
  const InlineWebviewPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: WebViewWidget(
                controller: controller.webViewController,
              ),
            ),
          ],
        ),
      );
}

/// 헤더.
class _Header extends GetView<InlineWebviewController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.close,
      );
}
