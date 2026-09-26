import 'package:flutter/material.dart';

class CredAnimation extends StatefulWidget {
  const CredAnimation({super.key});

  @override
  State<CredAnimation> createState() => _CredAnimationState();
}

class _CredAnimationState extends State<CredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  double gradValueOne = 1;
  double gradValueTwo = 1;
  double gradValueThree = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _slideAnimation = Tween<double>(begin: 1, end: -0.4).animate(_controller);

    _slideAnimation.addListener(() {
      gradValueOne = _slideAnimation.value;
      if (_slideAnimation.value < 0) {
        gradValueOne = 0.0;
        gradValueTwo = _slideAnimation.value + 0.4;
        gradValueThree = gradValueTwo / 2;
      }
      else if (gradValueOne < 0.6) {
        gradValueTwo = gradValueOne + 0.4;
        gradValueThree = (gradValueOne + gradValueTwo) / 2;
      } else {
        gradValueTwo = 1.0;
        gradValueThree = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) => ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.transparent, Colors.black, Colors.transparent],
              stops: [gradValueOne, gradValueThree, gradValueTwo],
              // stops: [0.1, 0.3, 0.5],
              // stops: [1, 1, 1],  // start state
              // stops: [0, 0.0, 0.0], // end state
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox.expand(child: CustomPaint(painter: GridPainter())),
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
    for (double i = 1; i <= (size.height / 15) - 1; i++) {
      canvas.drawLine(Offset(0, 15 * i), Offset(size.width, 15 * i), paint);
    }

    // draw vertical lines
    for (double i = 1; i <= size.width / 15; i++) {
      canvas.drawLine(Offset(15 * i, 0), Offset(15 * i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
