import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/injury/model/delete_injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_request_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/put_injury_detail_recovery_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/base_dialog.dart';
import 'package:physical_note/app/ui/dialog/clanedar_dialog/calendar_dialog.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail_ui_mapper.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'injury_detail_args.dart';
import 'injury_detail_pain_symptom_ui_state.dart';

/// 부상 체크 상세 컨트롤러.
class InjuryDetailController extends BaseController {
  final args = Get.arguments as InjuryDetailArgs;

  @override
  onReady() {
    super.onReady();

    final injuryId = args.injuryId;
    if (injuryId != null) {
      _loadApi(injuryId);
    }
  }

  /// 등록일
  late final recordDate = args.recordDate.obs;

  /// 상세(or 수정)일 때 ui 노출 플래그.
  bool get isShowDetailUi => args.injuryId != null;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;

  /// 질병 텍스트 컨트롤러.
  final diseaseController = ''.obsWithController;

  /// 앞/뒤
  late final directionType = (null as DistinctionType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 상체/하체
  late final bodyType = (null as BodyType?).obs
    ..listen((p0) {
      bodyPartsType.value = null;
    });

  /// 센치 부위 타입
  late final bodyPartsType = (null as BodyPartsType?).obs
    ..listen((p0) {
      selectedMuscleType.value = null;
      _setMuscleSvgStringFrom();
    });

  /// 선택된 근육.
  late final selectedMuscleType = (null as MuscleType?).obs
    ..listen((p0) {
      _setMuscleSvgStringFrom();
    });

  /// 근육 이미지.
  final muscleImage = ''.obs;

  /// 상세 근육.
  late final muscles = CombineLatestStream([
    directionType.behaviorStream,
    bodyPartsType.behaviorStream,
  ], (values) {
    var direction = values[0];
    var bodyPartsType = values[1];

    if (direction == DistinctionType.front) {
      if (bodyPartsType == BodyPartsType.body) {
        return MuscleType.getFrontBodyMuscles();
      } else if (bodyPartsType == BodyPartsType.leftArm ||
          bodyPartsType == BodyPartsType.rightArm) {
        return MuscleType.getFrontArmMuscles();
      } else if (bodyPartsType == BodyPartsType.leftLeg ||
          bodyPartsType == BodyPartsType.rightLeg) {
        return MuscleType.getFrontLegMuscles();
      }
    } else if (direction == DistinctionType.back) {
      if (bodyPartsType == BodyPartsType.body) {
        return MuscleType.getBackBodyMuscles();
      } else if (bodyPartsType == BodyPartsType.leftArm ||
          bodyPartsType == BodyPartsType.rightArm) {
        return MuscleType.getBackArmMuscles();
      } else if (bodyPartsType == BodyPartsType.leftLeg ||
          bodyPartsType == BodyPartsType.rightLeg) {
        return MuscleType.getBackLegMuscles();
      }
    } else {}

    return <MuscleType>[];
  }).toObs([]);

  /// 통증 정도.
  final painLevel = InjuryLevelType.noPain.obs;

  /// 통증 양상.
  final painSymptoms = PainType.values
      .map((e) => InjuryDetailPainSymptomUiState(type: e))
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

  /// 달력 클릭.
  Future<void> onPressedCalendar() async {
    final response = await Get.dialog(
      CalendarDialog(
        currentDate: recordDate.value,
        focusedDate: recordDate.value,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null) {
      recordDate.value = newDateTime;
      // _loadApi(args.injuryId);
    }
  }

  /// 부상 타입 클릭.
  void onPressedInjuryType(InjuryType type) {
    injuryType.value = type;
  }

  /// 앞/뒤 클릭.
  void onPressedDirectionType(DistinctionType type) {
    directionType.value = type;
  }

  /// 몸 클릭.
  void onPressedBodyType(BodyType type) {
    bodyType.value = type;
  }

  /// 신체부위 클릭.
  void onPressedBodyPartsType(BodyPartsType type) async {
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
  void onPressedPainSymptom(InjuryDetailPainSymptomUiState selectedItem) {
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

  /// 근육 Svg String 설정.
  void _setMuscleSvgStringFrom() async {
    final direction = directionType.value;
    final partsType = bodyPartsType.value;

    var asset = "";

    if (direction == DistinctionType.front) {
      if (partsType == BodyPartsType.body) {
        asset = Assets.muscleFrontBody;
      } else if (partsType == BodyPartsType.leftArm) {
        asset = Assets.muscleFrontLeftArm;
      } else if (partsType == BodyPartsType.rightArm) {
        asset = Assets.muscleFrontRightArm;
      } else if (partsType == BodyPartsType.leftLeg) {
        asset = Assets.muscleFrontLeftLeg;
      } else if (partsType == BodyPartsType.rightLeg) {
        asset = Assets.muscleFrontRightLeg;
      }
    } else if (direction == DistinctionType.back) {
      if (partsType == BodyPartsType.body) {
        asset = Assets.muscleBackBody;
      } else if (partsType == BodyPartsType.leftArm) {
        asset = Assets.muscleBackLeftArm;
      } else if (partsType == BodyPartsType.rightArm) {
        asset = Assets.muscleBackRightArm;
      } else if (partsType == BodyPartsType.leftLeg) {
        asset = Assets.muscleBackLeftLeg;
      } else if (partsType == BodyPartsType.rightLeg) {
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

  /// 완치 버튼 클릭
  void onPressedRecovery() {
    Get.dialog(
      BaseDialog(
          text: StringRes.recoveryCompleteQuestion.tr,
          yesText: StringRes.yes.tr,
          onPressedYes: () async {
            final result = await _recoveryInjury();
            Get.back();
            await Future.delayed(const Duration(milliseconds: 500));
            close(result: result);
          },
          noText: StringRes.no.tr,
          onPressedNo: () {
            Get.back();
          }),
      barrierDismissible: true,
    );
  }

  /// 삭제 버튼 클릭.
  void onPressedDelete() {
    Get.dialog(
      BaseDialog(
          text: StringRes.deleteDialog.tr,
          yesText: StringRes.yes.tr,
          onPressedYes: () async {
            final bool result = await _deleteInjury();
            Get.back();
            await Future.delayed(const Duration(milliseconds: 500));
            close(result: result);
          },
          noText: StringRes.no.tr,
          onPressedNo: () {
            Get.back();
          }),
      barrierDismissible: true,
    );
  }

  /// API - 부상 체크 등록 / 수정.
  Future onPressedSubmit() async {
    final requestData = _getRequestData();
    final injuryApi = Get.find<InjuryAPI>();
    final id = args.injuryId;
    dynamic response;

    setLoading(true);

    if (id == null) {
      response = await injuryApi.postInjury(
        requestData: requestData,
      );
    } else {
      response = await injuryApi.putInjury(
        injuryId: id,
        requestData: requestData,
      );
    }

    if (response is PostInjuryResponseModel) {
      if (response.id != null) {
        showToast("부상 체크 저장 성공.");
        await Future.delayed(const Duration(seconds: 1));
        close(result: true);
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    setLoading(false);
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
        recordDate: recordDate.value.toFormattedString("yyyy-MM-dd"),
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
        recordDate: recordDate.value.toFormattedString("yyyy-MM-dd"),
      );
    }

    return requestData;
  }

  /// API - 상세 조회.
  Future _loadApi(int? id) async {
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
    bool result = false;
    final injuryId = args.injuryId;
    if (injuryId == null) {
      return result;
    }

    setLoading(true);
    final injuryApi = Get.find<InjuryAPI>();
    final response = await injuryApi.deleteInjury(injuryId: injuryId);
    String? message = '';

    if (response is DeleteInjuryResponseModel && response.deleted == true) {
      close(result: true);
      result = true;
      message = response.message;
    } else {
      message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
    }

    if (message != null) {
      showToast(message);
      await Future.delayed(const Duration(seconds: 1));
    }

    setLoading(false);
    return result;
  }

  /// API - 부상 완치.
  Future<bool> _recoveryInjury() async {
    var injuryId = args.injuryId;
    var result = false;
    if (injuryId == null) {
      logger.e('유효하지 않은 부상입니다.');
      return result;
    }

    setLoading(true);
    String? message;
    final injuryApi = Get.find<InjuryAPI>();
    final response = await injuryApi.putInjuryDetailRecovery(
      userInjuryId: injuryId,
    );

    if (response is PutInjuryDetailRecoveryResponseModel &&
        response.status == true) {
      message = response.message;
      result = true;
    } else {
      message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
    }

    if (message != null) {
      showToast(message);
    }
    setLoading(false);
    return result;
  }
}
