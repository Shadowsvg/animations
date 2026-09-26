
import 'package:flutter/material.dart';

class CredAnimation extends StatefulWidget {
  const CredAnimation({super.key});

  @override
  State<CredAnimation> createState() => _CredAnimationState();
}

class _CredAnimationState extends State<CredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 2),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _slideAnimation,
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              stops: [0.0, 0.50, 0.50, 1.0], // Controls where the fading starts
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: 300,
            width: MediaQuery.sizeOf(context).width,
            child: CustomPaint(painter: GridPainter()),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.black;

    // draw horizontal lines
    for (double i = 1; i <= (size.height / 10) - 1; i++) {
      canvas.drawLine(Offset(0, 10 * i), Offset(size.width, 10 * i), paint);
    }

    // draw vertical lines
    for (double i = 1; i <= size.width / 10; i++) {
      canvas.drawLine(Offset(10 * i, 0), Offset(10 * i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
