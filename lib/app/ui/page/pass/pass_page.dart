import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/pass/pass.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PassPage extends GetView<PassController> {
  const PassPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: WebViewWidget(
          controller: controller.webViewController,
        ),
      );
}
