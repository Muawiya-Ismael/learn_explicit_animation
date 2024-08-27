import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAnimationPage extends StatefulWidget {
  const CustomAnimationPage({super.key});

  @override
  CustomAnimationPageState createState() => CustomAnimationPageState();
}

class CustomAnimationPageState extends State<CustomAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: math.pi * 2).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1, end: 2).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Animation with AnimatedBuilder')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.purple,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
