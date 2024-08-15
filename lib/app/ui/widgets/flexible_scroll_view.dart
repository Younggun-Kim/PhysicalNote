
import 'package:flutter/material.dart';

class FlexibleScrollView extends StatelessWidget {
  /// 스크롤 뷰 패딩.
  final EdgeInsets? padding;

  /// 스크롤 방향
  final Axis scrollDirection;

  /// 스크롤 뷰 내부 위젯.
  final Widget child;

  /// 컨트롤러.
  final ScrollController? controller;

  /// 바디에 스크롤 위젯 포함 여부.
  final bool hasScrollBody;

  /// 스크롤 물리적 동작 여부.
  final ScrollPhysics? physics;

  /// 키보드 닫기.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const FlexibleScrollView({
    super.key,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.hasScrollBody = false,
    this.physics,
    required this.child,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build(BuildContext context) => CustomScrollView(
    controller: controller,
    scrollDirection: scrollDirection,
    physics: physics,
    keyboardDismissBehavior: keyboardDismissBehavior,
    slivers: [
      SliverFillRemaining(
        hasScrollBody: hasScrollBody,
        child: Container(
          width: double.infinity,
          padding: padding,
          child: child,
        ),
      )
    ],
  );
}
