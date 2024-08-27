import 'package:flutter/material.dart';

class AnimatedWidgetPage extends StatefulWidget {
  const AnimatedWidgetPage({super.key});

  @override
  AnimatedWidgetPageState createState() => AnimatedWidgetPageState();
}

class AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);

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
      appBar: AppBar(title: const Text('Custom Animation with AnimatedWidget')),
      body: Center(
        child: FadingContainer(animation: _opacityAnimation),
      ),
    );
  }
}

class FadingContainer extends AnimatedWidget {
  const FadingContainer({super.key, required Animation<double> animation})
      : super(listenable: animation);

  Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.teal,
      ),
    );
  }
}
