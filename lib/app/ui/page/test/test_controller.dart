import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
import 'package:physical_note/app/ui/page/test/model/muscle_path.dart';
import 'package:physical_note/app/utils/utils.dart';

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

  var svgString = "".obs;

  @override
  void onInit() async {
    super.onInit();

    final svgFile = await loadSvgFile();
    final changedSvg = changeSvgPathColor(svgFile, "path1", "ff1122");
    svgString.value = changedSvg;
  }

  /// SVG 파일 로드.
  Future<String> loadSvgFile() async {
    return await rootBundle.loadString(Assets.muscleFrontArmRight);
  }

  /// Svg Path 색상 변경. - Path가 한줄일 때
  String changeSvgPathColor(String svgString, String pathId, String color) {
    var svgList = svgString.split("\n");

    logger.i(svgList);
    var pathIndex =
        svgList.indexWhere((element) => element.contains('id="$pathId"'));
    var pathString = svgList[pathIndex];
    var colorIndex = pathString.indexOf('fill="#');

    if (colorIndex == -1) {
      return "";
    }

    final startIndex = colorIndex + 7;
    final endIndex = colorIndex + 13;
    final colorChangedPath =
        pathString.replaceRange(startIndex, endIndex, color);
    svgList[pathIndex] = colorChangedPath;

    return svgList.join("\n");
  }
}
