import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:physical_note/app/resources/resources.dart';

/// ThumbImageSlider
class ThumbImageSlider extends StatefulWidget {
  final int totalStep;

  final String thumbAsset;

  const ThumbImageSlider({
    super.key,
    required this.totalStep,
    required this.thumbAsset,
  });

  @override
  State<StatefulWidget> createState() => _ThumbImageSlider();
}

class _ThumbImageSlider extends State<ThumbImageSlider> {
  final imageWidth = 28;

  /// 현재 Step
  int currentStep = 0;

  double currentX = 0;

  double get _inactiveWidth => _calculateInactiveWidth();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: _inactiveWidth,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.primary,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: currentX,
            child: GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    widget.thumbAsset,
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
          ),
        ],
      ),
    );
  }

  /// Inactive 계산.
  double _calculateInactiveWidth() {
    if (currentStep == widget.totalStep) {
      return currentX + imageWidth;
    } else if (currentStep == 0) {
      return 0;
    } else {
      return currentX + (imageWidth * 0.5);
    }
  }

  /// 가로 Drag 이벤트.
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    var maxWidth = context.size?.width;
    if (maxWidth == null) {
      setState(() {
        currentStep = 0;
        currentX = 0;
      });
      return;
    }

    /// 이미지 Width 만큼 보정.
    maxWidth -= imageWidth;

    /// Step 계산.
    final oneStepWidth = maxWidth / widget.totalStep;
    final offsetX = maxWidth * 0.05;
    var dx = (details.globalPosition.dx + offsetX) ~/ oneStepWidth;
    dx = dx.clamp(0, 10);
    setState(() {
      currentStep = dx;
      currentX = dx * oneStepWidth;
    });
  }
}
