import 'package:flutter/material.dart';

class InkWellOver extends StatelessWidget {
  /// 자식 위젯.
  final Widget child;

  /// 스플래시 컬러.
  final Color? splashColor;

  /// 터치 이벤트.
  final VoidCallback? onTap;

  /// 탭 다운 이벤트.
  final GestureTapDownCallback? onTapDown;

  /// 보더 라운딩.
  final BorderRadius? borderRadius;

  const InkWellOver({
    super.key,
    required this.child,
    this.splashColor,
    this.onTap,
    this.onTapDown,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      child,
      Positioned.fill(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            onTapDown: onTapDown,
            splashColor: splashColor,
            borderRadius: borderRadius,
          ),
        ),
      ),
    ],
  );
}
