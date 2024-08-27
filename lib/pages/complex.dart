import 'package:flutter/material.dart';
import 'dart:math' as math;

class ComplexAnimationPage extends StatefulWidget {
  const ComplexAnimationPage({super.key});

  @override
  ComplexAnimationPageState createState() => ComplexAnimationPageState();
}

class ComplexAnimationPageState extends State<ComplexAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _morphAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _lightPositionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _morphAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.teal,
      end: Colors.deepPurple,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _lightPositionAnimation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complex Morphing Shape Animation")),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: CustomPaint(
                  painter: ComplexShapePainter(
                    morphValue: _morphAnimation.value,
                    color: _colorAnimation.value!,
                    lightPosition: _lightPositionAnimation.value,
                  ),
                  child: const SizedBox(
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ComplexShapePainter extends CustomPainter {
  final double morphValue;
  final Color color;
  final double lightPosition;

  ComplexShapePainter({
    required this.morphValue,
    required this.color,
    required this.lightPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        center: Alignment(lightPosition, lightPosition),
        radius: 0.6,
        colors: [
          Colors.white.withOpacity(0.8),
          color.withOpacity(0.8),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final path = Path();
    final numSides = 5 + (1 * morphValue).round(); // 5 to 6 sides
    final angleOffset = 2 * math.pi / numSides;

    for (int i = 0; i < numSides; i++) {
      double theta = i * angleOffset + (morphValue * math.pi / 2);
      double x = center.dx + radius * math.cos(theta) * (1 - 0.3 * morphValue);
      double y = center.dy + radius * math.sin(theta) * (1 - 0.3 * morphValue);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
