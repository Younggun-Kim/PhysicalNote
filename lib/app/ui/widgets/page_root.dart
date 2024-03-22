import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class PageRoot extends StatelessWidget {
  /// 컨트롤러.
  final BaseController controller;

  /// 백그라운드 컬러.
  final Color backgroundColor;

  /// 로딩 위젯 컬러.
  final Color progressColor;

  /// 상태바 영역 사용 여부.
  final bool safeStatusBar;

  /// 네비게이션바 영역 사용 여부.
  final bool safeNavigationBar;

  /// 리사이즈 사용 여부.
  final bool resize;

  /// 전체 화면 여부.
  final bool isFullPage;

  /// 자식 위젯.
  final Widget child;

  /// 뒤로가기 허용 여부.
  final bool canPop;

  /// 뒤로가기 콜백.
  final Future<bool> Function(bool didPop)? onWillPop;

  /// 생성자.
  const PageRoot({
    super.key,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.progressColor = Colors.black,
    this.safeStatusBar = true,
    this.safeNavigationBar = true,
    this.resize = true,
    this.isFullPage = false,
    required this.child,
    this.canPop = false,
    this.onWillPop,
  });

  @override
  Widget build(BuildContext context) => PopScope(
        onPopInvoked: onWillPop,
        canPop: canPop,
        child: _createPage(),
      );

  /// 페이지의 기본적인 구조를 생성.
  Widget _createPage() => Stack(
        children: [
          KeyboardDismissOnTap(
            child: Scaffold(
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: resize,
              body: isFullPage
                  ? SizedBox(
                      width: double.infinity,
                      child: child,
                    )
                  : SafeArea(
                      top: safeStatusBar,
                      bottom: safeNavigationBar,
                      child: SizedBox(
                        width: double.infinity,
                        child: child,
                      ),
                    ),
            ),
          ),
          _createLoading(),
        ],
      );

  /// 로딩 뷰.
  Widget _createLoading() => Obx(
        () => Visibility(
          visible: controller.isLoading.value,
          child: Center(
            child: CircularProgressIndicator(
              color: progressColor,
            ),
          ),
        ),
      );
}
