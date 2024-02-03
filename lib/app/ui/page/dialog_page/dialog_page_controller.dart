import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/dialog_page/dialog_page_args.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class DialogPageController extends BaseController {
  final args = Get.arguments as DialogPageArgs;

  late final text = args.text;

  late final yesText = args.yesText;

  late final noText = args.noText;

  /// Yes 버튼 클릭.
  void onPressedYes() {
    final yes = args.onPressedYes();
    close(result: yes);
  }

  /// No 버튼 클릭.
  void onPressedNo() {
    final no = args.onPressedNo();
    close(result: no);
  }
}
