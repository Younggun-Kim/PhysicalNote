
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

  const FlexibleScrollView({
    Key? key,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.hasScrollBody = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    controller: controller,
    scrollDirection: scrollDirection,
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
