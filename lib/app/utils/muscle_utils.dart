import 'package:flutter/services.dart';
import 'package:physical_note/app/config/constant/body_part_type.dart';
import 'package:physical_note/app/config/constant/distinction_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
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

  /// 근육 부분 이미지 가져오기
  static String? getMusclePartAsset(
    MuscleType? muscle,
    DistinctionType? direction,
    BodyPartsType? bodyPart,
  ) {
    if (muscle == null || direction == null || bodyPart == null) {
      return null;
    }

    if (direction == DistinctionType.front) {
      switch (bodyPart) {
        case BodyPartsType.body:
          switch (muscle) {
            case MuscleType.trapezius:
              return Assets.frontBodyTRAPEZIUS;
            case MuscleType.pectoralisMajor:
              return Assets.frontBodyPECTORALISMAJOR;
            case MuscleType.externalOblique:
              return Assets.frontBodyEXTERNALOBLIQUE;
            case MuscleType.rectusAbdominis:
              return Assets.frontBodyRECTUSABDOMINIS;
            default:
              return null;
          }
        case BodyPartsType.leftArm:
          switch (muscle) {
            case MuscleType.biceps:
              return Assets.frontLeftArmBICEPS;
            case MuscleType.brachialis:
              return Assets.frontLeftArmBRACHIALIS;
            case MuscleType.brachioradialis:
              return Assets.frontLeftArmBRACHIORADIALIS;
            case MuscleType.deltoid:
              return Assets.frontLeftArmDELTOID;
            case MuscleType.pronatorTeres:
              return Assets.frontLeftArmPRONATORTERES;
            case MuscleType.rotatorcuff:
              return Assets.frontLeftArmROTATORCUFF;
            case MuscleType.serratusAnterior:
              return Assets.frontLeftArmSERRATUSANTERIOR;
            case MuscleType.triceps:
              return Assets.frontLeftArmTRICEPS;
            default:
              return null;
          }
        case BodyPartsType.rightArm:
          switch (muscle) {
            case MuscleType.biceps:
              return Assets.frontRightArmBICEPS;
            case MuscleType.brachialis:
              return Assets.frontRightArmBRACHIALIS;
            case MuscleType.brachioradialis:
              return Assets.frontRightArmBRACHIORADIALIS;
            case MuscleType.deltoid:
              return Assets.frontRightArmDELTOID;
            case MuscleType.pronatorTeres:
              return Assets.frontRightArmPRONATORTERES;
            case MuscleType.rotatorcuff:
              return Assets.frontRightArmROTATORCUFF;
            case MuscleType.serratusAnterior:
              return Assets.frontRightArmSERRATUSANTERIOR;
            case MuscleType.triceps:
              return Assets.frontRightArmTRICEPS;
            default:
              return null;
          }
        case BodyPartsType.leftLeg:
          switch (muscle) {
            case MuscleType.tensorFasciaeLatae:
              return Assets.frontLeftLegTENSORFASCIAELATAE;
            case MuscleType.teresMajor:
              return Assets.frontLeftLegTERESMAJOR;
            case MuscleType.lateralGastrocnemius:
              return Assets.frontLeftLegLATERALGASTROCNEMIUS;
            case MuscleType.largeRetirement:
              return Assets.frontLeftLegLARGERETIREMENT;
            case MuscleType.semimembranosus:
              return Assets.frontLeftLegSEMIMEMBRANOSUS;
            case MuscleType.extensorDigitorumLongus:
              return Assets.frontLeftLegEXTENSORDIGITORUMLONGUS;
            case MuscleType.tibialisAnterior:
              return Assets.frontLeftLegTIBIALISANTERIOR;
            case MuscleType.peroneusBrevis:
              return Assets.frontLeftLegPERONEUSBREVIS;
            case MuscleType.extensorDigitorumBrevis:
              return Assets.frontLeftLegEXTENSORDIGITORUMBREVIS;
            case MuscleType.iliacus:
              return Assets.frontLeftLegILIACUS;
            case MuscleType.psoasMajor:
              return Assets.frontLeftLegPSOASMAJOR;
            case MuscleType.pubicus:
              return Assets.frontLeftLegPUBICUS;
            case MuscleType.adductorLongus:
              return Assets.frontLeftLegADDUCTORLONGUS;
            case MuscleType.adductorMagnus:
              return Assets.frontLeftLegADDUCTORMAGNUS;
            case MuscleType.soleus:
              return Assets.frontLeftLegSOLEUS;
            case MuscleType.medialGastrocnemius:
              return Assets.frontLeftLegMEDIALGASTROCNEMIUS;
            case MuscleType.peroneusLongus:
              return Assets.frontLeftLegPERONEUSLONGUS;
            case MuscleType.gracilis:
              return Assets.frontLeftLegGRACILIS;
            case MuscleType.sartorius:
              return Assets.frontLeftLegSARTORIUS;
            default:
              return null;
          }
        case BodyPartsType.rightLeg:
          switch (muscle) {
            case MuscleType.tensorFasciaeLatae:
              return Assets.frontRightLegTENSORFASCIAELATAE;
            case MuscleType.teresMajor:
              return Assets.frontRightLegTERESMAJOR;
            case MuscleType.lateralGastrocnemius:
              return Assets.frontRightLegLATERALGASTROCNEMIUS;
            case MuscleType.largeRetirement:
              return Assets.frontRightLegLARGERETIREMENT;
            case MuscleType.semimembranosus:
              return Assets.frontRightLegSEMIMEMBRANOSUS;
            case MuscleType.extensorDigitorumLongus:
              return Assets.frontRightLegEXTENSORDIGITORUMLONGUS;
            case MuscleType.tibialisAnterior:
              return Assets.frontRightLegTIBIALISANTERIOR;
            case MuscleType.peroneusBrevis:
              return Assets.frontRightLegPERONEUSBREVIS;
            case MuscleType.extensorDigitorumBrevis:
              return Assets.frontRightLegEXTENSORDIGITORUMBREVIS;
            case MuscleType.iliacus:
              return Assets.frontRightLegILIACUS;
            case MuscleType.psoasMajor:
              return Assets.frontRightLegPSOASMAJOR;
            case MuscleType.pubicus:
              return Assets.frontRightLegPUBICUS;
            case MuscleType.adductorLongus:
              return Assets.frontRightLegADDUCTORLONGUS;
            case MuscleType.adductorMagnus:
              return Assets.frontRightLegADDUCTORMAGNUS;
            case MuscleType.soleus:
              return Assets.frontRightLegSOLEUS;
            case MuscleType.medialGastrocnemius:
              return Assets.frontRightLegMEDIALGASTROCNEMIUS;
            case MuscleType.peroneusLongus:
              return Assets.frontRightLegPERONEUSLONGUS;
            case MuscleType.gracilis:
              return Assets.frontRightLegGRACILIS;
            case MuscleType.sartorius:
              return Assets.frontRightLegSARTORIUS;
            default:
              return null;
          }
        default:
          return null;
      }
    } else {
      switch (bodyPart) {
        case BodyPartsType.body:
          switch (muscle) {
            case MuscleType.oblique:
              return Assets.backBodyOBLIQUE;
            case MuscleType.quadratusLumborum:
              return Assets.backBodyQUADRATUSLUMBORUM;
            case MuscleType.latissimusDorsi:
              return Assets.backBodyLATISSIMUSDORSI;
            case MuscleType.semitendinosus:
              return Assets.backBodySEMITENDINOSUS;
            default:
              return null;
          }
        case BodyPartsType.leftArm:
          switch (muscle) {
            case MuscleType.deltoid:
              return Assets.backLeftArmDELTOID;
            case MuscleType.brachioradialis:
              return Assets.backLeftArmBRACHIORADIALIS;
            case MuscleType.supinator:
              return Assets.backLeftArmSUPINATOR;
            case MuscleType.extensorCarpiUlnaris:
              return Assets.backLeftArmEXTENSORCARPIULNARIS;
            case MuscleType.triceps:
              return Assets.backLeftArmTRICEPS;
            case MuscleType.flexorCarpiRadialis:
              return Assets.backLeftArmFLEXORCARPIRADIALIS;
            case MuscleType.palmarisLongus:
              return Assets.backLeftArmPALMARISLONGUS;
            default:
              return null;
          }
        case BodyPartsType.rightArm:
          switch (muscle) {
            case MuscleType.deltoid:
              return Assets.backRightArmDELTOID;
            case MuscleType.brachioradialis:
              return Assets.backRightArmBRACHIORADIALIS;
            case MuscleType.supinator:
              return Assets.backRightArmSUPINATOR;
            case MuscleType.extensorCarpiUlnaris:
              return Assets.backRightArmEXTENSORCARPIULNARIS;
            case MuscleType.triceps:
              return Assets.backRightArmTRICEPS;
            case MuscleType.flexorCarpiRadialis:
              return Assets.backRightArmFLEXORCARPIRADIALIS;
            case MuscleType.palmarisLongus:
              return Assets.backRightArmPALMARISLONGUS;
            default:
              return null;
          }
        case BodyPartsType.leftLeg:
          switch(muscle) {
            case MuscleType.gluteus:
              return Assets.backLeftLegGLUTEUS;
            case MuscleType.semimembranosus:
              // TODO: 장경인대 이미지 변경 필요
              return Assets.backLeftLegGLUTEUS;
            case MuscleType.rectusFemoris:
              return Assets.backLeftLegRECTUSFEMORIS;
            case MuscleType.gracilis:
              return Assets.backLeftLegGRACILIS;
            case MuscleType.sartorius:
              return Assets.backLeftLegSARTORIUS;
            case MuscleType.adductorMagnus:
              return Assets.backLeftLegADDUCTORMAGNUS;
            case MuscleType.soleus:
              return Assets.backLeftLegSOLEUS;
            case MuscleType.bicepsFemoris:
              return Assets.backLeftLegBICEPSFEMORIS;
            default:
              return null;
          }
        case BodyPartsType.rightLeg:
          switch(muscle) {
            case MuscleType.gluteus:
              return Assets.backRightLegGLUTEUS;
            case MuscleType.semimembranosus:
            // TODO: 장경인대 이미지 변경 필요
              return Assets.backRightLegGLUTEUS;
            case MuscleType.rectusFemoris:
              return Assets.backRightLegRECTUSFEMORIS;
            case MuscleType.gracilis:
              return Assets.backRightLegGRACILIS;
            case MuscleType.sartorius:
              return Assets.backRightLegSARTORIUS;
            case MuscleType.adductorMagnus:
              return Assets.backRightLegADDUCTORMAGNUS;
            case MuscleType.soleus:
              return Assets.backRightLegSOLEUS;
            case MuscleType.bicepsFemoris:
              return Assets.backRightLegBICEPSFEMORIS;
            default:
              return null;
          }
        default:
          return null;
      }
    }
  }
}
