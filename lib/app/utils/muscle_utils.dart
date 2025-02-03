import 'package:flutter/services.dart';
import 'package:physical_note/app/config/constant/body_part_type.dart';
import 'package:physical_note/app/config/constant/distinction_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/resources/assets/assets.dart';

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
    String svgString,
    String pathId,
    String color,
  ) {
    var svgList = svgString.split("\n");

    // 근육, 근육명, 근육명 선 3개의 색상 변경
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
            case MuscleType.coracobrachialis:
              return Assets.cORACOBRACHIALISFrontLeftArm;
            case MuscleType.triceps:
              return Assets.tRICEPSFrontLeftArm;
            case MuscleType.brachialis:
              return Assets.bRACHIALISFrontLeftArm;
            case MuscleType.pronatorTeres:
              return Assets.pRONATORTERESFrontLeftArm;
            case MuscleType.deltoid:
              return Assets.dELTOIDFrontLeftArm;
            case MuscleType.biceps:
              return Assets.bICEPSFrontLeftArm;
            case MuscleType.brachioradialis:
              return Assets.bRACHIORADIALISFrontLeftArm;
            case MuscleType.palmarisLongus:
              return Assets.pALMARISLONGUSFrontLeftArm;
            default:
              return null;
          }
        case BodyPartsType.rightArm:
          switch (muscle) {
            case MuscleType.coracobrachialis:
              return Assets.cORACOBRACHIALISFrontRightArm;
            case MuscleType.triceps:
              return Assets.tRICEPSFrontRightArm;
            case MuscleType.brachialis:
              return Assets.bRACHIALISFrontRightArm;
            case MuscleType.pronatorTeres:
              return Assets.pRONATORTERESFrontRightArm;
            case MuscleType.deltoid:
              return Assets.dELTOIDFrontRightArm;
            case MuscleType.biceps:
              return Assets.bICEPSFrontRightArm;
            case MuscleType.brachioradialis:
              return Assets.bRACHIORADIALISFrontRightArm;
            case MuscleType.palmarisLongus: // 장장근
              return Assets.pALMARISLONGUSFrontRightArm;
            default:
              return null;
          }
        case BodyPartsType.leftLeg:
          switch (muscle) {
            case MuscleType.glute:
              return Assets.frontLeftLegGLUTE;
            case MuscleType.tensorFasciaeLatae:
              return Assets.frontLeftLegTENSORFASCIAELATAE;
            case MuscleType.sartorius:
              return Assets.frontLeftLegSARTORIUS;
            case MuscleType.vastusLateralis:
              return Assets.frontLeftLegVASTUSLATERALIS;
            case MuscleType.rectusFemoris:
              return Assets.frontLeftLegRECTUSFEMORIS;
            case MuscleType.itBand:
              return Assets.frontLeftLegITBAND;
            case MuscleType.extensorDigitorumLongus:
              return Assets.frontLeftLegEXTENSORDIGITORUMLONGUS;
            case MuscleType.tibialisAnterior:
              return Assets.frontLeftLegTIBIALISANTERIOR;
            case MuscleType.fibularisLongus:
              return Assets.frontLeftLegFIBULARISLONGUS;
            case MuscleType.extensorHallucisLongus:
              return Assets.frontLeftLegEXTENSORHALLUCISLONGUS;
            case MuscleType.soleus:
              return Assets.frontLeftLegSOLEUS;
            case MuscleType.gastrocnemius:
              return Assets.frontLeftLegGASTROCNEMIUS;
            case MuscleType.vastusIntermedius:
              return Assets.frontLeftLegVASTUSINTERMEDIUS;
            case MuscleType.vastusMedialis:
              return Assets.frontLeftLegVASTUSMEDIALIS;
            case MuscleType.gracilis:
              return Assets.frontLeftLegGRACILIS;
            case MuscleType.adductorMagnus:
              return Assets.frontLeftLegADDUCTORMAGNUS;
            case MuscleType.adductorLongus:
              return Assets.frontLeftLegADDUCTORLONGUS;
            case MuscleType.pectineus:
              return Assets.frontLeftLegPECTINEUS;
            case MuscleType.psoasMajor:
              return Assets.frontLeftLegPSOASMAJOR;
            case MuscleType.iliacus:
              return Assets.frontLeftLegILIACUS;

            default:
              return null;
          }
        case BodyPartsType.rightLeg:
          switch (muscle) {
            case MuscleType.glute:
              return Assets.gLUTEFrontRightLeg;
            case MuscleType.tensorFasciaeLatae:
              return Assets.tENSORFASCIAELATAEFrontRightLeg;
            case MuscleType.sartorius:
              return Assets.sARTORIUSFrontRightLeg;
            case MuscleType.vastusLateralis:
              return Assets.vASTUSLATERALISFrontRightLeg;
            case MuscleType.rectusFemoris:
              return Assets.rECTUSFEMORISFrontRightLeg;
            case MuscleType.itBand:
              return Assets.iTBANDFrontRightLeg;
            case MuscleType.extensorDigitorumLongus:
              return Assets.eXTENSORDIGITORUMLONGUSFrontRightLeg;
            case MuscleType.tibialisAnterior:
              return Assets.tIBIALISANTERIORFrontRightLeg;
            case MuscleType.fibularisLongus:
              return Assets.fIBULARISLONGUSFrontRightLeg;
            case MuscleType.extensorHallucisLongus:
              return Assets.eXTENSORHALLUCISLONGUSFrontRightLeg;
            case MuscleType.soleus:
              return Assets.sOLEUSFrontRightLeg;
            case MuscleType.gastrocnemius:
              return Assets.gASTROCNEMIUSFrontRightLeg;
            case MuscleType.vastusIntermedius:
              return Assets.vASTUSINTERMEDIUSFrontRightLeg;
            case MuscleType.vastusMedialis:
              return Assets.vASTUSMEDIALISFrontRightLeg;
            case MuscleType.gracilis:
              return Assets.gRACILISFrontRightLeg;
            case MuscleType.adductorMagnus:
              return Assets.aDDUCTORMAGNUSFrontRightLeg;
            case MuscleType.adductorLongus:
              return Assets.aDDUCTORLONGUSFrontRightLeg;
            case MuscleType.pectineus:
              return Assets.pECTINEUSFrontRightLeg;
            case MuscleType.psoasMajor:
              return Assets.pSOASMAJORFrontRightLeg;
            case MuscleType.iliacus:
              return Assets.iLIACUSFrontRightLeg;
            default:
              return null;
          }
      }
    } else {
      switch (bodyPart) {
        case BodyPartsType.body:
          switch (muscle) {
            case MuscleType.teresMinor:
              return Assets.tERESMINORBackBody;
            case MuscleType.teresMajor:
              return Assets.tERESMAJORBackBody;
            case MuscleType.latissimusDorsi:
              return Assets.lATISSIMUSDORSIBackBody;
            case MuscleType.erectorSprinae:
              return Assets.eRECTORSPRINAEBackBody;
            default:
              return null;
          }
        case BodyPartsType.leftArm:
          switch (muscle) {
            case MuscleType.deltoid:
              return Assets.dELTOIDBackLeftArm;
            case MuscleType.brachioradialis:
              return Assets.bRACHIORADIALISBackLeftArm;
            case MuscleType.extensorCarpiRadialisLongus:
              return Assets.eXTENSORCARPIRADIALISLONGUSBackLeftArm;
            case MuscleType.extensorDigitorum:
              return Assets.eXTENSORDIGITORUMBackLeftArm;
            case MuscleType.triceps:
              return Assets.tRICEPSBackLeftArm;
            case MuscleType.anconeus:
              return Assets.aNCONEUSBackLeftArm;
            case MuscleType.extensorCarpiUlnaris:
              return Assets.eXTENSORCARPIULNARISBackLeftArm;
            default:
              return null;
          }
        case BodyPartsType.rightArm:
          switch (muscle) {
            case MuscleType.deltoid:
              return Assets.dELTOIDBackRightArm;
            case MuscleType.brachioradialis:
              return Assets.bRACHIORADIALISBackRightArm;
            case MuscleType.extensorCarpiRadialisLongus:
              return Assets.eXTENSORCARPIRADIALISLONGUSBackRightArm;
            case MuscleType.extensorDigitorum:
              return Assets.eXTENSORDIGITORUMBackRightArm;
            case MuscleType.triceps:
              return Assets.tRICEPSBackRightArm;
            case MuscleType.anconeus:
              return Assets.aNCONEUSBackRightArm;
            case MuscleType.extensorCarpiUlnaris:
              return Assets.eXTENSORCARPIULNARISBackRightArm;
            default:
              return null;
          }
        case BodyPartsType.leftLeg:
          switch (muscle) {
            case MuscleType.glute:
              return Assets.gLUTEUSbackLeftLeg;
            case MuscleType.itBand:
              return Assets.iTBANDbackLeftLeg;
            case MuscleType.bicepsFemoris:
              return Assets.bICEPSFEMORISbackLeftLeg;
            case MuscleType.gastrocnemius:
              return Assets.gASTROCNEMIUSbackLeftLeg;
            case MuscleType.soleus:
              return Assets.sOLEUSbackLeftLeg;
            case MuscleType.semimembranosus:
              return Assets.sEMIMEMBRANOSUSbackLeftLeg;
            case MuscleType.gracilis:
              return Assets.gRACILISbackLeftLeg;
            case MuscleType.adductorMagnus:
              return Assets.aDDUCTORMAGNUSbackLeftLeg;
            default:
              return null;
          }
        case BodyPartsType.rightLeg:
          switch (muscle) {
            case MuscleType.glute:
              return Assets.gLUTEUSBackRightLeg;
            case MuscleType.itBand:
              return Assets.iTBANDBackRightLeg;
            case MuscleType.bicepsFemoris:
              return Assets.bICEPSFEMORISBackRightLeg;
            case MuscleType.gastrocnemius:
              return Assets.gASTROCNEMIUSBackRightLeg;
            case MuscleType.soleus:
              return Assets.sOLEUSBackRightLeg;
            case MuscleType.semimembranosus:
              return Assets.sEMIMEMBRANOSUSBackRightLeg;
            case MuscleType.gracilis:
              return Assets.gRACILISBackRightLeg;
            case MuscleType.adductorMagnus:
              return Assets.aDDUCTORMAGNUSBackRightLeg;
            default:
              return null;
          }
      }
    }
  }
}
