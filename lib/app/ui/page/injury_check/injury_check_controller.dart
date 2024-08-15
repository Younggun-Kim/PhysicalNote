// ignore_for_file: unnecessary_cast

import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/constant/pain_type.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/injury/model/delete_injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_request_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/put_injury_detail_recovery_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/dialog/base_dialog.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_ui_mapper.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'injury_check_pain_symptom_ui_state.dart';

mixin InjuryCheckController on BaseController {
  /// 부상 체크 초기화.
  void resetInjuryCheck(DateTime? date) {
    injuryDetailId.value = null;
    injuryCheckDate.value = date ?? injuryCheckDate.value;
    injuryType.value = InjuryType.nonContact;
    diseaseController.value = "";
    directionType.value = null;
    bodyType.value = null;
    bodyPartsType.value = null;
    selectedMuscleType.value = null;
    muscleImage.value = "";
    painLevel.value = InjuryLevelType.noPain;
    painSymptoms.value = PainType.values
        .map((e) => InjuryCheckPainSymptomUiState(type: e))
        .toList();
    painTimingIntermittent.value = null;
    painTimingRest.value = false;
    painTimingWorkout.value = false;
    painTimingDescription.value = "";

    isRecovered.value = false;
  }

  late var injuryDetailId = (null as int?).obs
    ..listen((p0) {
      _loadInjuryDetail(p0);
    });

  // 상세(or 수정)일 때 ui 노출 플래그.
  late var isShowDetailUi =
      injuryDetailId.behaviorStream.map((event) => event != null).toObs(false);

  var injuryCheckDate = DateTime.now().obs;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;

  /// 질병 텍스트 컨트롤러.
  final diseaseController = "".obsWithController;

  /// 앞/뒤.
  late final directionType = (null as InjuryCheckDirectionType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 몸 타입.
  late final bodyType = (null as InjuryCheckBodyType?).obs
    ..listen((p0) {
      bodyPartsType.value = null;
    });

  /// 신체부위.
  late final bodyPartsType = (null as InjuryCheckBodyPartsType?).obs
    ..listen((p0) {
      selectedMuscleType.value = null;
      _setMuscleSvgStringFrom();
    });

  /// 선택된 상세 근육.
  late final selectedMuscleType = (null as MuscleType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 근육 이미지.
  final muscleImage = "".obs;

  /// 상세 근육.
  late final muscles = CombineLatestStream([
    directionType.behaviorStream,
    bodyPartsType.behaviorStream,
  ], (values) {
    var direction = values[0];
    var bodyPartsType = values[1];

    if (direction == InjuryCheckDirectionType.front) {
      if (bodyPartsType == InjuryCheckBodyPartsType.body) {
        return MuscleType.getFrontBodyMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftArm ||
          bodyPartsType == InjuryCheckBodyPartsType.rightArm) {
        return MuscleType.getFrontArmMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftLeg ||
          bodyPartsType == InjuryCheckBodyPartsType.rightLeg) {
        return MuscleType.getFrontLegMuscles();
      }
    } else if (direction == InjuryCheckDirectionType.back) {
      if (bodyPartsType == InjuryCheckBodyPartsType.body) {
        return MuscleType.getBackBodyMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftArm ||
          bodyPartsType == InjuryCheckBodyPartsType.rightArm) {
        return MuscleType.getBackArmMuscles();
      } else if (bodyPartsType == InjuryCheckBodyPartsType.leftLeg ||
          bodyPartsType == InjuryCheckBodyPartsType.rightLeg) {
        return MuscleType.getBackLegMuscles();
      }
    } else {}

    return <MuscleType>[];
  }).toObs([]);

  /// 통증 정도.
  final painLevel = InjuryLevelType.noPain.obs;

  /// 통증 양상.
  final painSymptoms = PainType.values
      .map((e) => InjuryCheckPainSymptomUiState(type: e))
      .toList()
      .obs;

  /// 통증 시기 - 간헐적, 일정함
  final painTimingIntermittent = (null as bool?).obs;

  /// 통증 시기 - 휴식기
  final painTimingRest = false.obs;

  /// 통증 시기 - 운동중.
  final painTimingWorkout = false.obs;

  /// 통증시기 - 부상 경위.
  final painTimingDescription = "".obsWithController;

  /// 접촉 / 비접촉일 때 Enabled.
  late final isEnabledSubmit = CombineLatestStream(
    [
      directionType.behaviorStream.map((event) => event != null),
      bodyType.behaviorStream.map((event) => event != null),
      bodyPartsType.behaviorStream.map((event) => event != null),
      selectedMuscleType.behaviorStream.map((event) => event != null),
      painSymptoms.behaviorStream
          .map((event) => event.any((element) => element.isSelected == true)),
      painTimingIntermittent.behaviorStream.map((event) => event != null),
    ],
    (values) => values.every((element) => element == true),
  ).toObs(false);

  /// 질병일 때 Enabled.
  late final isEnabledDiseaseSubmit = diseaseController.behaviorStream
      .map((event) => event.isNotEmpty)
      .toObs(false);

  /// 완치여부
  final isRecovered = false.obs;

  /// 부상 타입 클릭.
  void onPressedInjuryType(InjuryType type) {
    injuryType.value = type;
  }

  /// 앞/뒤 클릭.
  void onPressedDirectionType(InjuryCheckDirectionType type) {
    directionType.value = type;
  }

  /// 몸 클릭.
  void onPressedBodyType(InjuryCheckBodyType type) {
    bodyType.value = type;
  }

  /// 신체부위 클릭.
  void onPressedBodyPartsType(InjuryCheckBodyPartsType type) async {
    bodyPartsType.value = type;
  }

  /// 상세근육 클릭.
  void onPressedMuscle(MuscleType type) {
    selectedMuscleType.value = type;
  }

  /// 통증 정도 변경.
  void onChangePainLevelSlide(double value) {
    painLevel.value =
        InjuryLevelType.fromLevel(value.toInt()) ?? InjuryLevelType.noPain;
  }

  /// 통증 양상 선택(다중 선택 가능).
  void onPressedPainSymptom(InjuryCheckPainSymptomUiState selectedItem) {
    final list = painSymptoms.toList();

    painSymptoms.value = list.map((e) {
      if (e.type == selectedItem.type) {
        e.isSelected = !e.isSelected;
      }
      return e;
    }).toList();
  }

  /// 통증시기 간헐적 클릭.
  void onPressedPainTimingIntermittent(bool isIntermittent) {
    painTimingIntermittent.value = isIntermittent;
  }

  /// 통증시기 휴식기 클릭.
  void onPressedPainTimingRest() {
    final newValue = !painTimingRest.value;
    painTimingRest.value = newValue;
  }

  /// 통증시기 운동중 클릭.
  void onPressedPainTimingWorkout() {
    final newValue = !painTimingWorkout.value;
    painTimingWorkout.value = newValue;
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

  /// 근육 Svg String 설정.
  void _setMuscleSvgStringFrom() async {
    final direction = directionType.value;
    final partsType = bodyPartsType.value;

    var asset = "";

    if (direction == InjuryCheckDirectionType.front) {
      if (partsType == InjuryCheckBodyPartsType.body) {
        asset = Assets.muscleFrontBody;
      } else if (partsType == InjuryCheckBodyPartsType.leftArm) {
        asset = Assets.muscleFrontLeftArm;
      } else if (partsType == InjuryCheckBodyPartsType.rightArm) {
        asset = Assets.muscleFrontRightArm;
      } else if (partsType == InjuryCheckBodyPartsType.leftLeg) {
        asset = Assets.muscleFrontLeftLeg;
      } else if (partsType == InjuryCheckBodyPartsType.rightLeg) {
        asset = Assets.muscleFrontRightLeg;
      }
    } else if (direction == InjuryCheckDirectionType.back) {
      if (partsType == InjuryCheckBodyPartsType.body) {
        asset = Assets.muscleBackBody;
      } else if (partsType == InjuryCheckBodyPartsType.leftArm) {
        asset = Assets.muscleBackLeftArm;
      } else if (partsType == InjuryCheckBodyPartsType.rightArm) {
        asset = Assets.muscleBackRightArm;
      } else if (partsType == InjuryCheckBodyPartsType.leftLeg) {
        asset = Assets.muscleBackLeftLeg;
      } else if (partsType == InjuryCheckBodyPartsType.rightLeg) {
        asset = Assets.muscleBackRightLeg;
      }
    }

    var muscleImageString = "";

    if (asset.isNotEmpty) {
      const selectedMuscleColor = "E4FAC1";
      final muscleId = selectedMuscleType.value?.name;
      var svgString = await MuscleUtils.loadSvgFile(asset);

      if (muscleId != null) {
        svgString = MuscleUtils.changeSvgPathColor(
            svgString, muscleId, selectedMuscleColor);
      }

      muscleImageString = svgString;
    }

    muscleImage.value = muscleImageString;
  }

  /// API - 부상 체크 등록 / 수정.
  Future<bool> onPressedSubmit() async {
    var result = false;
    final requestData = _getRequestData();
    final injuryApi = Get.find<InjuryAPI>();
    final injuryId = injuryDetailId.value;
    dynamic response;

    setLoading(true);

    if (injuryId == null) {
      response = await injuryApi.postInjury(
        requestData: requestData,
      );
    } else {
      response = await injuryApi.putInjury(
        injuryId: injuryId,
        requestData: requestData,
      );
    }

    if (response is PostInjuryResponseModel) {
      if (response.id != null) {
        result = true;
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    setLoading(false);

    return result;
  }

  /// 등록/수정 RequestData
  PostInjuryRequestModel _getRequestData() {
    final injuryTypeKey = injuryType.value.serverKey;
    final distinctionType = directionType.value?.serverKey;
    final bodyTypeKey = bodyType.value?.serverKey;
    final bodyPart = bodyPartsType.value?.serverKey;
    final muscleType = selectedMuscleType.value?.serverKey;
    final injuryLevel = painLevel.value.serverKey;
    final symptoms = painSymptoms
        .where((e) => e.isSelected == true)
        .map((e) => e.type.serverKey)
        .toList();
    final comment = injuryType.value == InjuryType.disease
        ? diseaseController.value
        : painTimingDescription.value;

    var painTime = <String>[];

    var intermittent = painTimingIntermittent.value;
    if (intermittent == true) {
      painTime.add("INTERMITTENT");
    } else if (intermittent == false) {
      painTime.add("CONSTANT");
    }
    if (painTimingRest.value == true) {
      painTime.add("REST");
    }

    if (painTimingWorkout.value == true) {
      painTime.add("DURING_EXERCISE");
    }

    late PostInjuryRequestModel requestData;
    if (injuryType.value == InjuryType.disease) {
      requestData = PostInjuryRequestModel(
        injuryType: injuryTypeKey,
        comment: comment,
        recordDate: injuryCheckDate.value.toFormattedString("yyyy-MM-dd"),
      );
    } else {
      requestData = PostInjuryRequestModel(
        injuryType: injuryTypeKey,
        distinctionType: distinctionType,
        bodyType: bodyTypeKey,
        bodyPart: bodyPart,
        muscleType: muscleType,
        injuryLevel: injuryLevel,
        painCharacteristicList: symptoms,
        painTimes: painTime,
        comment: comment,
        recordDate: injuryCheckDate.value.toFormattedString("yyyy-MM-dd"),
      );
    }

    return requestData;
  }

  /// API - 상세 조회.
  Future _loadInjuryDetail(int? id) async {
    final injuryId = id;
    if (injuryId == null) {
      return;
    }

    setLoading(true);
    final injuryApi = Get.find<InjuryAPI>();

    final response = await injuryApi.getInjuryDetail(id: injuryId);

    if (response is InjuryResponseModel) {
      setScreen(response);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    setLoading(false);
  }

  /// API - 부상 정보 삭제..
  Future<bool> _deleteInjury() async {
    var result = false;
    final injuryId = injuryDetailId.value;
    if (injuryId == null) {
      return result;
    }

    setLoading(true);
    final injuryApi = Get.find<InjuryAPI>();

    final response = await injuryApi.deleteInjury(injuryId: injuryId);

    if (response is DeleteInjuryResponseModel && response.deleted == true) {
      close(result: true);
      resetInjuryCheck(null);
      result = true;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      result = false;
    }

    setLoading(false);
    return result;
  }

  /// 삭제 버튼 클릭.
  Future<bool> onPressedInjuryCheckDelete() async {
    return await _deleteInjury();
  }

  /// 부상 완치 클릭

  /// 부상관리 - 부상체크 삭제 성공시.
  Future<bool> onPressedInjuryCheckRecovery() async {
    var injuryId = injuryDetailId.value;
    var result = false;
    if (injuryId == null) {
      return result;
    }

    final injuryApi = Get.find<InjuryAPI>();

    setLoading(true);
    final response =
        await injuryApi.putInjuryDetailRecovery(userInjuryId: injuryId);

    if (response is PutInjuryDetailRecoveryResponseModel &&
        response.status == true) {
      result = true;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    setLoading(false);

    return result;
  }

  void showRecoveryDialog() {
    Get.dialog(
      BaseDialog(
          text: StringRes.recoveryCompleteQuestion.tr,
          yesText: StringRes.yes.tr,
          onPressedYes: () async {
            await onPressedInjuryCheckRecovery();
            Get.back();
          },
          noText: StringRes.no.tr,
          onPressedNo: () {
            Get.back();
          }),
      barrierDismissible: true,
    );
  }

  void showDeleteDialog() {
    Get.dialog(
      BaseDialog(
          text: StringRes.deleteDialog.tr,
          yesText: StringRes.yes.tr,
          onPressedYes: () async {
            await onPressedInjuryCheckDelete();
            Get.back();
          },
          noText: StringRes.no.tr,
          onPressedNo: () {
            Get.back();
          }),
      barrierDismissible: true,
    );
  }
}
