import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/test/model/muscle_path.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

import 'model/muscle_data.dart';

class TestController extends BaseController {
  var muscleList = musclePath
      .asMap()
      .map((i, path) {
        return MapEntry(i, MuscleData(id: i, path: path, isSelected: false));
      })
      .values
      .obs;

  void onPressedMuscle(MuscleData data) {
    final newList = muscleList.value.map((e) {
      if (e.id == data.id) {
        e.isSelected = !e.isSelected;
      }
      return e;
    });

    muscleList.value = newList;
  }
}
