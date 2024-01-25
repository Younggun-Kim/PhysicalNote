import 'package:flutter/services.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';

class MuscleUtils {
  /// Svg 파일 문자열로 업로드.
  static Future<String> loadSvgFile(String asset) async {
    return await rootBundle.loadString(asset);
  }

  /// Svg Path 색상 변경. - Path가 한줄일 때
  /// 주의 사항
  /// - <path>...</path>는 1줄로 구성.
  /// - color 는 hexCode 사용.
  static String changeSvgPathColor(
      String svgString, String pathId, String color) {
    var svgList = svgString.split("\n");

    var newList = _changeMuscleColor(svgList, pathId, color);
    newList = _changeMuscleNameColor(newList, pathId);
    newList = _changeMuscleLineColor(newList, pathId);

    return newList.join("\n");
  }

  /// 근육 색상 업데이트.
  static List<String> _changeMuscleColor(
      List<String> svgList, String pathId, String color) {
    return svgList.map((svg) {
      if (svg.contains('id="$pathId"')) {
        final colorIndex = svg.indexOf('fill="#');

        if (colorIndex == -1) {
          return svg;
        }

        final startIndex = colorIndex + 7;
        final endIndex = colorIndex + 13;
        final colorChangedPath = svg.replaceRange(startIndex, endIndex, color);
        return colorChangedPath;
      }

      return svg;
    }).toList();
  }

  /// 근육명 색상 업데이트.
  static List<String> _changeMuscleNameColor(
      List<String> svgList, String pathId) {
    return svgList.map((svg) {
      if (svg.contains('id="${pathId}Name"')) {
        final colorIndex = svg.indexOf('fill="#');

        if (colorIndex == -1) {
          return svg;
        }

        final startIndex = colorIndex + 7;
        final endIndex = colorIndex + 13;
        final colorChangedPath =
            svg.replaceRange(startIndex, endIndex, "000000");
        return colorChangedPath;
      }

      return svg;
    }).toList();
  }

  /// 근육 라인 색상 업데이트.
  static List<String> _changeMuscleLineColor(
      List<String> svgList, String pathId) {
    return svgList.map((svg) {
      if (svg.contains('id="${pathId}Line"')) {
        final colorIndex = svg.indexOf('fill="#');

        if (colorIndex == -1) {
          return svg;
        }

        final startIndex = colorIndex + 7;
        final endIndex = colorIndex + 13;
        final colorChangedPath =
            svg.replaceRange(startIndex, endIndex, "000000");
        return colorChangedPath;
      }

      return svg;
    }).toList();
  }

  /// 사람 근육 색칠하기.
  static String setHumanMuscleColor(
    List<HomeInjuryCheckItemUiState> list,
    String originImage,
    bool isFront,
  ) {
    if (list.isEmpty) {
      return originImage;
    }

    final direction = isFront
        ? InjuryCheckDirectionType.front
        : InjuryCheckDirectionType.back;
    final List<HomeInjuryCheckItemUiState> filteredImages =
        list.where((element) => element.direction == direction).toList();

    if (filteredImages.isEmpty) {
      return originImage;
    }

    var svgString = originImage;

    for (var element in filteredImages) {
      final color = element.injuryLevelType?.toInjuryLevelColor();
      final bodyPart = element.bodyPart?.serverKey;
      final muscleType = element.muscleType?.serverKey;

      if (color == null || bodyPart == null || muscleType == null) {
      } else {
        var pathId = "${bodyPart}_$muscleType".toLowerCase();

        /// 둔근은 하나로 되어 있음.
        if (element.muscleType == MuscleType.gluteus) {
          pathId = muscleType.toLowerCase();
        }

        svgString = changeSvgPathColor(
          svgString,
          pathId,
          color,
        );
      }
    }

    return svgString;
  }
}
