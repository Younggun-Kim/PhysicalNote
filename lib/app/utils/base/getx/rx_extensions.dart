import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx;

extension RxExt<T> on Rx<T> {
  /// 아무 동작도 하지 않는 리스너로 수집.
  StreamSubscription<T> collect() {
    return listen((event) {
      /* empty */
    });
  }

  /// 가장 최신의 값 하나를 포함한 스트림 리턴.
  Stream<T> get behaviorStream {
    final behavior = rx.BehaviorSubject<T>();
    behavior.add(value);
    listen((value) {
      behavior.add(value);
    });
    return behavior.stream;
  }
}

extension RxListExt<T> on RxList<T> {
  /// 아무 동작도 하지 않는 리스너로 수집.
  StreamSubscription<List<T>> collect() {
    return listen((event) {
      /* empty */
    });
  }

  /// 가장 최신의 값 하나를 포함한 스트림 리턴.
  Stream<List<T>> get behaviorStream {
    final behavior = rx.BehaviorSubject<List<T>>();
    behavior.add(this);
    listen((value) {
      behavior.add(value);
    });
    return behavior.stream;
  }
}

extension RxMapExt<K, V> on RxMap<K, V> {
  /// 아무 동작도 하지 않는 리스너로 수집.
  StreamSubscription<Map<K, V>> collect() {
    return listen((event) {
      /* empty */
    });
  }

  /// 가장 최신의 값 하나를 포함한 스트림 리턴.
  Stream<Map<K, V>> get behaviorStream {
    final behavior = rx.BehaviorSubject<Map<K, V>>();
    behavior.add(this);
    listen((value) {
      behavior.add(value);
    });
    return behavior.stream;
  }
}

extension StreamExt<T> on Stream<T> {
  /// Stream -> Obs 변환.
  Rx<T> toObs(T initialValue) => Rx<T>(initialValue)..bindStream(this);
}

extension GetxControllerExt<T extends List> on RxObjectMixin<T> {
  /// 리스트의 값이 서로 다른 경우에만 업데이트.
  set values(T val) {
    if (!listEquals(value, val)) {
      value = val;
    }
  }
}
//
// extension ReadWriteValueExt<T> on ReadWriteValue<T> {
//   Rx<T> toObs() {
//     final rx = Rx<T>(val);
//
//     getBox!().listenKey(key, (newValue) {
//       final oldValue = rx.value;
//       if (oldValue != newValue) {
//         rx.value = newValue;
//       }
//     });
//
//     ever(rx, (newValue) {
//       final oldValue = val;
//       if (oldValue != newValue) {
//         val = newValue;
//       }
//     });
//
//     return rx;
//   }
// }

/// 포커스 해제.
void unFocus() {
  Get.focusScope?.unfocus();
}
