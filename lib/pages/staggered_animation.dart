import 'package:flutter/material.dart';

class StaggeredAnimationPage extends StatefulWidget {
  const StaggeredAnimationPage({super.key});

  @override
  StaggeredAnimationPageState createState() => StaggeredAnimationPageState();
}

class StaggeredAnimationPageState extends State<StaggeredAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)));
    _animation2 = Tween<double>(begin: 0, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.6)));
    _animation3 = Tween<double>(begin: 0, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1)));

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
      appBar: AppBar(title: const Text('Staggered Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: _animation1.value, width: 100, color: Colors.blue),
                Container(height: _animation2.value, width: 100, color: Colors.green),
                Container(height: _animation3.value, width: 100, color: Colors.orange),
              ],
            );
          },
        ),
      ),
    );
  }
}
