import 'dart:async';
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