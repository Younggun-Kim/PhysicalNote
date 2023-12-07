import 'dart:ui';

import 'package:flutter/material.dart';

/// 후퍼인덱스 상태값
sealed class HooperIndexStatus {
  Color toColor();

  @override
  String toString();

  static HooperIndexStatus? changeFrom(String? remoteString) {
    if (remoteString == "관리요망(1단계)") {
      return HooperIndexStatusWarning();
    } else {
      return null;
    }
  }
}

/// 후퍼인덱스 상태값 - 위험
class HooperIndexStatusDangerous extends HooperIndexStatus {
  @override
  Color toColor() => Colors.red;

  @override
  String toString() => "위험";
}

/// 후퍼인덱스 상태값 - 관리요망
class HooperIndexStatusWarning extends HooperIndexStatus {
  @override
  Color toColor() => Colors.yellow;

  @override
  String toString() => "관리요망";
}

/// 후퍼인덱스 상태값 - 적정
class HooperIndexStatusNormal extends HooperIndexStatus {
  @override
  Color toColor() => Colors.green;

  @override
  String toString() => "적정";
}

/// 후퍼인덱스 상태값 - 좋음
class HooperIndexStatusGood extends HooperIndexStatus {
  @override
  Color toColor() => Colors.blueAccent;

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
