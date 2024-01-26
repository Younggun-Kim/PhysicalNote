import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OutLink extends GetxService {
  /// url 실행.
  Future<bool> moveUrl(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      return await launchUrlString(
        Uri.encodeFull(url),
        mode: mode,
      );
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  /// 전화걸기..
  Future<bool> moveDial({required String number}) {
    final url = "tel:$number";
    return moveUrl(url);
  }

  /// 개인정보 처리 방침 약관.
  Future<bool> movePrivacyTerm() async {
    return moveUrl("https://www.naver.com");
  }

  /// 이용약관 동의.
  Future<bool> moveServiceTerm() async {
    return moveUrl("https://www.google.com");
  }

  /// 카메라.
  Future<XFile?> moveCamera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }
}
