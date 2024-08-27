import 'package:flutter/material.dart';

class CurvedAnimationPage extends StatefulWidget {
  const CurvedAnimationPage({super.key});

  @override
  CurvedAnimationPageState createState() => CurvedAnimationPageState();
}

class CurvedAnimationPageState extends State<CurvedAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ).drive(Tween<double>(begin: 0, end: 300));

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
      appBar: AppBar(title: const Text('Curved Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: _animation.value,
              width: _animation.value,
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
