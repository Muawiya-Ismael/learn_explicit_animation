import 'package:flutter/material.dart';

class BasicAnimationPage extends StatefulWidget {
  const BasicAnimationPage({super.key});

  @override
  BasicAnimationPageState createState() => BasicAnimationPageState();
}

class BasicAnimationPageState extends State<BasicAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);

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
      appBar: AppBar(title: const Text('Basic Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: _animation.value,
              width: _animation.value,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
