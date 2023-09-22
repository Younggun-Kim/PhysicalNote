import 'package:get/get.dart';

import 'base_controller.dart';
import 'package:flutter/material.dart';

class LifecycleController extends BaseController with WidgetsBindingObserver {
  @override
  @mustCallSuper
  void onInit() {

    /*
    ambiguate() 함수는 Getx State 관리자에서 사용되는 함수로,
    동일한 이름의 두 개 이상의 변수 또는 값을 구별하기 위해 사용한다.??
     */
    ambiguate(WidgetsBinding.instance)?.addObserver(this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  void onResumed() {
    // resumed..
  }

  void onPaused() {
    // paused..
  }

  void onInactive() {
    // inactive..
  }

  void onHidden() {
    // hidden.
  }

  void onDetached() {
    // detached..
  }

  @override
  @mustCallSuper
  void onClose() {
    ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    super.onClose();
  }
}
