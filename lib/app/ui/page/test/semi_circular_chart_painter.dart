import 'dart:math';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

//Add this CustomPaint widget to the Widget Tree
//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width * 0.9;
    final radius = width * 0.5;
    final height = width * 0.5;
    const double degree = 90 + 180;
    final radians = degreeToRadian(degree: degree);
    const double triangleSize = 15;

    canvas.translate(size.width * 0.05, size.height * 0.05);

    /// 첫번째 차트
    Path chartPath1 = Path();
    chartPath1.moveTo(width * 0.1165948, height * 0.3769233);
    chartPath1.cubicTo(width * 0.04662504, height * 0.5302900,
        width * 0.002926261, height * 0.7659583, 0, height * 0.9906367);
    chartPath1.lineTo(width * 0.1974896, height * 1.000003);
    chartPath1.cubicTo(width * 0.1993757, height * 0.8555050, width * 0.2295487,
        height * 0.6885250, width * 0.2770843, height * 0.5903617);
    chartPath1.lineTo(width * 0.1166600, height * 0.3767983);
    chartPath1.lineTo(width * 0.1165948, height * 0.3769233);
    chartPath1.close();

    Paint chartPath1Paint = Paint()..style = PaintingStyle.fill;
    chartPath1Paint.color = ColorRes.risk0;
    canvas.drawPath(chartPath1, chartPath1Paint);

    /// 2번째 차트
    Path chartPath2 = Path();
    chartPath2.moveTo(width * 0.4739243, height * 0.05020350);
    chartPath2.cubicTo(
        width * 0.3321626,
        height * 0.06119383,
        width * 0.2047078,
        height * 0.1782167,
        width * 0.1185461,
        height * 0.3670517);
    chartPath2.lineTo(width * 0.2797504, height * 0.5827367);
    chartPath2.cubicTo(width * 0.3312530, height * 0.4763300, width * 0.4036939,
        height * 0.4080150, width * 0.4840035, height * 0.4015217);
    chartPath2.lineTo(width * 0.4738591, height * 0.05020350);
    chartPath2.lineTo(width * 0.4739243, height * 0.05020350);
    chartPath2.close();

    Paint chartPath2Paint = Paint()..style = PaintingStyle.fill;
    chartPath2Paint.color = ColorRes.risk1;
    canvas.drawPath(chartPath2, chartPath2Paint);

    /// 3번째 차트.
    Path chartPath3 = Path();
    chartPath3.moveTo(width * 0.8188330, height * 0.2605183);
    chartPath3.cubicTo(width * 0.7359870, height * 0.1328807, width * 0.6299261,
        height * 0.05532350, width * 0.5135261, height * 0.04982833);
    chartPath3.cubicTo(
        width * 0.5018217,
        height * 0.04932883,
        width * 0.4902461,
        height * 0.04945367,
        width * 0.4787365,
        height * 0.05032783);
    chartPath3.lineTo(width * 0.4888809, height * 0.4016450);
    chartPath3.cubicTo(width * 0.4955139, height * 0.4011467, width * 0.5022765,
        height * 0.4010217, width * 0.5090391, height * 0.4012717);
    chartPath3.cubicTo(width * 0.5806348, height * 0.4046433, width * 0.6455983,
        height * 0.4565967, width * 0.6958000, height * 0.5401500);
    chartPath3.lineTo(width * 0.8188974, height * 0.2603933);
    chartPath3.lineTo(width * 0.8188330, height * 0.2605183);
    chartPath3.close();

    Paint chartPath3Paint = Paint()..style = PaintingStyle.fill;
    chartPath3Paint.color = ColorRes.risk2;
    canvas.drawPath(chartPath3, chartPath3Paint);

    /// 4번째 차트
    Path chartPath4 = Path();
    chartPath4.moveTo(width * 0.8228661, height * 0.2676433);
    chartPath4.cubicTo(width * 0.9340000, height * 0.4389933, width * 1.003704,
        height * 0.6851533, width * 0.9998087, height * 0.9851400);
    chartPath4.lineTo(width * 0.8040730, height * 0.9950067);
    chartPath4.cubicTo(width * 0.8063487, height * 0.8182867, width * 0.7642104,
        height * 0.6548050, width * 0.6997026, height * 0.5473983);
    chartPath4.lineTo(width * 0.8228009, height * 0.2676433);
    chartPath4.lineTo(width * 0.8228661, height * 0.2676433);
    chartPath4.close();

    Paint chartPath4Paint = Paint()..style = PaintingStyle.fill;
    chartPath4Paint.color = ColorRes.risk3;
    canvas.drawPath(chartPath4, chartPath4Paint);

    /// 중앙 선.
    Path centerLinePath = Path();
    centerLinePath.moveTo(width * 0.4750252, height * 0.0003743483);
    centerLinePath.lineTo(width * 0.4897217, height * 0.4883217);

    Paint centerLinePaintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.01034783;
    centerLinePaintStroke.color = Colors.white.withValues(alpha:1.0);
    canvas.drawPath(centerLinePath, centerLinePaintStroke);

    Paint centerLinePaintFill = Paint()..style = PaintingStyle.fill;
    centerLinePaintFill.color = const Color(0xff000000).withValues(alpha:1.0);
    canvas.drawPath(centerLinePath, centerLinePaintFill);

    /// 왼쪽 선.
    Path leftLinePath = Path();
    leftLinePath.moveTo(width * 0.08850174, height * 0.3359533);
    leftLinePath.lineTo(width * 0.3137591, height * 0.6313200);

    Paint leftLinePaintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.01034783;
    leftLinePaintStroke.color = Colors.white.withValues(alpha:1.0);
    canvas.drawPath(leftLinePath, leftLinePaintStroke);

    Paint leftLinePaintFill = Paint()..style = PaintingStyle.fill;
    leftLinePaintFill.color = const Color(0xff000000).withValues(alpha:1.0);
    canvas.drawPath(leftLinePath, leftLinePaintFill);

    /// 오른쪽 선.
    Path rightLinePath = Path();
    rightLinePath.moveTo(width * 0.6701765, height * 0.6038450);
    rightLinePath.lineTo(width * 0.8653904, height * 0.1614827);

    Paint rightLinePaintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.01034783;
    rightLinePaintStroke.color = Colors.white.withValues(alpha:1.0);
    canvas.drawPath(rightLinePath, rightLinePaintStroke);

    Paint rightLinePaintFill = Paint()..style = PaintingStyle.fill;
    rightLinePaintFill.color = const Color(0xff000000).withValues(alpha:1.0);
    canvas.drawPath(rightLinePath, rightLinePaintFill);

    // 삼각형 그리기.
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    // 삼각형 좌표 계산
    var triangleOffsetX = degree > (90 + 180) ? triangleSize : -triangleSize;
    var x1 = (radius) * cos(radians) + (width / 2) + triangleOffsetX;
    var y1 = (radius) * sin(radians) + (height - triangleSize);

    var x2 = x1 + triangleSize * cos(radians + (2 * pi / 3));
    var y2 = y1 + triangleSize * sin(radians + (2 * pi / 3));

    var x3 = x2 + triangleSize * cos(radians + (4 * pi / 3));
    var y3 = y2 + triangleSize * sin(radians + (4 * pi / 3));

    // 삼각형 그리기
    Path path = Path()
      ..moveTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // 각도를 라디안으로 변환
  double degreeToRadian({required double degree}) {
    return degree * (pi / 180);
  }
}
