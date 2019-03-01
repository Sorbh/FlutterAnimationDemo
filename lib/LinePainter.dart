import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

class LinePainter extends CustomPainter {
//  Path path;
  Paint linePaint;
  double delta;

  LinePainter({this.delta}) {
    linePaint = Paint();
    linePaint.color = const Color(0xFF000000);
    linePaint.style = PaintingStyle.stroke;
    linePaint.strokeWidth = 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
//    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2);
    var radius = (size.width / 2) * delta;

    var path = Path();
    path.moveTo(center.dx, center.dy);
    double x = (center.dx + radius * cos(radians(-45)));
    double y = (center.dy + radius * sin(radians(-45)));
    path.lineTo(x, y);

    var path1 = Path();
    path1.moveTo(center.dx, center.dy);
    double x1 = (center.dx + radius * cos(radians(-90)));
    double y1 = (center.dy + radius * sin(radians(-90)));
    path1.lineTo(x1, y1);

    var path2 = Path();
    path2.moveTo(center.dx, center.dy);
    double x2 = (center.dx + radius * cos(radians(-135)));
    double y2 = (center.dy + radius * sin(radians(-135)));
    path2.lineTo(x2, y2);

    canvas.drawPath(path, linePaint);
    canvas.drawPath(path1, linePaint);
    canvas.drawPath(path2, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
