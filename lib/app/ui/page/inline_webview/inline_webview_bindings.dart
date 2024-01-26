import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/inline_webview/inline_webview.dart';

class InlineWebviewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InlineWebviewController());
  }
}