import 'package:fancy_indicator/src/fancy_indicator_utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class IndicatorDrawingEngine extends CustomPainter {
  final Offset tapPosition;
  final Offset dragPosition;
  final Function(bool shouldDraw, int selectedPercent) onShouldDraw;
  final bool validPressed;
  final double waveRadius;
  final List<Color> gradientColors;
  final List<double> gradientColorsStops;
  final List<int> marker;
  final Color labelTextColor;
  final Color selectedTextColor;
  final Color measureItemColor;
  final String numberAppendix;
  final Color draggableButtonColor;
  final Color draggableButtonIconsColor;
  final Color draggableButtonCircleColor;
  final Color draggableButtonCircleAnimateColor;
  final double labelTextSize;
  final double selectedTextSize;

  IndicatorDrawingEngine(
      {required this.tapPosition,
      required this.dragPosition,
      required this.onShouldDraw,
      required this.validPressed,
      required this.waveRadius,
      required this.gradientColors,
      required this.gradientColorsStops,
      required this.marker,
      required this.labelTextColor,
      required this.selectedTextColor,
      required this.measureItemColor,
      required this.numberAppendix,
      required this.draggableButtonColor,
      required this.draggableButtonIconsColor,
      required this.draggableButtonCircleColor,
      required this.draggableButtonCircleAnimateColor,
      required this.labelTextSize,
      required this.selectedTextSize});

  @override
  void paint(Canvas canvas, Size size) {
    ////Gradient line creation
    final centerPoint = Offset(size.width / 2, size.height / 2);
    final gradient = LinearGradient(
      colors: gradientColors,
      stops: gradientColorsStops,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final gradientRect = Rect.fromCenter(
        center: centerPoint, height: size.height, width: size.width);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..shader = gradient.createShader(gradientRect);

    final wavePoint = FancyIndicatorUtils.valueBetween(
        dragPosition.dy, size.height * 0.1, size.height * 0.9);
    final controlOffset = Offset(size.width * 0.8, wavePoint);
    final rect = Rect.fromCircle(center: controlOffset, radius: 25);

    ///Draw curve in line according to draggable button position
    final path = Path()
      ..moveTo(size.width * 0.7, 0)
      ..lineTo(size.width * 0.7, wavePoint - 75)
      ..quadraticBezierTo(
          size.width * 0.70, wavePoint - 46, size.width * 0.6, wavePoint - 20)
      ..quadraticBezierTo(
          size.width * 0.54, wavePoint, size.width * 0.6, wavePoint + 20)
      ..quadraticBezierTo(
          size.width * 0.7, wavePoint + 46, size.width * 0.7, wavePoint + 75)
      ..lineTo(size.width * 0.7, size.height);
    canvas.drawPath(path, paint);

    ///Draggable button build
    Paint circlePaint = Paint()
      ..color = draggableButtonColor

      ///FancyIndicatorUtils.whiteColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(controlOffset, 28.0, circlePaint);

    ///Below codes responsible for Draggable button onDown animation
    if (waveRadius <= 18.0) {
      Paint wavePaint = Paint()
        ..color = draggableButtonCircleColor

        ///FancyIndicatorUtils.greyDarkerColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8;
      canvas.drawCircle(controlOffset, waveRadius, wavePaint);
    }

    if (waveRadius != 40.0 && waveRadius <= 18.0) {
      Paint wavePaint = Paint()
        ..color = draggableButtonCircleAnimateColor

        ///FancyIndicatorUtils.greyColor
        ..style = PaintingStyle.fill
        ..strokeWidth = (waveRadius >= 28.0) ? 0 : 2;
      canvas.drawCircle(controlOffset, waveRadius, wavePaint);
    } else if (waveRadius != 40.0 && waveRadius > 18.0) {
      Paint wavePaint1 = Paint()
        ..color = FancyIndicatorUtils.greyColor.withAlpha(60)
        ..style = PaintingStyle.fill
        ..strokeWidth = (waveRadius == 28.0) ? 0 : 2;
      canvas.drawCircle(controlOffset, waveRadius, wavePaint1);
    }

    ///Create and locate triangles inside Draggable Button
    final trianglePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = draggableButtonIconsColor;

    ///FancyIndicatorUtils.triangleColor;

    const triangleHeight = 10.0;
    final triangleWidth = triangleHeight * 2 / sqrt(3);

    /// Top triangle
    final triangleTop = Path()
      ..moveTo(controlOffset.dx, controlOffset.dy - triangleHeight / 2 - 6)
      ..lineTo(controlOffset.dx + triangleWidth / 2,
          controlOffset.dy + triangleHeight / 2 - 6)
      ..lineTo(controlOffset.dx - triangleWidth / 2,
          controlOffset.dy + triangleHeight / 2 - 6)
      ..close();
    canvas.drawPath(triangleTop, trianglePaint);

    /// Bottom triangle
    final triangleBottom = Path()
      ..moveTo(controlOffset.dx, controlOffset.dy + triangleHeight / 2 + 6)
      ..lineTo(controlOffset.dx + triangleWidth / 2,
          controlOffset.dy + triangleHeight / 2 - 2)
      ..lineTo(controlOffset.dx - triangleWidth / 2,
          controlOffset.dy + triangleHeight / 2 - 2)
      ..close();
    canvas.drawPath(triangleBottom, trianglePaint);

    ///Generate measurement indicator
    final pathMetric = path.computeMetrics().first;
    const n = 60;
    final spaceBetweenLine = pathMetric.length / n;
    final linePaint = Paint()
      ..strokeWidth = 1.5
      ..color = draggableButtonIconsColor;

    ///FancyIndicatorUtils.triangleColor;

    for (var i = 0; i < n; i++) {
      final startPosition =
          pathMetric.getTangentForOffset(spaceBetweenLine * i)!.position -
              const Offset(10, 0);
      final endPosition = startPosition -
          Offset(i % 6 == 0 ? size.width * 0.08 : size.width * 0.06, 0);
      canvas.drawLine(startPosition, endPosition, linePaint);
    }

    ///draw selected indicator
    final selectedPercent =
        (100 - (100 * (wavePoint - (size.height * 0.1))) / (size.height * 0.8))
            .toInt();

    onShouldDraw(rect.contains(tapPosition) || validPressed, selectedPercent);

    final currentSelectedLabelPercent = FancyIndicatorUtils.generateParagraph(
      "$selectedPercent$numberAppendix",
      style: ui.TextStyle(
        color: selectedTextColor,
        fontSize: selectedTextSize,

        /// 30,
        fontWeight: FontWeight.bold,
      ),
    );
    canvas.drawParagraph(
      currentSelectedLabelPercent,
      Offset(16, wavePoint - currentSelectedLabelPercent.height / 2),
    );

    ///Generate and put text 0,10..100 and add marker
    int labelCount = 10;
    final spaceBetweenLabel = size.height * 0.8 / labelCount;
    int startValue = 10;
    for (var i = 0; i <= labelCount; i++) {
      final labelPercent = 10 * startValue--;
      final textStyle = ui.TextStyle(
        color: labelTextColor,
        fontSize: labelTextSize,

        ///20,
        fontWeight: FontWeight.bold,
      );
      final label = FancyIndicatorUtils.generateParagraph(
          "$labelPercent$numberAppendix",
          style: textStyle);
      Paint yellowCircle = Paint()..color = measureItemColor;

      /// Add Marker check marker list if it contains labelPercent then add marker
      if (marker.contains(labelPercent)) {
        canvas.drawCircle(
            Offset(
              10,
              spaceBetweenLabel * i + (size.height * 0.1) + label.height / 6,
            ),
            4,
            yellowCircle);
      }

      ///Hide labelPercent when selectedPercent getting near less than 5
      if (labelPercent - 5 >= selectedPercent ||
          labelPercent < selectedPercent - 5) {
        canvas.drawParagraph(
          label,
          Offset(20,
              spaceBetweenLabel * i + (size.height * 0.1) - label.height / 3),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
