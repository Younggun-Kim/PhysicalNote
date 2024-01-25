import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:physical_note/app/resources/resources.dart';

/// ThumbImageSlider

class ThumbImageSlider extends StatelessWidget {
  final int totalStep;

  final int currentStep;

  final String thumbAsset;

  /// 슬라이드 드래그 이벤트.
  final Function(int) onChanged;

  const ThumbImageSlider({
    super.key,
    required this.totalStep,
    required this.currentStep,
    required this.thumbAsset,
    required this.onChanged,
  });

  final _imageWidth = 28;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, constraints) {
      final widgetWidth = constraints.maxWidth - _imageWidth;
      final inactiveWidth = _calculateInactiveWidth(widgetWidth);

      return GestureDetector(
        onTapUp: (details) {
          _onHorizontalDragUpdate(details.localPosition.dx, widgetWidth);
        },
        onHorizontalDragUpdate: (details) {
          _onHorizontalDragUpdate(details.localPosition.dx, widgetWidth);
        },
        child: SizedBox(
          height: 43,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorRes.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: inactiveWidth,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.primary,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: _calculateImagePositionX(widgetWidth),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      thumbAsset,
                      height: 43,
                    ),
                    Container(
                      width: 28,
                      height: 43,
                      alignment: Alignment.center,
                      child: Text(
                        "$currentStep",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorRes.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Inactive Width 계산.
  double _calculateInactiveWidth(double width) {
    final currentX = (width * 0.1) * currentStep;
    if (currentStep == totalStep) {
      return currentX + _imageWidth;
    } else if (currentStep == 0) {
      return 0;
    } else {
      return currentX + (_imageWidth * 0.5);
    }
  }

  /// 이미지 포지션 계산.
  double _calculateImagePositionX(double widgetWidth) {
    return (widgetWidth * 0.1) * currentStep;
  }

  /// 가로 Drag 이벤트.
  void _onHorizontalDragUpdate(double dx, double widgetWidth) {
    /// Step 계산.
    final oneStepWidth = widgetWidth / totalStep;
    var newStep = (dx ~/ oneStepWidth);
    newStep = newStep.clamp(0, 10);
    if (currentStep != newStep) {
      onChanged(newStep);
    }
  }
}
