import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/inline_webview/inline_webview_args.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InlineWebviewController extends BaseController {
  final args = Get.arguments as InlineWebviewArgs;

  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()..loadHtmlString(args.html);
  }
}
