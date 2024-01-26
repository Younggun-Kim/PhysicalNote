import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 후퍼인덱스 상태값
sealed class HooperIndexStatus {
  Color toColor();

  @override
  String toString();

  static HooperIndexStatus? changeFrom(String? remoteString) {
    if (remoteString?.contains("관리요망") == true) {
      return HooperIndexStatusWarning();
    } else if (remoteString?.contains("좋음") == true) {
      return HooperIndexStatusGood();
    } else if (remoteString?.contains("위험") == true) {
      return HooperIndexStatusDangerous();
    } else if (remoteString?.contains("적정") == true) {
      return HooperIndexStatusNormal();
    } else {
      return HooperIndexStatusNone();
    }
  }
}
/// 후퍼인덱스 상태값 - 정보없음
class HooperIndexStatusNone extends HooperIndexStatus {
  @override
  Color toColor() => ColorRes.disable;

  @override
  String toString() => "정보없음";
}

/// 후퍼인덱스 상태값 - 위험
class HooperIndexStatusDangerous extends HooperIndexStatus {
  @override
  Color toColor() => ColorRes.hooperIndexDanger;

  @override
  String toString() => "위험";
}

/// 후퍼인덱스 상태값 - 관리요망
class HooperIndexStatusWarning extends HooperIndexStatus {
  @override
  Color toColor() => ColorRes.hooperIndexWarning;

  @override
  String toString() => "관리요망";
}

/// 후퍼인덱스 상태값 - 적정
class HooperIndexStatusNormal extends HooperIndexStatus {
  @override
  Color toColor() => ColorRes.hooperIndexNormal;

  @override
  String toString() => "적정";
}

/// 후퍼인덱스 상태값 - 좋음
class HooperIndexStatusGood extends HooperIndexStatus {
  @override
  Color toColor() => ColorRes.hooperIndexGood;

  @override
  String toString() => "좋음";
}

/// 후퍼인덱스 데이터
class HooperIndexData {
  final HooperIndexStatus? sleep;
  final HooperIndexStatus? stress;
  final HooperIndexStatus? fatigue;
  final HooperIndexStatus? musclePain;

  HooperIndexData({
    this.sleep,
    this.stress,
    this.fatigue,
    this.musclePain,
  });
}
