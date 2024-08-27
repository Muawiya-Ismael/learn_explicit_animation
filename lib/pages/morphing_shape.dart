import 'package:flutter/material.dart';
import 'dart:math' as math;

class MorphingShapePage extends StatefulWidget {
  const MorphingShapePage({super.key});

  @override
  MorphingShapePageState createState() => MorphingShapePageState();
}

class MorphingShapePageState extends State<MorphingShapePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _morphAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _morphAnimation = Tween<double>(begin: 0, end: 1).animate(
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
      appBar: AppBar(title: const Text("Morphing Shape Animation")),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: CustomPaint(
                  painter: MorphingShapePainter(_morphAnimation.value),
                  child: const SizedBox(
                    width: 200,
                    height: 200,
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

class MorphingShapePainter extends CustomPainter {
  final double morphValue;

  MorphingShapePainter(this.morphValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final path = Path();
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 5; i++) {
      double theta = (2 * math.pi * i) / 5;
      double x = center.dx + radius * math.cos(theta) * (1 - morphValue);
      double y = center.dy + radius * math.sin(theta) * (1 - morphValue);
      path.lineTo(x, y);
    }
    path.close();

    final path2 = Path();
    for (int i = 0; i < 6; i++) {
      double theta = (2 * math.pi * i) / 6;
      double x = center.dx + radius * math.cos(theta) * morphValue;
      double y = center.dy + radius * math.sin(theta) * morphValue;
      path2.lineTo(x, y);
    }
    path2.close();

    final morphingPath = Path.combine(PathOperation.intersect, path, path2);
    canvas.drawPath(morphingPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}