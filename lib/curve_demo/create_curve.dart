import 'package:flutter/material.dart';

class CreateCurve extends StatefulWidget {
  const CreateCurve({super.key});

  @override
  State<CreateCurve> createState() => _CreateCurveState();
}

class _CreateCurveState extends State<CreateCurve> {
  //
  List<Offset> _points = [
    Offset(195, 50), // start point
    //
    Offset(325, 230), // control point 1
    Offset(60, 230), // control point 2
    //
    Offset(195, 430), // end point 1
    //
    Offset(315, 600), // control point 1
    Offset(60, 655), // control point 2
    //
    Offset(195, 810), // end point 2
    //
  ];
  //
  @override
  Widget build(BuildContext context) {
    //
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    //
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            //
            // DRAW CURVES
            for (int i = 0; i < _points.length - 1; i = i + 3)
              CustomPaint(
                painter: CurvePainter(
                  _points[i],
                  _points[i + 1],
                  _points[i + 2],
                  _points[i + 3],
                ),
              ),
            //
            // DRAW CIRCLE POINTS
            for (int index = 0; index < _points.length; index++)
              Positioned(
                top: _points[index].dy - 15,
                left: _points[index].dx - 15,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    //
                    final width = MediaQuery.sizeOf(context).width;
                    final height = MediaQuery.sizeOf(context).height;
                    //
                    final x = details.globalPosition.dx;
                    final y = details.globalPosition.dy;
                    //
                    if (x < 15 || x > (width - 15)) return;
                    if (y < 40 || y > (height - 20)) return;
                    //
                    _points[index] = Offset(x, y);
                    setState(() {});
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: index == 0 || (index % 3 == 0)
                            ? Colors.red
                            : Colors.blue,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  CurvePainter(
      this.startPoint, this.controlPoint1, this.controlPoint2, this.endPoint);
  //
  final Offset startPoint;
  final Offset controlPoint1;
  final Offset controlPoint2;
  final Offset endPoint;

  @override
  void paint(Canvas canvas, Size size) {
    //
    final Path path = Path()..moveTo(startPoint.dx, startPoint.dy);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    //
    canvas.drawLine(startPoint, controlPoint1, style());
    canvas.drawLine(controlPoint2, endPoint, style());
    //
    canvas.drawPath(path, style(Colors.red, 3));
    //
    canvas.drawCircle(
        Offset(startPoint.dx, startPoint.dy), 2, style(Colors.red, 3));
    canvas.drawCircle(
        Offset(endPoint.dx, endPoint.dy), 2, style(Colors.red, 3));
    //
    canvas.drawCircle(
        Offset(controlPoint1.dx, controlPoint1.dy), 2, style(Colors.blue, 3));
    canvas.drawCircle(
        Offset(controlPoint2.dx, controlPoint2.dy), 2, style(Colors.blue, 3));
  }

  Paint style([Color color = Colors.blue, double strokewidth = 1]) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
