import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class IntensityNotiController extends BaseController {
  final physicalSlider = 0.0.obs;

  final sportsSlider = 0.0.obs;

  /// 피지컬 슬라이더 변경.
  void onPhysicalSliderChanged(double value) {
    physicalSlider.value = value.clamp(0, 10);
  }

  /// 피지컬 슬라이더 변경.
  void onSportsSliderChanged(double value) {
    sportsSlider.value = value.clamp(0, 10);
  }
}
