import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  /// 페이지 초기화 상태.
  final isInitialized = false.obs;

  /// 로딩 상태.
  final isLoading = false.obs;

  /// 페이지 초기화 상태 변경.
  void setInitialized(bool isInitialized) {
    this.isInitialized.value = isInitialized;
  }

  /// 로딩 상태 변경.
  void setLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  /// 종료.
  void close<T>({T? result}) {
    Get.back<T>(result: result);
  }
}
