
import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/ui_state.dart';

abstract class BaseMainController<T extends UiState> extends GetxController {
  /// ui 상태.
  abstract final Rx<T> uiState;

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
  // ignore: avoid_shadowing_type_parameters
  void close<T>({T? result}) {
    Get.back<T>(result: result);
  }
}
