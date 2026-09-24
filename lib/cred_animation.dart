import 'package:flutter/material.dart';

class CredAnimation extends StatefulWidget {
  const new({super.key});

  @override
  State<CredAnimation> createState() => _CredAnimationState();
}

class _CredAnimationState extends State<CredAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(child: CustomPaint(painter: GridPainter())),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.black;

    // draw horizontal lines
    for (double i = 1; i <= size.height / 20; i++) {
      canvas.drawLine(Offset(0, 20 * i), Offset(size.width, 20 * i), paint);
    }

    // draw vertical lines
    for (double i = 1; i <= size.width / 20; i++) {
      canvas.drawLine(Offset(20 * i, 0), Offset(20 * i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
